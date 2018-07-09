unit DeptSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInfo, Provider, DB, DBClient, Grids, DBGrids, StdCtrls,
  ExtCtrls;

type
  TFormDept = class(TFormBaseInfo)
    procedure FormCreate(Sender: TObject);
    procedure btnnewClick(Sender: TObject);
    procedure btnmodifyClick(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDept: TFormDept;

implementation
uses DeptEdit;
{$R *.dfm}

procedure TFormDept.FormCreate(Sender: TObject);
begin
  inherited;
  QuerySql := 'select id,deptcode,deptname,depttype from department';
  TitleNames := 'id,科室编码,科室名称,科室类型';
end;

procedure TFormDept.btnnewClick(Sender: TObject);
var
  aform: TFormDeptedit;
begin
  aform := TFormDeptedit.Create(nil);
  if aform.ShowModal=mrOK then
  begin
    self.InsertSql := format('insert into department(deptcode,deptname,depttype) values(''%s'',''%s'',''%s'')'
    ,[trim(aform.deptcode.Text),trim(aform.deptname.text),trim(aform.depttype.Text)]);
    inherited;
  end;
  aform.Free; 
end;

procedure TFormDept.btnmodifyClick(Sender: TObject);
var
  aform: TFormDeptedit;
begin
  aform := TFormDeptedit.Create(nil);
  aform.deptcode.Text := cds.FieldValues['deptcode'];
  aform.deptname.Text := cds.FieldValues['deptname'];
  aform.depttype.Text := cds.FieldValues['depttype'];
  if aform.ShowModal=mrOK then
  begin
    self.EditSql := format('update department set deptcode=''%s'',deptname=''%s'',depttype=''%s'' where id=%d'
    ,[trim(aform.deptcode.Text),trim(aform.deptname.text),trim(aform.depttype.Text),Integer(cds.FieldValues['id'])]);
    inherited;
  end;
  aform.Free;
end;

procedure TFormDept.btndeleteClick(Sender: TObject);
begin
  if (cds.RecordCount > 0) and (MessageBox(0,'确定删除当前用户？','提示', mb_okcancel)=1) then
  begin
    self.DeleteSql := format('delete from department where id=%d',[Integer(cds.FieldValues['id'])]);
    inherited;
  end;
end;

end.
