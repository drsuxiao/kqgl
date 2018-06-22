program kqgl;

uses
  Forms,
  main in 'main.pas' {FrmMain},
  ryxx in 'ryxx.pas' {Frmryxx},
  ryxx_edit in 'ryxx_edit.pas' {Frmedit_ryxx},
  pbsxsz in 'pbsxsz.pas' {Frmpbsx},
  scpbxx in 'scpbxx.pas' {Frmscpbxx},
  dateselect in 'dateselect.pas' {FrmDateselect},
  modifypb in 'modifypb.pas' {FrmModifypb},
  kqdj in 'kqdj.pas' {Frmkqdjnew},
  kqdjjm in 'kqdjjm.pas' {frmkqdjjm},
  pbxxcx in 'pbxxcx.pas' {frmpbxxquery},
  kqflhz in 'kqflhz.pas' {frmkqflhz},
  zbcstj in 'zbcstj.pas' {frmzbcstj},
  DM in 'DM.pas',
  PublicRule in 'PublicRule.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmryxx, Frmryxx);
  Application.CreateForm(TFrmedit_ryxx, Frmedit_ryxx);
  Application.CreateForm(TFrmpbsx, Frmpbsx);
  Application.CreateForm(TFrmscpbxx, Frmscpbxx);
  Application.CreateForm(TFrmDateselect, FrmDateselect);
  Application.CreateForm(TFrmModifypb, FrmModifypb);
  Application.CreateForm(TFrmkqdjnew, Frmkqdjnew);
  Application.CreateForm(Tfrmkqdjjm, frmkqdjjm);
  Application.CreateForm(Tfrmpbxxquery, frmpbxxquery);
  Application.CreateForm(Tfrmkqflhz, frmkqflhz);
  Application.CreateForm(Tfrmzbcstj, frmzbcstj);
  Application.Run;
end.
