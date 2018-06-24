unit DM;

interface

uses windows,SysUtils,DB, ADODB, IniFiles,Variants, classes,dialogs;

var
  myinifile: TInifile; //实例化一个文件流对象
  mycon: TADOConnection;  //实例化一个数据库连接对象
  mydataset: TDataSet;
  myquery: Tadoquery;
  mycomd: tadocommand;

  function SetConnection: boolean;
  function GetDataSet(vSql: string): TDataSet;
  function ExecuteSql(vSql: string): boolean;
  function AppendData(vTabelName,vFieldlist,vValuelist: string): boolean;
  function EditData(vSql: string): boolean;
  function RestoreData(vFilename: string=''): boolean;

implementation

function SetInifile():boolean;
var
  filepath: string;
begin
  result := true;
  try
    filepath  := ExtractFilePath(Paramstr(0)) + 'DBConfig.ini';        //获取当前路径+文件名
    myinifile := Tinifile.Create(filepath);                         //创建文件
  except
    messagebox(0,'LOADINI打开配置文件失败！','错误',MB_ICONEXCLAMATION);
    result := false;
    Exit;
  end;
end;

function GetConnectstr(): string;
var
  str: string;
  username,password,server,dbname: string;
begin
  if not assigned(myinifile) then
    if not SetInifile then
    begin
      result := '';
      exit;
    end;
  username := myinifile.ReadString('sqlserver','username','');
  password := myinifile.ReadString('sqlserver','password','');
  server := myinifile.ReadString('sqlserver','server','');
  dbname := myinifile.ReadString('sqlserver','dbname','');
  str := format('Provider=SQLOLEDB.1;Password=%s;Persist Security Info=True;User ID=%s;Initial Catalog=%s;Data Source=%s',[password,username,dbname,server]);
  result := str;
end;

function SetConnection: boolean;
var
  astr: string;
begin
  astr := GetConnectstr;
  if astr='' then
  begin
    result := false;
    exit;
  end;

  mycon := tadoconnection.Create(nil);
  mycon.LoginPrompt := false;
  mycon.ConnectionString := astr;
  try
    mycon.Open;
  except
    messagebox(0,'数据库连接失败！','错误',MB_ICONEXCLAMATION);
    result := false;
    Exit;
  end;
  result := true;
end;

function GetDataSet(vSql: string): TDataSet;
var
  data: tadoquery;
begin
  if not assigned(mycon) then
    if not SetConnection then
    begin
      result := nil;
      exit;
    end;

  myquery := tadoquery.Create(nil);
  myquery.Connection := mycon;
  myquery.sql.Text := vsql;
  try
    myquery.Open;
    data := tadoquery.Create(nil);
    data.Clone(myquery);
    result := data;
  except
    messagebox(0,'获取数据失败！','错误',MB_ICONEXCLAMATION);
    result := nil;
  end; 
end;

function ExecuteSql(vSql: string): boolean;
var
  amstr: string;
begin
  if not assigned(mycon) then
    if not SetConnection then
    begin
      result := false;
      exit;
    end;
  mycomd := Tadocommand.Create(nil);
  mycomd.Connection := mycon;
  mycomd.CommandText := vsql;
  try
    mycomd.Execute;
    result := true;
  except
    amstr := '执行sql语句出错！sql内容：'+vsql;
    messagebox(0,PAnsiChar(AnsiString(amstr)),'错误',MB_ICONEXCLAMATION);
    result := false;
  end;
end;

function EditData(vSql: string): boolean;
begin
  result := ExecuteSql(vSql);
end;

function AppendData(vTabelName,vFieldlist,vValuelist: string): boolean;
  function IfCanInsert(vSql: string):boolean;
  begin
    result := false;
    if GetDataSet(vsql).RecordCount <= 0 then
      result := true;
  end;
var
  ainsertsql,aquerysql: string;
  aFList,aVlist: tstringlist;
  astr: string;
  i:integer;
begin
  if (vFieldlist='') or (vValuelist='') then
  begin
    result := false;
    exit;
  end;
  aFList := tstringlist.Create;
  aVlist := tstringlist.Create;

  aFList.CommaText := vFieldlist;
  aVlist.CommaText := vValuelist;
  if aflist.count <> avlist.Count then
  begin
    messagebox(0,'字段与字段值的个数不等！','错误',MB_ICONEXCLAMATION);
    result := false;
    exit;
  end;

  for i := 0 to aflist.Count - 1 do
  begin
    astr := astr + format('and %s=%s ',[aflist[i],avlist[i]]);
  end;
  astr := copy(astr,4,length(astr)-3);
  aquerysql := format('select * from %s where %s ',[vTabelName,astr]);
  ainsertsql := format('insert into %s(%s) values (%s) ',[vTabelName,vFieldlist,vValuelist]); //'name,pwd'    '''ss'',''aa'''

  if not IfCanInsert(aquerysql) then
  begin
    messagebox(0,'主键数据冲突，保存失败！','错误',MB_ICONEXCLAMATION);
    result := false;
    exit;
  end;
  result := ExecuteSql(ainsertsql);
end;

function RestoreData(vFilename: string=''): boolean;
var
  fi:TextFile;
  str: string;
  asql : string;
begin
  result := false;
  with TSaveDialog.Create(nil) do
  begin
    Filter:='sql file(*.sql)|*.sql|text file(*.txt)|*.txt|all files(*.*)|*.*';
    if Execute then
    begin
        AssignFile(fi,FileName);
        Reset(fi);
      try
        while not Eof(fi) do
        begin
          Readln(fi,str);
          if uppercase(trim(str)) <> '' then
          begin
            asql := asql + ' ' + str;
          end;
        end;
        CloseFile(fi);
        ExecuteSql(asql);
        result := true;
        MessageBox(0,'SQL脚本完成！','提示',MB_OK+MB_ICONINFORMATION);
      except
        raise exception.Create('SQL脚本执行失败!');
      end;
    end;
  end;
end;

end.
