unit kqqktj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids, ExtCtrls;

type
  TFrmkqqktj = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    cmbyear: TComboBox;
    cmbmonth: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    cmbdept: TComboBox;
    Panel1: TPanel;
    Panel2: TPanel;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ADODataSet1: TADODataSet;
    btnquery: TButton;
    ADODataSet2: TADODataSet;
    ADODataSet3: TADODataSet;
    procedure btnqueryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frmkqqktj: TFrmkqqktj;

implementation
uses DateUtils;
{$R *.dfm}

procedure TFrmkqqktj.btnqueryClick(Sender: TObject);
var
  asql,awhere,avalue: string;
  aname,arest,atype,aweek,aholiday: string;
  adt,adt1,adt2: Tdatetime;
  adept,arq,aygbm: string;
  i,j: integer;
begin
  if cmbdept.ItemIndex > 1 then
    awhere := 'where 1=1'
  else
    awhere := format('where deptcode=''%s'' ',[inttostr(cmbdept.ItemIndex)]);
  self.ADODataSet1.Active := false;
  self.ADODataSet1.CommandText := format('select * from view_kqtj %s order by rq',[awhere]);
  self.ADODataSet1.Active := true;
  if self.ADODataSet1.RecordCount = 0 then exit;
  self.ADODataSet2.Active := false;
  self.ADODataSet2.CommandText := format('select * from ryxx %s',[awhere]);
  self.ADODataSet2.Active := true;
  if self.ADODataSet2.RecordCount = 0 then exit;
  self.ADODataSet3.Active := false;
  self.ADODataSet3.CommandText := format('select * from view_kqdj %s ',[awhere]);
  self.ADODataSet3.Active := true;
  if self.ADODataSet3.RecordCount = 0 then exit;

  adt := strtodatetime(trim(cmbyear.Text)+'-'+trim(cmbmonth.Text)+'-'+'01');
  adt1 := startofthemonth(adt);
  adt2 := endofthemonth(adt);
  adept := inttostr(cmbdept.ItemIndex);
  ADODataSet2.First;
  for i:=1 to ADODataSet2.RecordCount do
  begin
    asql := asql + format(' select ''%s'' as ''%s'' ',[ADODataSet2.fieldbyname('name').AsString,'姓名\日期']);
    aygbm := ADODataSet2.fieldbyname('code').AsString;
    adt1 := strtodatetime(trim(cmbyear.Text)+'-'+trim(cmbmonth.Text)+'-'+'01');
    while adt2-adt1 >= 0 do
    begin
      arq := formatdatetime('yyyy-mm-dd',adt1);
      aname := vartostrdef(self.ADODataSet1.Lookup('deptcode;rq;ygbm',vararrayof([adept,arq,aygbm]),'name'),'');
      arest := vartostrdef(self.ADODataSet1.Lookup('deptcode;rq;xxygbm',vararrayof([adept,arq,aygbm]),'rq'),'');
      self.ADODataSet3.Active := false;
      self.ADODataSet3.CommandText := format('select * from view_kqdj %s and ygbm=''%s'' and ''%s'' >=startdate and ''%s'' <= stopdate',[awhere,aygbm,arq,arq]);
      self.ADODataSet3.Active := true;
      atype := vartostrdef(self.ADODataSet3.Lookup('deptcode;ygbm',vararrayof([adept,aygbm]),'typename'),'');
      aweek := vartostrdef(self.ADODataSet1.Lookup('deptcode;rq',vararrayof([adept,arq]),'ifweek'),'');
      aholiday := vartostrdef(self.ADODataSet1.Lookup('deptcode;rq',vararrayof([adept,arq]),'holiday'),'');
      if aname <> '' then
        avalue := '''值班'''
      else if arest <> '' then
        avalue := '''休息'''
      else if atype <> '' then
        avalue := ''''+trim(atype)+''''
      else if aholiday <> '' then
        avalue := '''假日'''
      else if aweek <> '' then
        avalue := '''周末'''
      else
        avalue := '''上班''';
      asql := asql +','+avalue+format(' as ''%s'' ',[formatdatetime('dd',adt1)]);
      adt1 := adt1 + 1;
    end;
    if i < ADODataSet2.RecordCount then
      asql := asql + ' union all ';
    ADODataSet2.Next;
  end;
  self.ADODataSet1.Active := false;
  self.ADODataSet1.CommandText := asql;
  self.ADODataSet1.Active := true;
end;

procedure TFrmkqqktj.FormShow(Sender: TObject);
begin
  cmbyear.Items.Clear;
  cmbyear.Items.Add(formatdatetime('yyyy',now));
  cmbyear.Items.Add(formatdatetime('yyyy',incyear(now,-1)));
  cmbyear.Items.Add(formatdatetime('yyyy',incyear(now,-2)));
  cmbyear.Items.Add(formatdatetime('yyyy',incyear(now,-3)));
  cmbyear.Items.Add(formatdatetime('yyyy',incyear(now,-4)));
  cmbyear.Items.Add(formatdatetime('yyyy',incyear(now,-5)));
  cmbyear.ItemIndex := 0;
  cmbmonth.ItemIndex := strtoint(formatdatetime('mm',now))-1;
end;

end.
