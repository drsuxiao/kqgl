unit PublicRule;

interface

uses  Windows, SysUtils, Classes, DBClient;


procedure FormatDisplaylable(var vDataSet: Tclientdataset; vFields: string);

implementation

//��ȡ��������  ��ʽ���ֶ�����
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
