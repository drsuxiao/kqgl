unit BaseInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBClient, ExtCtrls, ADODB, Provider;

type
  TFormBaseInfo = class(TForm)
    pnlMain: TPanel;
    DataSource1: TDataSource;
    pnlQuery: TPanel;
    pnlData: TPanel;
    pnlFunction: TPanel;
    btnquery: TButton;
    btnnew: TButton;
    btnmodify: TButton;
    btndelete: TButton;
    btnclose: TButton;
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
    FilterSql,
    QuerySql,
    InsertSql,
    EditSql,
    DeleteSql: string;
    TitleNames: string;
  end;

var
  FormBaseInfo: TFormBaseInfo;

implementation
uses DM,publicrule,BaseInfoRule;
{$R *.dfm}

procedure TFormBaseInfo.btnnewClick(Sender: TObject);
begin
  BaseInfoRule.New(Insertsql);
end;  

procedure TFormBaseInfo.btnmodifyClick(Sender: TObject);
begin
  BaseInfoRule.Edit(Editsql);
end;

procedure TFormBaseInfo.btndeleteClick(Sender: TObject);
begin
  BaseInfoRule.Delete(Deletesql);
end;

procedure TFormBaseInfo.btncloseClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormBaseInfo.btnqueryClick(Sender: TObject);
begin
  BaseInfoRule.Query(Querysql);

  cds.Filter := FilterSql;
  cds.FilterOptions := [foCaseInsensitive];
  cds.Filtered := true;
end;

procedure TFormBaseInfo.refresh;
begin
  cds.Active := false;
  dspro.DataSet := dm.GetDataSet(QuerySql);
  cds.Data := dspro.Data;
  cds.Active := true;
  //数据表格显示，列宽初始化
  InitDBGrid(DBGrid1,TitleNames);
end;

procedure TFormBaseInfo.FormShow(Sender: TObject);
begin
  //refresh;
end;

procedure TFormBaseInfo.DBGrid1TitleClick(Column: TColumn);
begin
  //if (not column.Field is Tblobfield) then//Tblobfield不能索引，二进制
    cds.IndexFieldNames:=column.Field.FieldName;
end;

procedure TFormBaseInfo.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  publicrule.DBGridRecordSize(Column);
end;

end.
