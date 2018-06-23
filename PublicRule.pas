unit PublicRule;

interface

uses  Windows, SysUtils, Classes, DBClient,DBGrids,Dialogs,ComObj,Graphics,math;

//��ʽ���ֶ�����
procedure FormatDisplaylable(vDataSet: Tclientdataset; vFields: string);
//����Excel����
procedure DBGridExport(GRID:TDBGRID);
//���ؼ�¼������������ʾ������Ƿ�ɹ�
function DBGridRecordSize(mColumn: TColumn): Boolean;
//�������������Զ���Ӧ����Ƿ�ɹ�
function DBGridAutoSize(mDBGrid: TDBGrid;mOffset: Integer = 5): Boolean;

implementation

function DBGridRecordSize(mColumn: TColumn): Boolean;
  {   ���ؼ�¼������������ʾ������Ƿ�ɹ�   }
  begin   
      Result   :=   False;   
      if   not   Assigned(mColumn.Field)   then   Exit;   
      mColumn.Field.Tag   :=   Max(mColumn.Field.Tag,   
          TDBGrid(mColumn.Grid).Canvas.TextWidth(mColumn.Field.DisplayText));   
      Result   :=   True;   
  end;   {   DBGridRecordSize   }   

function DBGridAutoSize(mDBGrid: TDBGrid;mOffset: Integer = 5): Boolean;
  {   �������������Զ���Ӧ����Ƿ�ɹ�   }
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
var       //DBGRID�ؼ����ݴ洢��EXCEL ֻ�е�һ���б���
    EclApp:Variant;
    XlsFileName:String;
    sh:olevariant;
    i,j:integer;
    s:string;
    savedailog:TSaveDialog;
begin
   savedailog:=TSaveDialog.Create(nil);
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
