unit dateselect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB, Provider, DBClient;

type
  TFrmDateselect = class(TForm)
    Label2: TLabel;
    Label1: TLabel;
    dtfrom: TDateTimePicker;
    dtto: TDateTimePicker;
    cbmfirst: TComboBox;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
    cmbdept: TComboBox;
    cds: TClientDataSet;
    dspro: TDataSetProvider;
    procedure FormShow(Sender: TObject);
    procedure cmbdeptChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure additems;
  public
    { Public declarations }
  end;

var
  FrmDateselect: TFrmDateselect;

implementation
uses DateUtils,dm,PublicRule;
{$R *.dfm}

procedure TFrmDateselect.additems;
var
  asql: string;
begin
  asql := format('(select t.code,e.name,t.deptcode,t.sqno from xh t left join employee e on t.code=e.code where t.deptcode=''%s'') t '
                 ,[PublicRule.GetComboxItemNo(cmbdept)]);
  {dspro.DataSet := dm.GetDataSet(asql);
  cds.Data := dspro.Data;
  cds.Active := true;
  if cds.RecordCount =0 then exit;
  cds.First;
  cbmfirst.Items.Clear;
  cbmfirst.Text := '';
  while not cds.Eof do
  begin
    cbmfirst.Items.Add(cds.Fields[0].AsString +' '+ cds.Fields[1].AsString);
    cds.Next;
  end;}
  InitDeptComboxList('code','name',asql,cbmfirst,'sqno');
end;

procedure TFrmDateselect.FormShow(Sender: TObject);
begin
  dtfrom.DateTime := StartOfTheMonth(now);
  dtto.DateTime := EndOfTheMonth(now);
  additems;
  cbmfirst.ItemIndex := 0;
end;

procedure TFrmDateselect.cmbdeptChange(Sender: TObject);
begin
  additems;
end;

procedure TFrmDateselect.FormCreate(Sender: TObject);
begin
  publicrule.InitDeptComboxList('deptcode','deptname','department',cmbdept);
end;

end.
