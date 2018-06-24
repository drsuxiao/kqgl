unit ryxx_edit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ADODB, Provider, DB, DBClient;

type
  TFrmedit_ryxx = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    edtrybh: TEdit;
    Label2: TLabel;
    edtryxm: TEdit;
    label3: TLabel;
    cmbksmc: TComboBox;
    btnsave: TButton;
    btncancel: TButton;
    rdbtn: TRadioButton;
    cds: TClientDataSet;
    dspro: TDataSetProvider;
    procedure btncancelClick(Sender: TObject);
    procedure btnsaveClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    vflag: boolean;
  end;

var
  Frmedit_ryxx: TFrmedit_ryxx;

implementation
uses DM;
{$R *.dfm}

procedure TFrmedit_ryxx.btncancelClick(Sender: TObject);
begin
  ;
end;

procedure TFrmedit_ryxx.btnsaveClick(Sender: TObject);
var
  asql : string;
  afields,avalues: string;
begin
  if (trim(edtrybh.Text)='') or (trim(edtryxm.Text)='') then exit; 
  if rdbtn.Checked then
  begin
    afields := 'code,name,deptcode';
    avalues := format('''%s'',''%s'',''%s''',[trim(edtrybh.Text),trim(edtryxm.Text),inttostr(cmbksmc.ItemIndex)]);
    //asql := format('insert into ryxx(code,name,deptcode) values(''%s'',''%s'',''%s'')'
    //        ,[trim(edtrybh.Text),trim(edtryxm.Text),inttostr(cmbksmc.ItemIndex)]);
    if dm.AppendData('ryxx',afields,avalues) then
      showmessage('数据新增成功！');
  end
  else begin
    asql := format('update ryxx set code=''%s'',name=''%s'',deptcode=''%s'' where id=%d'
            ,[trim(edtrybh.Text),trim(edtryxm.Text),inttostr(cmbksmc.ItemIndex),strtoint(rdbtn.Caption)]);
    if dm.EditData(asql) then
      showmessage('数据修改成功！');
  end;
end;

end.
