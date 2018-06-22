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
    DBGrid1: TDBGrid;
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
    procedure btnnewClick(Sender: TObject);
    procedure btncloseClick(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
    procedure btnmodifyClick(Sender: TObject);
    procedure btnqueryClick(Sender: TObject);
    procedure refresh;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FormatDisplaylable(var vDataSet: Tclientdataset; vFields: string);
  end;

var
  Frmryxx: TFrmryxx;

implementation
uses ryxx_edit,DM;
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
var
  aform: TFrmedit_ryxx;
begin
  aform := TFrmedit_ryxx.Create(nil);
  try
    aform.rdbtn.Checked := false;
    aform.rdbtn.Caption := cds.FieldValues['id'];
    aform.edtrybh.Text := cds.FieldValues['code'];
    aform.edtryxm.Text := cds.FieldValues['name'];
    aform.cmbksmc.ItemIndex := cds.FieldValues['deptcode'];
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
    asql := format('delete from ryxx where id=''%s''',[cds.FieldValues['id']]);
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
  asql := 'select id, code, name, deptcode from ryxx';
  dspro.DataSet := dm.GetDataSet(asql);
  cds.Data := dspro.Data;
  cds.Active := true;
  FormatDisplaylable(cds,'编号,工资号,姓名,科室');
end;

procedure TFrmryxx.FormShow(Sender: TObject);
begin
  refresh;
end;

procedure TFrmryxx.DBGrid1TitleClick(Column: TColumn);
begin
  //if (not column.Field is Tblobfield) then//Tblobfield不能索引，二进制
    cds.IndexFieldNames:=column.Field.FieldName;
end;

//提取公共方法  格式化字段名称
procedure TFrmryxx.FormatDisplaylable(var vDataSet: Tclientdataset; vFields: string);
var
  alist: Tstringlist;
  i: integer;
begin
  alist := tstringlist.Create;
  alist.CommaText := vFields;
  for i := 0 to alist.Count - 1 do
    vDataSet.Fields[i].DisplayLabel := alist[i];
end;

end.
