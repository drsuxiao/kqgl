unit PublicRule;

interface

uses  Windows, SysUtils, Classes, DBClient;


procedure FormatDisplaylable(var vDataSet: Tclientdataset; vFields: string);

implementation

//提取公共方法  格式化字段名称
procedure FormatDisplaylable(var vDataSet: Tclientdataset; vFields: string);
var
  alist: Tstringlist;
  i: integer;
begin
  alist := tstringlist.Create;
  alist.CommaText := vFields;
  for i := 0 to alist.Count - 1 do
    vDataSet.Fields[i].DisplayLabel := alist[i];
end;

end.
