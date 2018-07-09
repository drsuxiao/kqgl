unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, ADODB, StdCtrls, ExtCtrls, ActnList, SQLADOPoolUnit;

type
  TFrmMain = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N6: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    SaveDialog1: TSaveDialog;
    DataSetCol: TADODataSet;
    DataSetTable: TADODataSet;
    Memo1: TMemo;
    DataSetValues: TADODataSet;
    Panel1: TPanel;
    N7: TMenuItem;
    ActionList1: TActionList;
    actryxxwh: TAction;
    actpbsxsz: TAction;
    actscpbxx: TAction;
    actckpbxx: TAction;
    actkqdj: TAction;
    actqjflhz: TAction;
    actzbcstj: TAction;
    actbackup: TAction;
    actrestore: TAction;
    ActDeptSet: TAction;
    N15: TMenuItem;
    procedure actryxxwhExecute(Sender: TObject);
    procedure actpbsxszExecute(Sender: TObject);
    procedure actscpbxxExecute(Sender: TObject);
    procedure actckpbxxExecute(Sender: TObject);
    procedure actkqdjExecute(Sender: TObject);
    procedure actqjflhzExecute(Sender: TObject);
    procedure actzbcstjExecute(Sender: TObject);
    procedure actbackupExecute(Sender: TObject);
    procedure actrestoreExecute(Sender: TObject);
    procedure ActDeptSetExecute(Sender: TObject);
  private
    { Private declarations }
    FBackupFileName: string;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation
uses ryxx,pbsxsz,scpbxx,kqdjjm,pbxxcx,kqflhz,zbcstj,dm,DeptSet;
{$R *.dfm}
//人员信息维护
procedure TFrmMain.actryxxwhExecute(Sender: TObject);
var
  aform: TFrmryxx;
begin
  aform := TFrmryxx.Create(nil);
  //aform.Parent := self.Panel1;
  aform.ShowModal;
  aform.Free;
end;

//排班顺序设置
procedure TFrmMain.actpbsxszExecute(Sender: TObject);
var
  aform: TFrmpbsx;
begin
  aform := TFrmpbsx.Create(nil);
  aform.ShowModal;
  aform.Free;
end;

//科室维护
procedure TFrmMain.ActDeptSetExecute(Sender: TObject);
var
  aform: TFormDept;
begin
  aform := TFormDept.Create(nil);
  aform.ShowModal;
  aform.Free;
end;


//生成排班信息
procedure TFrmMain.actscpbxxExecute(Sender: TObject);
var
  aform: TFrmscpbxx;
begin
  aform := TFrmscpbxx.Create(nil);
  aform.ShowModal;
  aform.Free;
end;

//考勤登记
procedure TFrmMain.actkqdjExecute(Sender: TObject);
var
  aform: Tfrmkqdjjm;
begin
  aform := Tfrmkqdjjm.Create(nil);
  aform.ShowModal;
  aform.Free;
end;

//查看排班信息
procedure TFrmMain.actckpbxxExecute(Sender: TObject);
var
  aform: Tfrmpbxxquery;
begin
  aform := Tfrmpbxxquery.Create(nil);
  aform.ShowModal;
  aform.Free;
end;

// 请假分类汇总
procedure TFrmMain.actqjflhzExecute(Sender: TObject);
var
  aform: Tfrmkqflhz;
begin
  aform := Tfrmkqflhz.Create(nil);
  aform.ShowModal;
  aform.Free;
end;
//值班次数统计
procedure TFrmMain.actzbcstjExecute(Sender: TObject);
var
  aform: Tfrmzbcstj;
begin
  aform := Tfrmzbcstj.Create(nil);
  aform.ShowModal;
  aform.Free;
end;
//数据备份
procedure TFrmMain.actbackupExecute(Sender: TObject);
var
  vCols: string;
  vSql: string;
  i,vCount: integer;
  vv: string;
begin
  if not dm.SetConnection then exit;
  savedialog1.Filter:='sql file(*.sql)|*.sql|text file(*.txt)|*.txt|all files(*.*)|*.*';
  savedialog1.FileName := formatdatetime('yyyymmddhhmmss',now);
  savedialog1.DefaultExt := 'sql';
  if savedialog1.Execute then
  begin
    DataSetTable.Connection := dm.mycon;
    DataSetTable.Active := false;
    DataSetTable.CommandText := 'select name from sysobjects where xtype=''U'' order by name';
    DataSetTable.Active := true;
    DataSetTable.First;
    while not DataSetTable.Eof do
    begin
      DataSetCol.Connection := dm.mycon;
      DataSetCol.Active := false;
      DataSetCol.CommandText := format('select name from syscolumns where id=object_id(N''%s'') and name <> ''id'' order by colid',[DataSetTable.Fields[0].Value]);
      DataSetCol.Active := true;
      DataSetCol.First;
      vCols := '';
      while not DataSetCol.Eof do
      begin
        vCols := vCols + ',' + DataSetCol.Fields[0].Value;
        DataSetCol.Next;
      end;
      vCols := copy(vCols,2,length(vCols)-1);
      DataSetValues.Connection := dm.mycon;
      DataSetValues.Active := false;
      DataSetValues.CommandText := 'select * from ' + DataSetTable.Fields[0].AsString;
      DataSetValues.Active := true;
      DataSetValues.First;
      vCount := DataSetValues.FieldCount;
      vSql := vSql + 'delete from ' + DataSetTable.Fields[0].AsString +#13#10;
      while not DataSetValues.Eof do
      begin
        for i:=1 to vCount-1 do
        begin
          if DataSetValues.Fields[i].DataType=ftString then
            vv := vv + ',' + ''''+trim(DataSetValues.Fields[i].Value)+''''
          else if DataSetValues.Fields[i].DataType=ftBoolean then
          begin
            if trim(DataSetValues.Fields[i].AsString)='False' then
               vv := vv + ',' + '0'
            else
               vv := vv + ',' + '1';
          end
          else
            vv := vv + ',' + ''+trim(DataSetValues.Fields[i].Value)+'';
        end;
        vv := copy(vv,2,length(vv)-1);
        vSql := vSql + format('insert into %s (%s) values(',[DataSetTable.Fields[0].AsString,vCols]);
        vSql := vSql+ vv + ')' + #13#10;
        vv := '';
        DataSetValues.Next;
      end;
      DataSetTable.Next;
    end;
    memo1.Text := vSql;
    memo1.Lines.SaveToFile(savedialog1.FileName);
    FBackupFileName := savedialog1.FileName;
    showmessage('数据备份成功！');
  end;
end;
//数据还原
procedure TFrmMain.actrestoreExecute(Sender: TObject);
begin
  RestoreData(FBackupFileName);    
end;

end.
