unit kqdjjm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, DBGrids, ExtCtrls, DB, ADODB,
  Provider, DBClient;

type
  Tfrmkqdjjm = class(TForm)
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    btncreate: TButton;
    btndelete: TButton;
    btnmodify: TButton;
    Panel3: TPanel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    cmbdept: TComboBox;
    dtfrom: TDateTimePicker;
    dtto: TDateTimePicker;
    btnquery: TButton;
    DataSource1: TDataSource;
    Button1: TButton;
    Button2: TButton;
    cds: TClientDataSet;
    dspro: TDataSetProvider;
    procedure btncreateClick(Sender: TObject);
    procedure btnmodifyClick(Sender: TObject);
    procedure btnqueryClick(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    function execute(vSql: string): boolean;
    procedure DBGridExport(GRID:TDBGRID);
    procedure refresh;
  public
    { Public declarations }
  end;

var
  frmkqdjjm: Tfrmkqdjjm;

implementation
uses kqdj,DateUtils,ComObj,dm,PublicRule;
{$R *.dfm}

procedure Tfrmkqdjjm.btncreateClick(Sender: TObject);
var
  asql: string;
  aform: TFrmkqdjnew;
  anow,aygbm,atype,adept,astdate,aspdate,asttime,asptime,amemo: string;
begin
  aform := TFrmkqdjnew.Create(nil);
  aform.cmbdept.Enabled := true;
  aform.cmbname.Enabled := true;
  aform.dtfrom.DateTime := now;
  aform.dtto.DateTime := now;
  if aform.ShowModal = mrOK then
  begin
    aygbm := copy(aform.cmbname.Text,1,6);
    atype := copy(aform.cmbtype.Text,1,2);
    adept := inttostr(aform.cmbdept.itemindex);
    anow := formatdatetime('yyyy-mm-dd',now);
    astdate := formatdatetime('yyyy-mm-dd',aform.dtfrom.datetime);
    aspdate := formatdatetime('yyyy-mm-dd',aform.dtto.datetime);
    asttime := aform.medt1.Text;
    asptime := aform.medt2.Text;
    amemo := aform.memo1.text;
    asql := format('insert into kqdj(ygbm,type,deptcode,djdate,startdate,stopdate,starttime,stoptime,memo) values(''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'')'
                                  ,[aygbm,atype,adept,anow,astdate,aspdate,asttime,asptime,amemo]);
    if execute(asql) then
      refresh;
  end;
  aform.free;
end;

function Tfrmkqdjjm.execute(vSql: string): boolean;
begin
  result := dm.ExecuteSql(vSql);
end;

procedure Tfrmkqdjjm.refresh;
var
  asql,adept,astdate,aspdate: string;
begin
  adept := inttostr(cmbdept.ItemIndex);
  astdate := formatdatetime('yyyy-mm-dd',dtfrom.datetime);
  aspdate := formatdatetime('yyyy-mm-dd',dtto.datetime);
  if adept='2' then
    asql := format('select * from view_kqdj where (startdate >= ''%s'' and startdate <=''%s'') or (stopdate >= ''%s'' and stopdate <=''%s'')',[astdate,aspdate,astdate,aspdate])
  else
    asql := format('select * from view_kqdj where deptcode=''%s'' and ((startdate >= ''%s'' and startdate <=''%s'') or (stopdate >= ''%s'' and stopdate <=''%s''))',[adept,astdate,aspdate,astdate,aspdate]);
  dspro.DataSet := dm.GetDataSet(asql);
  cds.Data := dspro.Data;
  cds.Active := true;
  FormatDisplaylable(cds,'id,工资编码,类型编码,类型名称,姓名,开始日期,开始时间,结束日期,结束时间,登记日期,科室,备注');
end;

procedure Tfrmkqdjjm.btnmodifyClick(Sender: TObject);
var
  asql: string;
  aform: TFrmkqdjnew;
  anow,aygbm,aname,atype,atypename,adept,astdate,aspdate,asttime,asptime,amemo: string;
  aid: integer;
begin
  if cds.RecordCount = 0 then exit;
  aform := TFrmkqdjnew.Create(nil);
  aform.cmbdept.Enabled := false;
  aform.cmbname.Enabled := false;
  aid := cds.fieldbyname('id').AsInteger;
  aygbm := trim(cds.fieldbyname('ygbm').AsString);
  aname := trim(cds.fieldbyname('name').AsString);
  atype := trim(cds.fieldbyname('type').AsString);
  atypename := trim(cds.fieldbyname('typename').AsString);
  adept := trim(cds.fieldbyname('deptcode').AsString);
  anow := trim(cds.fieldbyname('djdate').AsString);
  astdate := trim(cds.fieldbyname('startdate').AsString);
  aspdate := trim(cds.fieldbyname('stopdate').AsString);
  asttime := trim(cds.fieldbyname('starttime').AsString);
  asptime := trim(cds.fieldbyname('stoptime').AsString);
  amemo := trim(cds.fieldbyname('memo').AsString);
  aform.cmbdept.ItemIndex := strtoint(adept);
  aform.cmbdeptChange(nil);
  aform.cmbname.ItemIndex := aform.cmbname.Items.IndexOf(aygbm+','+aname);
  aform.cmbtype.ItemIndex := aform.cmbtype.Items.IndexOf(atype+','+atypename);
  aform.dtfrom.DateTime := strtodatetime(astdate);
  aform.dtto.DateTime := strtodatetime(aspdate);
  aform.medt1.Text := asttime;
  aform.medt2.Text := asptime;
  aform.Memo1.Text := amemo;
  if aform.ShowModal = mrOK then
  begin
    atype := copy(aform.cmbtype.Text,1,2);
    anow := formatdatetime('yyyy-mm-dd',now);
    astdate := formatdatetime('yyyy-mm-dd',aform.dtfrom.datetime);
    aspdate := formatdatetime('yyyy-mm-dd',aform.dtto.datetime);
    asttime := aform.medt1.Text;
    asptime := aform.medt2.Text;
    amemo := aform.memo1.text;
    asql := format('update kqdj set type=''%s'',djdate=''%s'',startdate=''%s'',stopdate=''%s'',starttime=''%s'',stoptime=''%s'',memo=''%s'' where id=%d and ygbm=''%s'' and deptcode=''%s'''
                                  ,[atype,anow,astdate,aspdate,asttime,asptime,amemo,aid,aygbm,adept]);
    if execute(asql) then
      refresh;
  end;
  aform.free;
end;

procedure Tfrmkqdjjm.btnqueryClick(Sender: TObject);
begin
  refresh;
end;

procedure Tfrmkqdjjm.btndeleteClick(Sender: TObject);
var
  asql: string;
begin
  if cds.RecordCount = 0 then exit;
  if MessageBox(0,'确定删除当前记录？','提示', mb_okcancel)=2 then exit;
  asql := format('delete from kqdj where id=%d',[cds.fieldbyname('id').AsInteger]);
  if execute(asql) then
    refresh;
end;

procedure Tfrmkqdjjm.FormShow(Sender: TObject);
begin
  dtfrom.DateTime := StartOfTheMonth(now);
  dtto.DateTime := EndOfTheMonth(now);
  cmbdept.ItemIndex := 2;
  refresh;
end;

procedure Tfrmkqdjjm.Button1Click(Sender: TObject);
begin
  self.Close;
end;

procedure Tfrmkqdjjm.Button2Click(Sender: TObject);
begin
  DBGridExport(DBGrid1);
end;

procedure Tfrmkqdjjm.DBGridExport(GRID:TDBGRID);

var       //DBGRID控件内容存储到EXCEL 只有第一行有标题
    EclApp:Variant;
    XlsFileName:String;
    sh:olevariant;
    i,j:integer;
    s:string;
    savedailog:TSaveDialog;
begin
   savedailog:=TSaveDialog.Create(Self);
   savedailog.Filter:='Excel files (*.xls)|*.XlS';
   savedailog.FileName := '考勤分类汇总.xls';
   if savedailog.Execute then begin
        xlsfilename:=savedailog.FileName;
        savedailog.Free;
     end
   else begin
      savedailog.Free;
      exit;
   end;
   try
      eclapp:=createOleObject('Excel.Application');
      sh:=CreateOleObject('Excel.Sheet');
   except
      showmessage('您的机器里未安装Microsoft Excel。');
      exit;
   end;
   try
      sh:=eclapp.workBooks.add;
      With Grid.DataSource.DataSet do begin
        First;
        i:=GRID.FieldCount-1;
        j:=i div 26;
        s:='';
        if j>0 then s:=s+chr(64+j);
        for i:=0 to grid.FieldCount-1  do begin
           if grid.Fields[i].Visible then begin
              eclapp.cells[2,i+1]:=grid.Fields[i].DisplayName;
              if GRID.Fields[i].DisplayWidth>80 then
                 eclapp.columns[i+1].Columnwidth:=80
              else
                 eclapp.columns[i+1].Columnwidth:=GRID.Fields[i].DisplayWidth+0.3;
              eclapp.cells[2,i+1].Font.Color:=clRed;
 //转EXCEL时过长的数字有截取现象。已改为用‘来解决，所以下面不需要了。
//              if (grid.Fields[i].DisplayName='身份证号') or (grid.Fields[i].DisplayName='银行帐号') then begin
//                 eclapp.columns[i+1].NumberFormat:='@';
//              end;
           end;
        end;
        for i:=1 to RecordCount do begin
            for j:=0 to grid.FieldCount-1 do
              if grid.Fields[j].Visible then
                 if GRID.Fields[j].DisplayText>'' then begin
//                   if length(grid.Fields[j].DisplayText)>=15 then
//                      eclapp.cells[i*2+1,j+1].NumberFormatLocal:='@';
                   eclapp.cells[i+2,j+1]:=grid.Fields[j].DisplayText;
                 end;
            Next;
        end;
     end;
      sh.saveas(xlsfilename);
      sh.close;
      eclapp.quit;
      ShowMessage('输出 Excel 文件已完成...');
   except
      showmessage('Excel系统出错！！！');
      sh.close;
      eclapp.quit;
      exit;
   end;
end;

end.
