unit kqflhz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, DB, ADODB, Grids, DBGrids, ExtCtrls,
  DBClient, Provider;

type
  Tfrmkqflhz = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    dtfrom: TDateTimePicker;
    dtto: TDateTimePicker;
    DataSource1: TDataSource;
    Button1: TButton;
    Label3: TLabel;
    cmbdept: TComboBox;
    Button2: TButton;
    Label4: TLabel;
    Cmbtype: TComboBox;
    cds: TClientDataSet;
    dspro: TDataSetProvider;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure refresh;
  public
    { Public declarations }
  end;

var
  frmkqflhz: Tfrmkqflhz;

implementation
uses DateUtils,ComObj,dm,publicrule;
{$R *.dfm}

procedure Tfrmkqflhz.FormShow(Sender: TObject);
begin
  dtfrom.DateTime := StartOfTheMonth(now);
  dtto.DateTime := EndOfTheMonth(now);
  cmbdept.ItemIndex := 2;
  refresh;
end;

procedure Tfrmkqflhz.refresh;
var
  adt1,adt2,asql,awhere: string;
begin
  adt1 := formatdatetime('yyyy-mm-dd',dtfrom.DateTime);
  adt2 := formatdatetime('yyyy-mm-dd',dtto.DateTime);
  if cmbtype.ItemIndex = 0 then
    awhere := ''
  else
    awhere := format(' and type=''%s'' ',[copy(cmbtype.Text,1,2)]);
  if cmbdept.ItemIndex > 1 then
    asql := format('select * from (select ygbm,name,type,typename,sum(days) as days from (select * from view_kqhours where startdate >= ''%s'' and stopdate <=''%s'' %s) as a group by ygbm,name,type,typename ) as b order by ygbm,type'
                                        ,[adt1,adt2,awhere])
  else
    asql := format('select * from (select ygbm,name,type,typename,sum(days) as days from (select * from view_kqhours where deptcode=''%s'' and startdate >= ''%s'' and stopdate <=''%s'' %s) as a group by ygbm,name,type,typename ) as b order by ygbm,type'
                                        ,[inttostr(cmbdept.ItemIndex),adt1,adt2,awhere]);

  dspro.DataSet := dm.GetDataSet(asql);
  cds.Data := dspro.data;
  cds.Active := true;
  publicrule.FormatDisplaylable(cds,'编号,姓名,类型编码,类型名称,天数');
  DBGridAutoSize(DBGrid1);
end;

procedure Tfrmkqflhz.Button1Click(Sender: TObject);
begin
  refresh;
end;

procedure Tfrmkqflhz.Button2Click(Sender: TObject);
begin
  DBGridExport(self.DBGrid1);
end;

procedure Tfrmkqflhz.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  DBGridRecordSize(Column);
end;

end.
