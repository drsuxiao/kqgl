unit pbxxcx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBClient, Grids, DBGrids, DB, StdCtrls, ComCtrls, ExtCtrls,
  ADODB, Provider;

type
  Tfrmpbxxquery = class(TForm)
    ADODataSet1: TADODataSet;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cmbdept: TComboBox;
    Label5: TLabel;
    dtfrom: TDateTimePicker;
    dtto: TDateTimePicker;
    btnquery: TButton;
    Panel2: TPanel;
    DataSource1: TDataSource;
    Button1: TButton;
    DBGrid1: TDBGrid;
    cds: TClientDataSet;
    dspro: TDataSetProvider;
    cds1: TClientDataSet;
    dspro1: TDataSetProvider;
    procedure btnqueryClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    function GetTheWeek(vDateTime: Tdatetime): integer;
    procedure SingleDBGridExport(GRID: TDBGRID);
    procedure DBGridExport(GRID:TDBGRID);
  public
    { Public declarations }
  end;

var
  frmpbxxquery: Tfrmpbxxquery;

implementation
uses DateUtils,ComObj,dm;
{$R *.dfm}

procedure Tfrmpbxxquery.btnqueryClick(Sender: TObject);
var
  asql: string;
  adept,adt1,adt2: string;
  m,w,d: integer;
  adate: tdatetime;
  array1,array2: array[1..12,1..6,1..7] of string;    //年份，周数，星期数
  i,j: integer;
  astopmonth,astartmonth: integer;
  aquery: string;
  ayear,ayear1 : string;
  str: string;
