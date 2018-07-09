unit modifypb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB, Provider, DBClient;

type
  TFrmModifypb = class(TForm)
    cmbnew: TComboBox;
    edtold: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    dtrq: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    Label5: TLabel;
    cmbdept: TComboBox;
    cds: TClientDataSet;
    dspro: TDataSetProvider;
    procedure FormShow(Sender: TObject);
    procedure cmbdeptChange(Sender: TObject);
    function GetCodeName(vDate,vDept: string): string;
    procedure dtrqChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure additems;
  public
    { Public declarations }
  end;

var
  FrmModifypb: TFrmModifypb;

implementation
uses DM,publicrule;
{$R *.dfm}

procedure TFrmModifypb.FormShow(Sender: TObject);
begin
  dtrq.DateTime := now;
  additems;
  edtold.Enabled := false;
  edtold.Text := GetCodeName(formatdatetime('yyyy-mm-dd',dtrq.DateTime),publicrule.GetComboxItemNo(cmbdept));
end;

procedure TFrmModifypb.additems;
var
  asql: string;
begin
  asql := format('select t.code,e.name,t.deptcode from xh t left join employee e on t.code=e.code where t.deptcode=''%s'' order by t.sqno'
                 ,[PublicRule.GetComboxItemNo(cmbdept)]);
  dspro.DataSet := dm.GetDataSet(asql);
  cds.Data := dspro.Data;
  cds.Active := true;

  if cds.RecordCount =0 then exit;
  cds.First;
  cmbnew.Items.Clear;
  while not cds.Eof do
  begin
    cmbnew.Items.Add(cds.Fields[0].AsString +' '+ cds.Fields[1].AsString);
    cds.Next;
  end;
end;

procedure TFrmModifypb.cmbdeptChange(Sender: TObject);
begin
  additems;
  edtold.Text := GetCodeName(formatdatetime('yyyy-mm-dd',dtrq.DateTime),publicrule.GetComboxItemNo(cmbdept));
end;

function TFrmModifypb.GetCodeName(vDate, vDept: string): string;
var
  asql: string;
begin
  asql := format('select ygbm+name from view_pbxx where rq=''%s'' and deptcode=''%s''',[vDate,vDept]);
  dspro.DataSet := dm.GetDataSet(asql);
  cds.Data := dspro.Data;
  cds.Active := true;

  if cds.RecordCount > 0 then
    result := cds.Fields[0].AsString
  else
    result := '';
end;

procedure TFrmModifypb.dtrqChange(Sender: TObject);
begin
  edtold.Text := GetCodeName(formatdatetime('yyyy-mm-dd',dtrq.DateTime),publicrule.GetComboxItemNo(cmbdept));
end;

procedure TFrmModifypb.FormCreate(Sender: TObject);
begin
  publicrule.InitDeptComboxList('deptcode','deptname','department',cmbdept);
end;

end.
