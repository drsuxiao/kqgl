unit pbsxsz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Provider, DBClient;

type
  TFrmpbsx = class(TForm)
    ListBox1: TListBox;
    ListBox2: TListBox;
    btnadd: TButton;
    btndelete: TButton;
    btnaddall: TButton;
    btndelall: TButton;
    Label1: TLabel;
    cmbdept: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    btnmoveup: TButton;
    btnmovedown: TButton;
    btnsave: TButton;
    btnclose: TButton;
    cds: TClientDataSet;
    dspro: TDataSetProvider;
    procedure FormCreate(Sender: TObject);
    procedure btnaddClick(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
    procedure btnaddallClick(Sender: TObject);
    procedure btndelallClick(Sender: TObject);
    procedure btnmoveupClick(Sender: TObject);
    procedure btnmovedownClick(Sender: TObject);
    procedure btnsaveClick(Sender: TObject);
    procedure cmbdeptChange(Sender: TObject);
    procedure refresh;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FDeptCode: string;
    procedure InitEmployeelist();
    procedure InitRightlist();
    function GetDonelist(vDeptcode: string): string;
  public
    { Public declarations }
  end;

var
  Frmpbsx: TFrmpbsx;

implementation
uses DM,PublicRule;
{$R *.dfm}

procedure TFrmpbsx.FormCreate(Sender: TObject);
begin
  PublicRule.InitDeptComboxList('deptcode','deptname','department',cmbdept);
  FDeptcode := PublicRule.GetComboxItemNo(cmbdept);
end;

procedure TFrmpbsx.btnaddClick(Sender: TObject);
begin
  if listbox1.Items.Count <= 0 then  exit;
  if listbox1.ItemIndex < 0 then exit;
  listbox2.Items.Add(listbox1.Items.Strings[listbox1.ItemIndex]);
  listbox1.Items.Delete(listbox1.ItemIndex);
  listbox1.ItemIndex := 0;
end;

procedure TFrmpbsx.btndeleteClick(Sender: TObject);
begin
  if listbox2.Items.Count <= 0 then  exit;
  if listbox2.ItemIndex < 0 then exit;
  listbox1.Items.Add(listbox2.Items.Strings[listbox2.ItemIndex]);
  listbox2.Items.Delete(listbox2.ItemIndex);
  listbox2.ItemIndex := 0;
end;

procedure TFrmpbsx.btnaddallClick(Sender: TObject);
var
  i,j: integer;
begin
  if listbox1.Items.Count <= 0 then  exit;
  j := listbox1.Items.Count;
  for i:=0 to j -1 do
  begin
    listbox2.Items.Add(listbox1.Items.Strings[0]);
    listbox1.Items.Delete(0);
  end;
end;

procedure TFrmpbsx.btndelallClick(Sender: TObject);
var
  i,j: integer;
begin
  if listbox2.Items.Count <= 0 then  exit;
  j := listbox2.Items.Count;
  for i:=0 to j -1 do
  begin
    listbox1.Items.Add(listbox2.Items.Strings[0]);
    listbox2.Items.Delete(0);
  end;
end;

procedure TFrmpbsx.btnmoveupClick(Sender: TObject);
var
  i : integer;
begin
  if listbox2.Items.Count <= 0 then  exit;
  if listbox2.ItemIndex < 0 then exit;
  if listbox2.ItemIndex = 0 then
  begin
    listbox2.Items.Move(listbox2.ItemIndex,listbox2.Items.Count -1);
    listbox2.ItemIndex := listbox2.Items.Count -1;
  end  else
  begin
    i := listbox2.ItemIndex;
    listbox2.Items.Move(i,i-1);
    listbox2.ItemIndex := i-1;
  end;
end;

procedure TFrmpbsx.btnmovedownClick(Sender: TObject);
var
  i : integer;
begin
  if listbox2.Items.Count <= 0 then  exit;
  if listbox2.ItemIndex < 0 then exit;
  if listbox2.ItemIndex = listbox2.Items.Count -1 then
  begin
    listbox2.Items.Move(listbox2.ItemIndex,0);
    listbox2.ItemIndex := 0;
  end  else
  begin
    i := listbox2.ItemIndex;
    listbox2.Items.Move(i,i+1);
    listbox2.ItemIndex := i+1;
  end;
end;

procedure TFrmpbsx.btnsaveClick(Sender: TObject);
var
  i,j: integer;
  asql: string;
begin
  asql := format('delete from xh where deptcode=''%s'' ',[FDeptcode]);
  if listbox2.Items.Count > 0 then
  begin
    j := listbox2.Items.Count;
    for i:= 0 to j - 1 do
    begin
      asql := asql + ' ' +  format('insert into xh(code,deptcode,sqno) values(''%s'',''%s'',%d) ',[copy(listbox2.Items.Strings[i],0,6),FDeptcode,i+1]);
    end;
  end;
  try
  if dm.ExecuteSql(asql) then
    showmessage('±£´æ³É¹¦£¡');
  except

  end;
end;

procedure TFrmpbsx.cmbdeptChange(Sender: TObject);
begin
  refresh;
end;

procedure TFrmpbsx.refresh;
begin
  FDeptcode := PublicRule.GetComboxItemNo(cmbdept);
  InitEmployeelist;
  InitRightlist;
end;

procedure TFrmpbsx.FormShow(Sender: TObject);
begin
  refresh;
end;

procedure TFrmpbsx.InitEmployeelist;
var
  astr: string;
  asql: string;
begin
  asql := format('select code, name, deptcode from employee where deptcode=''%s'' and code not in(%s) '
                             ,[FDeptcode,self.GetDonelist(FDeptcode)]);
  dspro.DataSet := dm.GetDataSet(asql);
  cds.Data := dspro.Data;
  cds.Active := true;

  cds.First;
  listbox1.Items.Clear;
  while not cds.Eof do
  begin
    astr := cds.FieldByName('code').AsString +'  '+ cds.FieldByName('name').AsString;
    listbox1.Items.Add(astr);
    cds.Next;
  end;
end;

procedure TFrmpbsx.InitRightlist;
var
  astr: string;
  asql: string;
begin
  asql := format('select t.code,e.name from (select code,deptcode,sqno from xh where deptcode=''%s'') t left join employee e on t.code=e.code order by t.sqno'
                             ,[FDeptcode]);
  dspro.DataSet := dm.GetDataSet(asql);
  cds.Data := dspro.Data;
  cds.Active := true;

  cds.First;
  listbox2.Items.Clear;
  while not cds.Eof do
  begin
    astr := cds.FieldByName('code').AsString +'  '+ cds.FieldByName('name').AsString;
    listbox2.Items.Add(astr);
    cds.Next;
  end;
end;

function TFrmpbsx.GetDonelist(vDeptcode: string): string;
var
  astr: string;
  asql: string;
begin
  asql := format('select code, deptcode,sqno from xh where deptcode=''%s'' ',[vDeptcode]);
  dspro.DataSet := dm.GetDataSet(asql);
  cds.Data := dspro.Data;
  cds.Active := true;

  cds.First;
  astr := '1';
  while not cds.Eof do
  begin
    astr := astr + ',' + cds.FieldByName('code').AsString;
    cds.Next;
  end;
  result := astr;
end;

end.
