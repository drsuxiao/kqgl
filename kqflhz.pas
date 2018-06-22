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
  private
    { Private declarations }
    procedure refresh;
    procedure DBGridExport(GRID:TDBGRID);
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
  publicrule.FormatDisplaylable(cds,'���,����,���ͱ���,��������,����'); 
end;

procedure Tfrmkqflhz.Button1Click(Sender: TObject);
begin
  refresh;
end;

procedure Tfrmkqflhz.Button2Click(Sender: TObject);
begin
  DBGridExport(self.DBGrid1);
end;

procedure Tfrmkqflhz.DBGridExport(GRID:TDBGRID);

var       //DBGRID�ؼ����ݴ洢��EXCEL ֻ�е�һ���б���
    EclApp:Variant;
    XlsFileName:String;
    sh:olevariant;
    i,j:integer;
    s:string;
    savedailog:TSaveDialog;
begin
   savedailog:=TSaveDialog.Create(Self);
   savedailog.Filter:='Excel files (*.xls)|*.XlS';
   savedailog.FileName := '���ڷ������.xls';
   if savedailog.Execute then begin
        xlsfilename:=savedailog.FileName;
        savedailog.Free;
     end
   else begin
      savedailog.Free;
      exit;
   end;
   try
      eclapp:=createOleObject('Excel.Application');
      sh:=CreateOleObject('Excel.Sheet');
   except
      showmessage('���Ļ�����δ��װMicrosoft Excel��');
      exit;
   end;
   try
      sh:=eclapp.workBooks.add;
      With Grid.DataSource.DataSet do begin
        First;
        i:=GRID.FieldCount-1;
        j:=i div 26;
        s:='';
        if j>0 then s:=s+chr(64+j);
        for i:=0 to grid.FieldCount-1  do begin
           if grid.Fields[i].Visible then begin
              eclapp.cells[2,i+1]:=grid.Fields[i].DisplayName;
              if GRID.Fields[i].DisplayWidth>80 then
                 eclapp.columns[i+1].Columnwidth:=80
              else
                 eclapp.columns[i+1].Columnwidth:=GRID.Fields[i].DisplayWidth+0.3;
              eclapp.cells[2,i+1].Font.Color:=clRed;
 //תEXCELʱ�����������н�ȡ�����Ѹ�Ϊ�á���������������治��Ҫ�ˡ�
//              if (grid.Fields[i].DisplayName='���֤��') or (grid.Fields[i].DisplayName='�����ʺ�') then begin
//                 eclapp.columns[i+1].NumberFormat:='@';
//              end;
           end;
        end;
        for i:=1 to RecordCount do begin
            for j:=0 to grid.FieldCount-1 do
              if grid.Fields[j].Visible then
                 if GRID.Fields[j].DisplayText>'' then begin
//                   if length(grid.Fields[j].DisplayText)>=15 then
//                      eclapp.cells[i*2+1,j+1].NumberFormatLocal:='@';
                   eclapp.cells[i+2,j+1]:=grid.Fields[j].DisplayText;
                 end;
            Next;
        end;
     end;
      sh.saveas(xlsfilename);
      sh.close;
      eclapp.quit;
      ShowMessage('��� Excel �ļ������...');
   except
      showmessage('Excelϵͳ��������');
      sh.close;
      eclapp.quit;
      exit;
   end;
end;

end.
