unit test;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ADOQuery1: TADOQuery;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses SQLADOPoolUnit;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  try
    ADOQuery1.Connection:= ADOPool.GetCon(ADOConfig);
    ADOQuery1.Open;
  finally
    ADOPool.PutCon(ADOQuery1.Connection);
  end;
end;

initialization
   ADOConfig := TADOConfig.Create('SERVERDB.LXH');
   ADOPool := TADOPool.Create(2);
finalization
   //ADOPool.Free;
   //ADOConfig.Free;
end.
