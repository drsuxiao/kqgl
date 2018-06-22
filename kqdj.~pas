unit kqdj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, DB, ADODB;

type
  TFrmkqdjnew = class(TForm)
    cmbtype: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cmbname: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    cmbdept: TComboBox;
    Label5: TLabel;
    dtfrom: TDateTimePicker;
    dtto: TDateTimePicker;
    Label6: TLabel;
    Label7: TLabel;
    medt1: TMaskEdit;
    medt2: TMaskEdit;
    btnOk: TButton;
    btncancel: TButton;
    ADODataSet1: TADODataSet;
    ADOCommand1: TADOCommand;
    Label8: TLabel;
    Memo1: TMemo;
    procedure cmbdeptChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frmkqdjnew: TFrmkqdjnew;

implementation

{$R *.dfm}

procedure TFrmkqdjnew.cmbdeptChange(Sender: TObject);
begin
  self.ADODataSet1.Active := false;
  self.ADODataSet1.CommandText := format('select rtrim(code)+'',''+rtrim(name) from ryxx where deptcode=''%s'' order by xh',[inttostr(cmbdept.ItemIndex)]);
  self.ADODataSet1.Active := true;
  if self.ADODataSet1.RecordCount =0 then exit;
  self.ADODataSet1.First;
  cmbname.Items.Clear;
  cmbname.Text := '';
  while not self.ADODataSet1.Eof do
  begin
    cmbname.Items.Add(ADODataSet1.Fields[0].AsString);
    self.ADODataSet1.Next;
  end;
end;

procedure TFrmkqdjnew.FormCreate(Sender: TObject);
begin
  self.ADODataSet1.Active := false;
  self.ADODataSet1.CommandText := format('select rtrim(code)+'',''+rtrim(name) from ryxx where deptcode=''%s'' order by xh',[inttostr(cmbdept.ItemIndex)]);
  self.ADODataSet1.Active := true;
  if self.ADODataSet1.RecordCount =0 then exit;
  self.ADODataSet1.First;
  cmbname.Items.Clear;
  cmbname.Text := '';
  while not self.ADODataSet1.Eof do
  begin
    cmbname.Items.Add(ADODataSet1.Fields[0].AsString);
    self.ADODataSet1.Next;
  end;

  self.ADODataSet1.Active := false;
  self.ADODataSet1.CommandText := 'select rtrim(typecode)+'',''+rtrim(typename) from type';
  self.ADODataSet1.Active := true;
  if self.ADODataSet1.RecordCount =0 then exit;
  self.ADODataSet1.First;
  cmbtype.Items.Clear;
  cmbtype.Text := '';
  while not self.ADODataSet1.Eof do
  begin
    cmbtype.Items.Add(ADODataSet1.Fields[0].AsString);
    self.ADODataSet1.Next;
  end;
end;

end.