begin
  adept := inttostr(cmbdept.ItemIndex);
  adt1 := formatdatetime('yyyy-mm-dd',dtfrom.DateTime);
  adt2 := formatdatetime('yyyy-mm-dd',dtto.DateTime);
  ayear := inttostr(yearof(dtfrom.DateTime));
  ayear1 := inttostr(yearof(dtto.DateTime));
  if ayear <> ayear1 then
  begin
    showmessage('不能跨年份查询！');
    exit;
  end;
  asql := format('select * from view_pbxx where deptcode=''%s'' and rq >= ''%s'' and rq <= ''%s'' order by deptcode,rq,week',[adept,adt1,adt2]);
  dspro1.DataSet := dm.GetDataSet(asql);
  cds1.Data := dspro1.Data;
  cds1.Active := true;

  astartmonth := monthoftheyear(dtfrom.DateTime);
  astopmonth := monthoftheyear(dtto.DateTime);

  if cds1.RecordCount = 0 then exit;
  fillchar(array1,sizeof(array1),#0);
  fillchar(array2,sizeof(array2),#0);
  cds1.First;
  while not cds1.Eof do
  begin
    adate := strtodatetime(cds1.fieldbyname('rq').AsString);
    m := MonthOfTheYear(adate);
    w := GetTheWeek(adate);//NthDayOfWeek(adate);
    d := DayOfWeek(adate);
    array1[m,w,d] := inttostr(strtoint(copy(cds1.fieldbyname('rq').AsString,9,10))); //日期
    array2[m,w,d] := cds1.fieldbyname('name').AsString;  //排班人
    cds1.Next;
  end;
  ayear := inttostr(yearof(dtfrom.DateTime));
  aquery := 'select '''' as ''月份/星期'','''' as ''星期日'','''' as ''星期一'','''' as ''星期二'','''' as ''星期三'','''' as ''星期四'','''' as ''星期五'','''' as ''星期六''';
  for i:=astartmonth to astopmonth do
  begin
    str := ayear+'年'+inttostr(i)+'月';
    //aquery := aquery + format(' union all select ''%s'','''','''','''','''','''','''','''' ',[ayear+'年'+inttostr(i)+'月']);
    for j:=1 to 6 do
    begin
      if (array1[i,j,1]<>'') or (array1[i,j,2]<>'') or (array1[i,j,3]<>'')
         or (array1[i,j,4]<>'') or (array1[i,j,5]<>'') or (array1[i,j,6]<>'') or (array1[i,j,7]<>'') then
      begin
        aquery := aquery + format(' union all select ''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'' '
                  ,[str,array1[i,j,1],array1[i,j,2],array1[i,j,3],array1[i,j,4],array1[i,j,5],array1[i,j,6],array1[i,j,7]]);
        aquery := aquery + format(' union all select '''',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'' '
                  ,[array2[i,j,1],array2[i,j,2],array2[i,j,3],array2[i,j,4],array2[i,j,5],array2[i,j,6],array2[i,j,7]]);
      end;
    end;
  end;

  dspro.DataSet := dm.GetDataSet(aquery);
  cds.Data := dspro.Data;
  cds.Active := true;
end;

function Tfrmpbxxquery.GetTheWeek(vDateTime: Tdatetime): integer;
var
  afirst,aweek,aday: integer;
begin
  afirst := DayOfWeek(StartOfTheMonth(vDateTime));
  aday := dayofthemonth(vDateTime);
  aweek := ((afirst-2)+ aday) div 7 + 1;
  result := aweek;
end;

procedure Tfrmpbxxquery.Button1Click(Sender: TObject);
begin
  DBGridExport(self.DBGrid1);
end;

procedure Tfrmpbxxquery.DBGridExport(GRID:TDBGRID);

var       //DBGRID控件内容存储到EXCEL 只有第一行有标题
    EclApp:Variant;
    XlsFileName:String;
    sh:olevariant;
    i,j:integer;
    s:string;
    savedailog:TSaveDialog;
begin
   savedailog:=TSaveDialog.Create(Self);
   savedailog.Filter:='Excel files (*.xls)|*.XlS';
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
      showmessage('您的机器里未安装Microsoft Excel。');
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
 //转EXCEL时过长的数字有截取现象。已改为用‘来解决，所以下面不需要了。
//              if (grid.Fields[i].DisplayName='身份证号') or (grid.Fields[i].DisplayName='银行帐号') then begin
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
      ShowMessage('输出 Excel 文件已完成...');
   except
      showmessage('Excel系统出错！！！');
      sh.close;
      eclapp.quit;
      exit;
   end;
end;

//========================每行都有标题说明的转出EXCEL==========================
procedure Tfrmpbxxquery.SingleDBGridExport(GRID: TDBGRID);
var       //DBGRID控件内容存储到EXCEL
    EclApp:Variant;
    XlsFileName:String;
    sh:olevariant;
    i,j,z:integer;
    s:string;
    savedailog:TSaveDialog;
begin
   savedailog:=TSaveDialog.Create(Self);
   savedailog.Filter:='Excel files (*.xls)|*.XlS';
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
      showmessage('您的机器里未安装Microsoft Excel。');
      exit;
   end;
   try
      sh:=eclapp.workBooks.add;
      With Grid.DataSource.DataSet do begin
        First;
        z:=GRID.FieldCount-1;
        j:=i div 26;
        s:='';
        if j>0 then s:=s+chr(64+j);
        for i:=1 to RecordCount do begin
           for z:=0 to grid.FieldCount-1  do begin
             if grid.Fields[z].Visible then begin
                eclapp.cells[i*2,z+1]:=grid.Fields[z].DisplayName;
                if GRID.Fields[z].DisplayWidth>80 then
                   eclapp.columns[z+1].Columnwidth:=80
                else
                   eclapp.columns[z+1].Columnwidth:=GRID.Fields[z].DisplayWidth+0.3;
                eclapp.cells[i*2,z+1].Font.Color:=clRed;
             end;
           end;
          //
            for j:=0 to grid.FieldCount-1 do
              if grid.Fields[j].Visible then
                 if GRID.Fields[j].DisplayText>'' then begin
                   eclapp.cells[i*2+1,j+1]:=grid.Fields[j].DisplayText;
                 end;
            Next;
        end;
     end;
      sh.saveas(xlsfilename);
      sh.close;
      eclapp.quit;
      ShowMessage('输出 Excel 文件已完成...');
   except
      showmessage('Excel系统出错！！！');
      sh.close;
      eclapp.quit;
      exit;
   end;
end;

procedure Tfrmpbxxquery.FormShow(Sender: TObject);
begin
  dtfrom.DateTime := StartOfTheMonth(now);
  dtto.DateTime := EndOfTheMonth(now);
  cmbdept.ItemIndex := 0;
end;

procedure Tfrmpbxxquery.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if  DBGrid1.DataSource.DataSet.RecNo mod 2 =0 then
  begin
      DBGrid1.Canvas.Brush.Color := clSilver;
  end
  else begin
     DBGrid1.Canvas.Brush.Color := clWindow;
      DBGrid1.Canvas.Font.Color := clBlack; //选中的字体颜色
      DBGrid1.Canvas.Font.Style := [fsBold]; //选中时的字体
      DBGrid1.Canvas.Font.Size := 16;     
  end;
  if  (State=[gdselected]) or (State=[gdSelected,gdFocused]) then
    DBGrid1.Canvas.Brush.Color := clRed;

  DbGrid1.Canvas.pen.mode:=pmMask;
  DbGrid1.DefaultDrawColumnCell(Rect,datacol,column,state);
end;

end.
