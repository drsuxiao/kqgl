unit PublicRule;

interface

uses  Windows, SysUtils, Classes, DBClient,DBGrids,Dialogs,ComObj,Graphics,math;

//格式化字段名称
procedure FormatDisplaylable(vDataSet: Tclientdataset; vFields: string);
//导出Excel方法
procedure DBGridExport(GRID:TDBGRID);
//返回记录数据网格列显示最大宽度是否成功
function DBGridRecordSize(mColumn: TColumn): Boolean;
//返回数据网格自动适应宽度是否成功
function DBGridAutoSize(mDBGrid: TDBGrid;mOffset: Integer = 5): Boolean;

implementation

function DBGridRecordSize(mColumn: TColumn): Boolean;
  {   返回记录数据网格列显示最大宽度是否成功   }
  begin   
      Result   :=   False;   
      if   not   Assigned(mColumn.Field)   then   Exit;   
      mColumn.Field.Tag   :=   Max(mColumn.Field.Tag,   
          TDBGrid(mColumn.Grid).Canvas.TextWidth(mColumn.Field.DisplayText));   
      Result   :=   True;   
  end;   {   DBGridRecordSize   }   

function DBGridAutoSize(mDBGrid: TDBGrid;mOffset: Integer = 5): Boolean;
  {   返回数据网格自动适应宽度是否成功   }
  var   
      I:   Integer;   
  begin   
      Result   :=   False;   
      if   not   Assigned(mDBGrid)   then   Exit;   
      if   not   Assigned(mDBGrid.DataSource)   then   Exit;   
      if   not   Assigned(mDBGrid.DataSource.DataSet)   then   Exit;   
      if   not   mDBGrid.DataSource.DataSet.Active   then   Exit;   
      for   I   :=   0   to   mDBGrid.Columns.Count   -   1   do   begin   
          if   not   mDBGrid.Columns[I].Visible   then   Continue;   
          if   Assigned(mDBGrid.Columns[I].Field)   then   
              mDBGrid.Columns[I].Width   :=   Max(mDBGrid.Columns[I].Field.Tag,   
                  mDBGrid.Canvas.TextWidth(mDBGrid.Columns[I].Title.Caption))   +   mOffset   
          else   mDBGrid.Columns[I].Width   :=
              mDBGrid.Canvas.TextWidth(mDBGrid.Columns[I].Title.Caption)   +   mOffset;
          mDBGrid.Refresh;   
      end;   
      Result   :=   True;   
  end;   {   DBGridAutoSize   }   


procedure FormatDisplaylable(vDataSet: Tclientdataset; vFields: string);
var
  alist: Tstringlist;
  i: integer;
begin
  alist := tstringlist.Create;
  alist.CommaText := vFields;
  for i := 0 to alist.Count - 1 do
    vDataSet.Fields[i].DisplayLabel := alist[i];
end;

procedure DBGridExport(GRID:TDBGRID);  
var       //DBGRID控件内容存储到EXCEL 只有第一行有标题
    EclApp:Variant;
    XlsFileName:String;
    sh:olevariant;
    i,j:integer;
    s:string;
    savedailog:TSaveDialog;
begin
   savedailog:=TSaveDialog.Create(nil);
   savedailog.Filter:='Excel files (*.xls)|*.XlS';
   savedailog.FileName := '考勤分类汇总.xls';
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



end.
