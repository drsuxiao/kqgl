unit scpbxx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, ADODB, DB, Grids, DBGrids,
  Provider, DBClient;

type
  TFrmscpbxx = class(TForm)
    btncreate: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    DataSource1: TDataSource;
    Panel3: TPanel;
    Label3: TLabel;
    cmbdept: TComboBox;
    btndelete: TButton;
    Label2: TLabel;
    Label1: TLabel;
    dtfrom: TDateTimePicker;
    dtto: TDateTimePicker;
    btnquery: TButton;
    btnmodify: TButton;
    Button1: TButton;
    cds: TClientDataSet;
    dspro: TDataSetProvider;
    cds1: TClientDataSet;
    dspro1: TDataSetProvider;
    DBGrid1: TDBGrid;
    procedure btncreateClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbdeptChange(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
    procedure btnqueryClick(Sender: TObject);
    procedure btnmodifyClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    FList1,Flist2: Tstringlist;
    //根据科室，是否继续上次排班，排班天数获取编码列表
    procedure SetCodelist(vDept: string; vBegin: integer);
    procedure refresh;
    function Execute(vSql: string):boolean;
    function IfOnlyCheck(adept,adt1,adt2: string): boolean;
    function GetCode(vNo: integer):string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frmscpbxx: TFrmscpbxx;

implementation
uses DateUtils,dateselect,modifypb,DM,PublicRule;
{$R *.dfm}

procedure TFrmscpbxx.btncreateClick(Sender: TObject);
var
  asql: string;
  adt1,adt2: tdatetime;
  aweek: string;
  i,j: integer;
  aform: TFrmDateselect;
  afirst,adept: string;
begin
  aform := TFrmDateselect.Create(nil);
  aform.Label4.Visible := true;
  aform.cbmfirst.Visible := true;
  if aform.ShowModal = mrCancel then
  begin
    aform.Free;
    exit;
  end;

  adt1 := aform.dtfrom.DateTime;
  adt2 := aform.dtto.DateTime;
  adept := publicrule.GetComboxItemNo(cmbdept);
  afirst := publicrule.GetComboxItemNo(aform.cbmfirst);//copy(trim(aform.cbmfirst.Items[aform.cbmfirst.ItemIndex]),1,6);  //获取当前选择的内容
  afirst := format('%.6d',[strtoint(afirst)]); //不足6位的前面补零
  if adt2-adt1 < 0 then exit;
  //执行存储过程
  asql := format('exec pro_create_schedule ''%s'',''%s'',''%s'',''%s'' '
   ,[FormatdateTime('yyyy-mm-dd',adt1),FormatdateTime('yyyy-mm-dd',adt2),afirst,adept]);
   dm.ExecuteSql(asql);
  {
  //日期重复性检测
  if IfOnlyCheck(inttostr(adept),FormatdateTime('yyyy-mm-dd',adt1),FormatdateTime('yyyy-mm-dd',adt2)) then
  begin
    showmessage('存在重复日期，请检查！');
    exit;
  end;
  i := 0;
  SetCodelist(inttostr(adept),afirst);
  while (adt2-adt1>=0) do
  begin
    aweek := inttostr(dayofweek(adt1));
    asql := asql + format(' insert into daylist(rq, week, ygbm,deptcode) values(''%s'',''%s'',''%s'',''%s'') '
      ,[FormatdateTime('yyyy-mm-dd',adt1),aweek,getcode(i),inttostr(adept)]);
    if i=0 then
      j := 999999
    else
      j := i -1;
    asql := asql + format(' update daylist set xxygbm=''%s'' where rq=''%s'' and deptcode=''%s'' ',[getcode(j),formatdatetime('yyyy-mm-dd',adt1),inttostr(adept)]);
    adt1 := incday(adt1);
    i := i+1;
  end;


  if execute(asql) then
  begin
    showmessage('成功生成排班表！');
    refresh;
  end else
    showmessage('生成排班表失败！');
  aform.Free; }
end;

procedure TFrmscpbxx.CheckBox1Click(Sender: TObject);
begin
//继续上次排班，则开始日期固定好


//不继续上次排班，重新排班则无需固定开始日期
end;

procedure TFrmscpbxx.SetCodelist(vDept: string; vBegin: integer);
var
  astr,s : string;
  n: integer;
begin
  dspro1.DataSet := dm.GetDataSet(format('select code from ryxx where ifpb=1 and deptcode=''%s'' order by xh',[vDept]));
  cds1.Data := dspro1.Data;
  cds1.Active := true;

  n := cds1.RecordCount;
  if  n=0 then exit;
  cds1.First;
  astr := '';
  while not cds1.Eof do
  begin
    astr := astr +','+ cds1.Fields[0].AsString;
    cds1.Next;
  end;
  astr := copy(astr,2,length(astr)-1);
  if vBegin = 1 then
    s := copy(astr,1,length(astr))
  else
    s := copy(astr,(vBegin-1)*6+vBegin,(n-(vBegin-1))*6+(n-(vBegin-1))-1);//每个工资编码长度为6，计算截取字符串的起始位置，注意每个逗号分隔符所占的位置

  FList1.Delimiter := ',';
  Flist1.DelimitedText := s;    //s为截取后的工资编号
  FList2.Delimiter := ',';
  Flist2.DelimitedText := astr;  //为完整的工资编号
end;

procedure TFrmscpbxx.FormShow(Sender: TObject);
begin
  FList1 := Tstringlist.Create;
  FList2 := Tstringlist.Create;
  dtfrom.DateTime := StartOfTheMonth(now);
  dtto.DateTime := EndOfTheMonth(now);
  publicrule.InitDeptComboxList('deptcode','deptname','department',cmbdept);
  //refresh;
end;

procedure TFrmscpbxx.refresh;
var
  adt1,adt2,asql: string;
begin
  adt1 := formatdatetime('yyyy-mm-dd',dtfrom.DateTime);
  adt2 := formatdatetime('yyyy-mm-dd',dtto.DateTime);
  asql := format('select id,rq,deptcode,deptname,ifmodify,ygbm,name,week,weekname from view_pbxx where deptcode=''%s'' and rq >= ''%s'' and rq <=''%s'' order by deptcode,rq'
                                        ,[publicrule.GetComboxItemNo(cmbdept),adt1,adt2]);
  dspro.DataSet := dm.GetDataSet(asql);
  cds.Data := dspro.Data;
  cds.Active := true;
  Initdbgrid(DBGrid1,'ID,日期,部门编码,部门名称,是否修改,工资编号,姓名,第几天,星期');
end;

procedure TFrmscpbxx.cmbdeptChange(Sender: TObject);
begin
  //refresh;
end;

procedure TFrmscpbxx.btndeleteClick(Sender: TObject);
var
  asql: string;
  aform: TFrmDateselect;
begin
  aform := TFrmDateselect.Create(nil);
  aform.Label4.Visible := false;
  aform.cbmfirst.Visible := false;
  if aform.ShowModal = mrOk then
  begin
    asql := format('delete from daylist where deptcode=''%s'' and rq >=''%s'' and rq <= ''%s'''
                  ,[publicrule.GetComboxItemNo(cmbdept),formatdatetime('yyyy-mm-dd',aform.dtfrom.DateTime),formatdatetime('yyyy-mm-dd',aform.dtto.DateTime)]);
    if Execute(asql) then
      refresh;
  end;
  aform.Free;
end;
function TFrmscpbxx.Execute(vSql: string): boolean;
begin
  result := dm.ExecuteSql(vsql);
end;

procedure TFrmscpbxx.btnqueryClick(Sender: TObject);
begin
  refresh;
end;

procedure TFrmscpbxx.btnmodifyClick(Sender: TObject);
var
  aform: TFrmModifypb;
  asql,aoldcode,acode,arq,adept: string;
begin
  aform := TFrmModifypb.Create(nil);
  if aform.ShowModal = mrOk then
  begin
    aoldcode := copy(trim(aform.edtold.Text),1,6);
    acode := copy(trim(aform.cmbnew.Text),1,6);
    arq := formatdatetime('yyyy-mm-dd',aform.dtrq.datetime);
    adept := publicrule.GetComboxItemNo(aform.cmbdept);
    asql := format('update daylist set ifmodify=1,ygbm=''%s'' where rq=''%s'' and deptcode=''%s'' and ygbm=''%s'' ',[acode,arq,adept,aoldcode]);
    arq := formatdatetime('yyyy-mm-dd',incday(aform.dtrq.datetime));
    asql := asql + format(' update daylist set xxygbm=''%s'' where rq=''%s'' and deptcode=''%s'' ',[acode,arq,adept]);
    if execute(asql) then
      refresh;
  end;
  aform.Free;
end;

function TFrmscpbxx.IfOnlyCheck(adept, adt1, adt2: string): boolean;
begin
  dspro1.DataSet := dm.GetDataSet(format('select ygbm from daylist where deptcode=''%s'' and rq >= ''%s'' and rq <= ''%s'' ',[adept, adt1, adt2]));
  cds1.Data := dspro1.Data;
  cds1.Active := true;

  if cds1.RecordCount > 0 then
    result := true
  else
    result := false;
end;



function TFrmscpbxx.GetCode(vNo: integer): string;
var
  i,acount1,acount2 : integer;
begin
  acount1 := flist1.Count;
  acount2 := flist2.Count;
  if vNo > 999990 then  //两日期相差的天数超过999990 返回空
  begin
    result := '';
    exit;
  end;
  if vNo < acount1 then //排版的天数少于排版人数时 ，vNo是从0开始
  begin
    i := vNo;
    result := flist1.Strings[i];
  end
  else if (vNo-acount1) < acount2 then // vNo-acount1 从0开始取完整排版人数列表
  begin
    i := vNo-acount1;
    result := flist2.Strings[i]; //天数大于等于排版人数时，取模从0开始
  end
  else begin
    i := (vNo-acount1) mod acount2;
    result := flist2.Strings[i];
  end;
end;

procedure TFrmscpbxx.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Flist1.Free;
  flist2.Free;
end;

procedure TFrmscpbxx.Button1Click(Sender: TObject);
begin
  self.Close;
end;

procedure TFrmscpbxx.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  DBGridRecordSize(Column);
end;

procedure TFrmscpbxx.DBGrid1TitleClick(Column: TColumn);
begin
  cds.IndexFieldNames:=column.Field.FieldName;
end;

end.
