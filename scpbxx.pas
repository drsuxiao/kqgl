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
    //���ݿ��ң��Ƿ�����ϴ��Ű࣬�Ű�������ȡ�����б�
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
  afirst,adept: integer;
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
  adept := aform.cmbdept.ItemIndex;
  afirst := aform.cbmfirst.ItemIndex+1;

  if adt2-adt1 < 0 then exit;
  //�����ظ��Լ��
  if IfOnlyCheck(inttostr(adept),FormatdateTime('yyyy-mm-dd',adt1),FormatdateTime('yyyy-mm-dd',adt2)) then
  begin
    showmessage('�����ظ����ڣ����飡');
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
    showmessage('�ɹ������Ű����');
    refresh;
  end else
    showmessage('�����Ű��ʧ�ܣ�');
  aform.Free;
end;

procedure TFrmscpbxx.CheckBox1Click(Sender: TObject);
begin
//�����ϴ��Ű࣬��ʼ���ڹ̶���


//�������ϴ��Ű࣬�����Ű�������̶���ʼ����
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
    s := copy(astr,(vBegin-1)*6+vBegin,(n-(vBegin-1))*6+(n-(vBegin-1))-1);//ÿ�����ʱ��볤��Ϊ6�������ȡ�ַ�������ʼλ�ã�ע��ÿ�����ŷָ�����ռ��λ��

  FList1.Delimiter := ',';
  Flist1.DelimitedText := s;    //sΪ��ȡ��Ĺ��ʱ��
  FList2.Delimiter := ',';
  Flist2.DelimitedText := astr;  //Ϊ�����Ĺ��ʱ��
end;

procedure TFrmscpbxx.FormShow(Sender: TObject);
begin
  FList1 := Tstringlist.Create;
  FList2 := Tstringlist.Create;
  dtfrom.DateTime := StartOfTheMonth(now);
  dtto.DateTime := EndOfTheMonth(now);
  cmbdept.ItemIndex := 0;
  //refresh;
end;

procedure TFrmscpbxx.refresh;
var
  adt1,adt2,asql: string;
begin
  adt1 := formatdatetime('yyyy-mm-dd',dtfrom.DateTime);
  adt2 := formatdatetime('yyyy-mm-dd',dtto.DateTime);
  asql := format('select id,rq,deptcode,deptname,ifmodify,ygbm,name,week,weekname,xh from view_pbxx where deptcode=''%s'' and rq >= ''%s'' and rq <=''%s'' order by deptcode,rq'
                                        ,[inttostr(cmbdept.ItemIndex),adt1,adt2]);
  dspro.DataSet := dm.GetDataSet(asql);
  cds.Data := dspro.Data;
  cds.Active := true;
  Initdbgrid(DBGrid1,'ID,����,���ű���,��������,�Ƿ��޸�,���ʱ��,����,�ڼ���,����,���');
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
                  ,[inttostr(aform.cmbdept.ItemIndex),formatdatetime('yyyy-mm-dd',aform.dtfrom.DateTime),formatdatetime('yyyy-mm-dd',aform.dtto.DateTime)]);
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
    adept := inttostr(aform.cmbdept.itemindex);
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
  if vNo > 999990 then  //������������������999990 ���ؿ�
  begin
    result := '';
    exit;
  end;
  if vNo < acount1 then //�Ű�����������Ű�����ʱ ��vNo�Ǵ�0��ʼ
  begin
    i := vNo;
    result := flist1.Strings[i];
  end
  else if (vNo-acount1) < acount2 then // vNo-acount1 ��0��ʼȡ�����Ű������б�
  begin
    i := vNo-acount1;
    result := flist2.Strings[i]; //�������ڵ����Ű�����ʱ��ȡģ��0��ʼ
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