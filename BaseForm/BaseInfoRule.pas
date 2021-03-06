unit BaseInfoRule;

interface
uses windows, dm;

function New(vSql: String): boolean;
function Edit(vSql: String): boolean;
function Delete(vSql: String):boolean;
function Query(vSql: String):boolean;
  
implementation

function New(vSql: String): boolean;
begin
  result := dm.ExecuteSql(vSql);
end;
function Edit(vSql: String): boolean;
begin
  result := dm.ExecuteSql(vSql);
end;
function Delete(vSql: String):boolean;
begin
  result := dm.ExecuteSql(vSql);
end;
function Query(vSql: String):boolean;
begin
  result := dm.ExecuteSql(vSql);
end;

end.
