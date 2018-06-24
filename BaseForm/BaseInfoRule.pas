unit BaseInfoRule;

interface
uses windows;

function New(vSql: String): Integer;
function Edit(vSql: String): Integer;
function Delete(vSql: String):Integer;
function Query(vSql: String):Integer;
  
implementation

function New(vSql: String): Integer;
begin
  result := 0;
end;
function Edit(vSql: String): Integer;
begin
  result := 0;
end;
function Delete(vSql: String):Integer;
begin
  result := 0;
end;
function Query(vSql: String):Integer;
begin
  result := 0;
end;



end.
