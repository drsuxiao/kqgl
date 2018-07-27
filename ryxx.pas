unit ryxx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBClient, ExtCtrls, ADODB,
  Provider;

type
  TFrmryxx = class(TForm)
    Panel1: TPanel;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    btnquery: TButton;
    btnnew: TButton;
    btnmodify: TButton;
    btndelete: TButton;
    btnclose: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    cds: TClientDataSet;
    dspro: TDataSetProvider;
    DBGrid1: TDBGrid;
    procedure btnnewClick(Sender: TObject);
    procedure btncloseClick(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
    procedure btnmodifyClick(Sender: TObject);
    procedure btnqueryClick(Sender: TObject);
    procedure refresh;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frmryxx: TFrmryxx;

implementation
uses ryxx_edit,DM,publicrule;
{$R *.dfm}

procedure TFrmryxx.btnnewClick(Sender: TObject);
var
  aform: TFrmedit_ryxx;
begin
  aform := TFrmedit_ryxx.Create(nil);
  aform.rdbtn.Checked := true;
  if aform.ShowModal = 1 then
    refresh;
end;  

procedure TFrmryxx.btnmodifyClick(Sender: TObject);
{var

settings: TFormatSettings;

dt: TDateTime;

begin

GetLocaleFormatSettings(GetUserDefaultLCID, settings);

settings.DateSeparator := '-';

settings.TimeSeparator := ':';

settings.ShortDateFormat := 'yyyy-mm-dd';

settings.ShortTimeFormat := 'hh:nn:ss';dt:= strToDateTime('2010-3-19 08:09:10',settings);

end;}
var
  aform: TFrmedit_ryxx;
  //settings: TFormatSettings;
  //dt: TDateTime;
begin
  //解决不同系统时间格式不一致的问题
  {GetLocaleFormatSettings(GetUserDefaultLCID, settings);
  settings.DateSeparator := '-';
  settings.TimeSeparator := ':';
  settings.ShortDateFormat := 'yyyy-mm-dd';
  settings.ShortTimeFormat := 'hh:nn:ss'; }
  //dt:= strToDateTime('2010-3-19 08:09:10',settings);

  aform := TFrmedit_ryxx.Create(nil);
  try
    aform.rdbtn.Checked := false;
    aform.rdbtn.Caption := cds.FieldValues['id'];
    aform.edtrybh.Text := cds.FieldValues['code'];
    aform.edtryxm.Text := cds.FieldValues['name'];
    aform.cbsex.ItemIndex := cds.FieldValues['sex'];   
    aform.cmbksmc.ItemIndex := aform.cmbksmc.Items.IndexOfObject(tobject(cds.FieldByName('deptcode').AsInteger));
    if cds.FieldValues['workdate'] <> null then
      aform.dtworkdate.Date := strToDate(cds.FieldValues['workdate'],publicrule.DataFormatSet);//strtodatedef(cds.FieldValues['workdate'],strtodate('2018-01-01'));
    if cds.FieldValues['birthday'] <> null then
      aform.dtbirthday.Date := strToDate(cds.FieldValues['birthday'],publicrule.DataFormatSet);//strtodatedef(cds.FieldValues['birthday'],strtodate('2018-01-01'));
    if aform.ShowModal = 1 then
      refresh;
  except
    aform.Free;
  end;
end;

procedure TFrmryxx.btndeleteClick(Sender: TObject);
var
  asql: string;
begin
  if (cds.RecordCount > 0) and (MessageBox(0,'确定删除当前用户？','提示', mb_okcancel)=1) then
  begin
    asql := format('delete from employee where id=''%s''',[cds.FieldValues['id']]);
    dm.ExecuteSql(asql);
    refresh;
  end;
end;

procedure TFrmryxx.btncloseClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFrmryxx.btnqueryClick(Sender: TObject);
var
  asql: string;
begin
 refresh;
 if trim(edit1.Text) <> '' then
    asql := format('code like ''%%%s%%''',[trim(edit1.Text)])
  else
    asql := '';
  cds.Filter := asql;
  cds.FilterOptions := [foCaseInsensitive];
  cds.Filtered := true;
end;

procedure TFrmryxx.refresh;
var
  asql : string;
begin
  cds.Active := false;
  asql := 'SELECT e.id,e.code,e.name,e.sex,e.deptcode,d.deptname,e.workdate,e.birthday FROM employee e left join department d on e.deptcode=d.deptcode';
  dspro.DataSet := dm.GetDataSet(asql);
  cds.Data := dspro.Data;
  cds.Active := true;
  //数据表格显示，列宽初始化
  InitDBGrid(DBGrid1,'编号,工资号,姓名,性别,科室编号,科室名称,工作日期,出生日期');
end;

procedure TFrmryxx.FormShow(Sender: TObject);
begin
  //refresh;
end;

procedure TFrmryxx.DBGrid1TitleClick(Column: TColumn);
begin
  //if (not column.Field is Tblobfield) then//Tblobfield不能索引，二进制
    cds.IndexFieldNames:=column.Field.FieldName;
end;

procedure TFrmryxx.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  publicrule.DBGridRecordSize(Column);
end;

end.
