program Zeugnis;

{$R *.dres}

uses
{$IFDEF DEBUG}
  FastMM4,
{$ENDIF}
{$IFDEF RELEASE}
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
{$ENDIF}
  Forms,
  Vcl.Themes,
  Vcl.Styles,
  Erfassung in 'src\Erfassung.pas' {frmErfassung},
  FxFachPunkt in 'src\FxFachPunkt.pas' {frmFachPunkt},
  FxTorte in 'src\FxTorte.pas' {frmTorte},
  FxZusatzFach in 'src\FxZusatzFach.pas' {frmZusatzFach},
  FxBemerkung in 'src\FxBemerkung.pas' {frmBemerkung},
  Schule in 'src\Schule.pas',
  FormularDlg in 'src\FormularDlg.pas' {frmFormularDlg},
  StapelDruck in 'src\StapelDruck.pas' {frmStapeldruck},
  About in 'src\About.pas' {frmAboutBox},
  PrinterSetup in 'src\PrinterSetup.pas',
  Lexicon in 'src\Lexicon.pas' {frmLexicon},
  UnitRecentListe in 'src\UnitRecentListe.pas',
  FxTextFach in 'src\FxTextFach.pas' {frmTextFach},
  DruckenDlg in 'src\DruckenDlg.pas' {frmDruckenDlg},
  UndoRedoCommand in 'src\UndoRedoCommand.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Zeugnis';
  Application.CreateForm(TfrmErfassung, frmErfassung);
  Application.Run;
end.
