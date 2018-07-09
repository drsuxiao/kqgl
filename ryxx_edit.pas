unit ryxx_edit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ADODB, Provider, DB, DBClient, ComCtrls;

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
    Label4: TLabel;
    cbsex: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    dtworkdate: TDateTimePicker;
    dtbirthday: TDateTimePicker;
    procedure btncancelClick(Sender: TObject);
    procedure btnsaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    vflag: boolean;
  end;

var
  Frmedit_ryxx: TFrmedit_ryxx;

implementation
uses DM,PublicRule;
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
    afields := 'code,name,sex,deptcode,workdate,birthday';
    avalues := format('''%s'',''%s'',''%s'',''%s'',''%s'',''%s''',[trim(edtrybh.Text),trim(edtryxm.Text),inttostr(cbsex.ItemIndex),GetComboxItemNo(cmbksmc),datetostr(dtworkdate.date),datetostr(dtbirthday.date)]);
    if dm.AppendData('employee',afields,avalues) then
      showmessage('数据新增成功！');
  end
  else begin

    asql := format('update employee set code=''%s'',name=''%s'',sex=''%s'',deptcode=''%s'',workdate=''%s'',birthday=''%s'' where id=%d'
            ,[trim(edtrybh.Text),trim(edtryxm.Text),inttostr(cbsex.ItemIndex),GetComboxItemNo(cmbksmc),datetostr(dtworkdate.date),datetostr(dtbirthday.date),strtoint(rdbtn.Caption)]);
    if dm.EditData(asql) then
      showmessage('数据修改成功！');
  end;
end;

procedure TFrmedit_ryxx.FormCreate(Sender: TObject);
begin
  PublicRule.InitDeptComboxList('deptcode','deptname','department',cmbksmc);
end;

end.
