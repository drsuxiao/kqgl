unit dateselect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB;

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
    ADODataSet1: TADODataSet;
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
uses DateUtils;
{$R *.dfm}

procedure TFrmDateselect.additems;
begin
  self.ADODataSet1.Active := false;
  self.ADODataSet1.CommandText := format('select code+name from ryxx where ifpb=1 and deptcode=''%s'' order by xh',[inttostr(cmbdept.ItemIndex)]);
  self.ADODataSet1.Active := true;
  if self.ADODataSet1.RecordCount =0 then exit;
  self.ADODataSet1.First;
  cbmfirst.Items.Clear;
  cbmfirst.Text := '';
  while not self.ADODataSet1.Eof do
  begin
    cbmfirst.Items.Add(ADODataSet1.Fields[0].AsString);
    self.ADODataSet1.Next;
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
