unit DeptEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormDeptedit = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    deptcode: TEdit;
    deptname: TEdit;
    depttype: TEdit;
    Panel2: TPanel;
    btsave: TButton;
    btcancle: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDeptedit: TFormDeptedit;

implementation

{$R *.dfm}

end.
