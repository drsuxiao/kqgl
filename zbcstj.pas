unit zbcstj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, ExtCtrls, Provider,
  DBClient;

type
  Tfrmzbcstj = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    Label4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cmbdept: TComboBox;
    cmbyear: TComboBox;
    cmbmonth: TComboBox;
    btnquery: TButton;
    cds: TClientDataSet;
    dspro: TDataSetProvider;
    procedure btnqueryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmzbcstj: Tfrmzbcstj;

implementation
uses DateUtils,dm,publicrule;
{$R *.dfm}

procedure Tfrmzbcstj.btnqueryClick(Sender: TObject);
var
  adt,asql: string;
begin
  adt := trim(cmbyear.Text)+'-'+trim(cmbmonth.Text);
  asql := format('exec pro_cal_zbdays ''%s'',''%s'' ',[trim(cmbyear.Text),trim(cmbmonth.Text)]);
  dm.ExecuteSql(asql);
  asql := format('select deptcode, rq, ygbm,name, zbcs from view_zbcstj where deptcode=''%s'' and rq = ''%s'' order by deptcode,rq'
                                        ,[publicrule.GetComboxItemNo(cmbdept),adt]);
  dspro.DataSet := dm.GetDataSet(asql);
  cds.Data := dspro.Data;
  cds.Active := true;
  InitDbgrid(dbgrid1,'部门,日期,工资编号,姓名,值班天数');
end;

procedure Tfrmzbcstj.FormShow(Sender: TObject);
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

  //btnqueryClick(nil);
end;

procedure Tfrmzbcstj.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  DBGridRecordSize(Column);
end;

procedure Tfrmzbcstj.DBGrid1TitleClick(Column: TColumn);
begin
  cds.IndexFieldNames:=column.Field.FieldName;
end;

procedure Tfrmzbcstj.FormCreate(Sender: TObject);
begin
  publicrule.InitDeptComboxList('deptcode','deptname','department',cmbdept);
end;

end.
