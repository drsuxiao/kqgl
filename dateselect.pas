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
  private
    { Private declarations }
    procedure additems;
  public
    { Public declarations }
  end;

var
  FrmDateselect: TFrmDateselect;

implementation
uses DateUtils,dm;
{$R *.dfm}

procedure TFrmDateselect.additems;
var
  asql: string;
begin
  asql := format('select code+name from ryxx where ifpb=1 and deptcode=''%s'' order by xh'
                 ,[inttostr(cmbdept.ItemIndex)]);
  dspro.DataSet := dm.GetDataSet(asql);
  cds.Data := dspro.Data;
  cds.Active := true;
  if cds.RecordCount =0 then exit;
  cds.First;
  cbmfirst.Items.Clear;
  cbmfirst.Text := '';
  while not cds.Eof do
  begin
    cbmfirst.Items.Add(cds.Fields[0].AsString);
    cds.Next;
  end;
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

end.
