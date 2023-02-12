unit Erfassung;

interface

uses
  Winapi.Windows, Winapi.Messages, Winapi.ShellAPI, System.Classes, System.Types,
  System.SysUtils, System.Math, System.UITypes,
  Vcl.Clipbrd, Vcl.StdActns, Vcl.ExtActns, Vcl.ToolWin, Vcl.Menus, Vcl.Forms,
  Vcl.ComCtrls, System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan, Vcl.ExtCtrls, Vcl.Dialogs, System.ImageList, Vcl.ImgList, Vcl.Controls,
  Vcl.StdCtrls, System.Variants, Vcl.Graphics, Winapi.RichEdit,
  Xml.XMLIntf, Xml.XMLDoc, Xml.xmldom, Xml.Win.msxmldom, Soap.XSBuiltIns,
{$IFDEF _LL26_}
//  ListLabel26, LLPreview, LLReport_Types,
  l26, cmbtll26,
{$ENDIF}
  Schule, FormularDlg, FxBemerkung, FxTextFach, FxFachPunkt, UnitRecentListe,
  uTPLb_CryptographicLibrary, uTPLb_BaseNonVisualComponent, uTPLb_Codec;

type
  TPrintAktion = (paVorschau, paPrint, paPrintXML, paExport);
  TFachStatus = (fsNone, fsAktiv, fsNoAktiv);
  TDruckTyp = (dt);

  TFachTabSheet = class(TTabSheet)
  private
    Seitenumbruch: Boolean;
    Torten: Boolean;
    FFachStatus: TFachStatus;
    Kompetenz: Boolean;
    FBemerkung: TfrmBemerkung;
    FScrollBox: TScrollBox;
    FID: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

{ TEditRedo }
  TEditRedo = class(TEditAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TLLWorker = class(TThread)
  private
    BDruckDatenNr: Word;
    BXMLDoc: IXMLDocument;
    BRoot: IXMLNode;
    BSavePapierFormat: SmallInt;
    BTempFile: TFileName;
    BFromPage: Integer;
    BPrintRange: TPrintRange;
    BToPage: Integer;
    BCopies: Integer;
    BPrintAktion: TPrintAktion;
    BPrinterIndex: Integer;
    BWithDialog: Boolean;
{$IFDEF _LL26_}
    FLL26: TL26_;
    procedure BDefineCurrentRecord_LL26(ForDesign: Boolean;
      PersonalDaten: IXMLNode; ATyp, AFarbe, AFachName, AText, ARTFText, AWert, AFontStyle, ATorten,
      ANurBemerkung, AKompetenz, ABericht, AGesprGrdl, AFachZusatzText, ASchriftgrad: string);
    procedure BDoPrint_LL26;
{$ENDIF}
    procedure LoadQuickPreview;
    procedure DeleteEncriptFileName;
//    procedure Daten2XML;
    procedure RepairXML;
    procedure EnableButton;
    procedure IncThread;
    procedure DecThread;
    function BVorlageFile: TFileName;
    function BGetTempLL2XFile: string;
  protected
    procedure Execute; override;
  public
    BEncriptFileName: TFileName;
    constructor MyCreate(PrintAktion: TPrintAktion; Doc: IXMLDocument; const PrinterIndex: Integer);
    destructor Destroy; override;
    property TempFile: TFileName read BTempFile write BTempFile;
    property Copies: Integer read BCopies write BCopies default 1;
    property PrintRange: TPrintRange read BPrintRange write BPrintRange default prAllPages;
    property FromPage: Integer read BFromPage write BFromPage;
    property ToPage: Integer read BToPage write BToPage;
  end;

  TfrmErfassung = class(TForm)
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    Beenden1: TMenuItem;
    N1: TMenuItem;
    mitDrucken: TMenuItem;
    N2: TMenuItem;
    mitSpeichernUnter: TMenuItem;
    mitSpeichern: TMenuItem;
    mitOpenSchueler: TMenuItem;
    mitNeuSchueler: TMenuItem;
    Bearbeiten1: TMenuItem;
    mitEinfuegen: TMenuItem;
    mitKopieren: TMenuItem;
    mitAusschneiden: TMenuItem;
    Hilfe1: TMenuItem;
    Info1: TMenuItem;
    Hilfebenutzen1: TMenuItem;
    Suchen2: TMenuItem;
    Inhalt1: TMenuItem;
    StatusBar: TStatusBar;
    SaveSchueler: TSaveDialog;
    OpenSchueler: TOpenDialog;
    pnlKopf: TPanel;
    lblNachname: TLabel;
    lblVorname: TLabel;
    lblKlasse: TLabel;
    lblSchuljahr: TLabel;
    edNachname: TEdit;
    edVorname: TEdit;
    edKlasse: TEdit;
    cmbSchuljahr: TComboBox;
    lblKonferenzbeschluss: TLabel;
    dtKonferenzbeschluss: TDateTimePicker;
    ToolBar1: TToolBar;
    tbNeu: TToolButton;
    tbVorschau: TToolButton;
    tbDrucken: TToolButton;
    LargeImageList: TImageList;
    tbSave: TToolButton;
    tbSaveAs: TToolButton;
    tbOeffnen: TToolButton;
    tbSeparator1: TToolButton;
    mitVorschau: TMenuItem;
    lblVersaeumnisse: TLabel;
    cmbVersaeumnisse: TComboBox;
    N3: TMenuItem;
    mitEingabepruefen: TMenuItem;
    cmbKlasse: TComboBox;
    tbSeparator2: TToolButton;
    tbCut: TToolButton;
    tbCopy: TToolButton;
    tbPaste: TToolButton;
    tbSeparator3: TToolButton;
    tbEingabepruefen: TToolButton;
    PrintDialog1: TPrintDialog;
    tbUndo: TToolButton;
    lblAusstellungsdatum: TLabel;
    dtAusstellungsdatum: TDateTimePicker;
    Timer1: TTimer;
    mitSchliessen: TMenuItem;
    chkQuickPreview: TCheckBox;
    lblFoerderschwerpunkt: TLabel;
    edFoerderschwerpunkt: TEdit;
    mitTextbaustein: TMenuItem;
    pnlDaten: TPanel;
    pgZeugnis: TPageControl;
    pnlQuickPreview: TPanel;
    Splitter2: TSplitter;
    mitUndo: TMenuItem;
    ActionManager1: TActionManager;
    EditSelectAll: TEditSelectAll;
    mitStapeldruck: TMenuItem;
    mitLexicon: TMenuItem;
    tbSeparator4: TToolButton;
    tbAlignLeft: TToolButton;
    tbAlignCenter: TToolButton;
    tbAlignRight: TToolButton;
    N4: TMenuItem;
    mitAlignLeft: TMenuItem;
    mitAlignCenter: TMenuItem;
    mitAlignRight: TMenuItem;
    tbAlignBlock: TToolButton;
    tbAlignBold: TToolButton;
    mitAlignBlock: TMenuItem;
    ImageList: TImageList;
    EditCut: TEditCut;
    EditCopy: TEditCopy;
    EditPaste: TEditPaste;
    EditUndo: TEditUndo;
    EditDelete: TEditDelete;
    FormatRichEditBold: TRichEditBold;
    FormatRichEditItalic: TRichEditItalic;
    FormatRichEditUnderline: TRichEditUnderline;
    FormatRichEditStrikeOut: TRichEditStrikeOut;
    FormatRichEditBullets: TRichEditBullets;
    FormatRichEditAlignLeft: TRichEditAlignLeft;
    FormatRichEditAlignRight: TRichEditAlignRight;
    FormatRichEditAlignCenter: TRichEditAlignCenter;
    tbAlignItalic: TToolButton;
    mitRedo: TMenuItem;
    mitAllesauswaehlen: TMenuItem;
    tbUnderline: TToolButton;
    tbStrikeOut: TToolButton;
    tbBullets: TToolButton;
    mitRecentFiles: TMenuItem;
    LargeImageListDisable: TImageList;
    ImageListDisable: TImageList;
    pnlReligionPhilosophie: TPanel;
    rbReligion: TRadioButton;
    rbPhilosophie: TRadioButton;
    Codec1: TCodec;
    CryptographicLibrary1: TCryptographicLibrary;
    mitBerichtzuClipboard: TMenuItem;
    Label1: TLabel;
    Timer2: TTimer;
    FileOpen1: TFileOpen;
    mitZusatz: TMenuItem;
    pgZeugnisControl: TPageControl;
    tabZeugnis: TTabSheet;
    tabZeugnisGGL: TTabSheet;
    pgZeugnisGGL: TPageControl;
    XMLSchueler: TXMLDocument;
    procedure Beenden1Click(Sender: TObject);
    procedure mitSpeichernClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mitOpenSchuelerClick(Sender: TObject);
    procedure mitSpeichernUnterClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mitVorschauClick(Sender: TObject);
    procedure mitDruckenClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OnChangeEreignis(Sender: TObject);
    procedure OnABemerkungChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure mitNeuSchuelerClick(Sender: TObject);
    procedure mitEingabepruefenClick(Sender: TObject);
    procedure Info1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
//    procedure tbUndoClick(Sender: TObject);
    procedure pgZeugnisChange(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure StatusBarResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure mitSchliessenClick(Sender: TObject);
    procedure chkQuickPreviewClick(Sender: TObject);
    procedure mitTextbausteinClick(Sender: TObject);
    procedure pgZeugnisMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pgZeugnisDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure pgZeugnisDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure mitStapeldruckClick(Sender: TObject);
    procedure mitLexiconClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Splitter2Moved(Sender: TObject);
    procedure rgFachClick(Sender: TObject);
    procedure mitBerichtzuClipboardClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure pgZeugnisDrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure mitZusatzClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure XMLSchuelerAfterOpen(Sender: TObject);
  private
    { Private-Deklarationen }
    FFileName: TFileName;
    FKlasseVorlage: TFileName;
    FChange: Boolean;
    InXMLToFach: Boolean;
    InXMLToTabSheet: Boolean;
    FHalbJahr: SmallInt;
    FBericht: Boolean;
    FFSP: Boolean;
    FGesprGrdl: Boolean;

    Root: IXMLNode;
    PersonalDatenNode: IXMLNode;
    ZeugnisInhaltNode: IXMLNode;
    ZeugnisInhaltGGLNode: IXMLNode;

    Fehler: TStringList;
    StatusPanelFarbe: Integer;
    DruckDatenNr: Integer;
    QVFertig: Boolean;
    LastChange: TDateTime;
    EditModus: Boolean;
    LLVorschauDatei: TFileName;
    QuickPreviewCurrentPage: Integer;
    PapierFormat: SmallInt;
{$IFDEF _LL26_}
    LL26: TL26_;
    LL26Preview: TLl26PreviewControl;
{$ENDIF}
    FormatRichEditAlignBlocksatz: TRichEditAlignBlocksatz;
    EdiTRedo: TEditRedo;
    RecentList: TRecentListe;
    procedure RecentListClick(SchuelerFile: TFileName);

    procedure DoQuickPreview;
    procedure DoDesign;
    function CreateFachTabSheet(aPageControl: TPageControl; const FachNode, FachGGLNode: IXMLNode;
      AlignBlocksatz: Boolean): TFachTabSheet;
    procedure DeleteActivTabSheet(aPageControl: TPageControl);
    procedure XMLToTabSheet(aPageControl: TPageControl; aZeugnisInhaltNode: IXMLNode; AlignBlocksatz: Boolean);
    function FindAtributeNode(Input: IXMLNode; const AttributesName, AttributesValue: WideString): IXMLNode;
{$IFDEF _LL26_}
    procedure InitLL26;
    procedure DefineCurrentRecord_LL26(ForDesign: Boolean;
      PersonalDaten: IXMLNode; ATyp, AFarbe, AFachName, AText, ARTFText, AWert, AFontStyle, ATorten,
      ANurBemerkung, AKompetenz, ABericht, AGesprGrdl, AFachZusatzText, ASchriftgrad: string);
{$ENDIF}
    function IstEingabeOK: Boolean;
    procedure SetChange(const Value: Boolean);
    procedure SetFileName(const Value: TFileName);
    procedure SetKlasseVorlage(const Value: TFileName);
    procedure DoLoadKlasseVorlage(const KlasseVorlage: TFileName);
    procedure scrEingabeOnResize(Sender: TObject);
    procedure CheckAenderungen;
    procedure CheckFach(ScrollBox: TScrollBox);
    procedure CheckTextFach(const FachName: string; TextFach: TForm);
//    procedure PanelBemerkungResize(Sender: TObject);
    procedure DoSaveSchueler(const SchuelerFile: TFileName);
    procedure DoLoadSchueler(const SchuelerFile: TFileName);
    procedure ShowAnzahlZeichen(Sender: TObject);
    procedure ShowAnzahlZeichenEx;
    procedure InitEingabe(aKlassVorlage: TFileName; aHalbJahr, aKlasse: Integer; aFSP: Boolean);
    procedure EingabeOnOff(const Value: Boolean);
    procedure InitComboBox;
    function GetActiveBemerkung: TfrmBemerkung;
    function GetActiveScrollBox: TScrollBox;
    function GetActiveTextFach: TfrmTextFach;
    procedure OnFachPunktChangeFromText(Sender: TfrmTextFach; PunktNr, Wert: Word);
    procedure OnFachPunktChangeFromPunkt(Sender: TfrmFachPunkt; PunktNr, Wert: Word);
    procedure FachPunktDblClick(Sender: TObject);
    procedure WMMOUSEWHEEL(var Msg: TMessage); message WM_MOUSEWHEEL;
    procedure Zeugnis2XML;
    procedure PersonalDaten2XML;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure SplitterMoved(Sender: TObject);
    procedure SetBericht(const Value: Boolean);
    function LLVorschauToFront: Boolean;
    function XMLNodeStrToDate(Value: IXMLNode): TDateTime;
    procedure LoadDocumnetInfo(aRoot: IXMLNode);
    function PrepearXMLDoc(PrintAktion: TPrintAktion): IXMLDocument;
    function IstXMLDatei(const FileName: TFileName): Boolean;
  public
    { Public-Deklarationen }
    function VorlageFile: TFileName;
{$IFDEF _LL26_}
    function DoPrint_LL26(const DruckXML: IXMLDocument; PrintAktion: TPrintAktion; WithDialog: Boolean): Integer;
{$ENDIF}
    procedure LoadQuickPreview(TempLLVorschauDatei: TFileName);
    property Change: Boolean read FChange write SetChange;
    property FileName: TFileName read FFileName write SetFileName;
    property Bericht: Boolean read FBericht write SetBericht;
    property KlasseVorlage: TFileName read FKlasseVorlage write SetKlasseVorlage;
  end;

  function DruckTyp2Value(ADTyp: TDruckTyp): string;

var
  frmErfassung: TfrmErfassung;
  FLLObjekts: TList;
  LLWorker: TLLWorker;

implementation

uses
  Vcl.Printers,
  FxZusatzFach, FxTorte, StapelDruck, PrinterSetup, Lexicon, DruckenDlg, ABOUT;

{$R *.dfm}
{$WARN SYMBOL_PLATFORM OFF}

function DruckTyp2Value(ADTyp: TDruckTyp): string;
begin
  case ADTyp of
    dt: Result := '0';
    dt: Result := '1';    {* Überfachliche Kompetenzen, Fachtext, Torte *}
    dt: Result := '2';    {* Torten Value *}
    dt: Result := '3';    {* Punkt Bezeichnung *}
    dt: Result := '4';    {* Bemerkung *}
    dt: Result := '5';    {* Versäumnisse, Ammersbek, Schulleiterin, Sorgeberechnige *}
    dt: Result := '6';
    dt: Result := '7';
    dt: Result := '8';    {* Fach Bemerkung *}
    dt: Result := '9';    {* Gespraechsgrundlage *}
  end;
end;

procedure TfrmErfassung.Beenden1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmErfassung.mitOpenSchuelerClick(Sender: TObject);
var
  LastPath: string;
begin
  CheckAenderungen;

  LastPath := REG_Einstellungen.ReadString('OPEN', 'Lastpath', HomeVerzeichnis(Self));
  if DirectoryExists(LastPath) then
    OpenSchueler.InitialDir := LastPath
  else
    OpenSchueler.InitialDir := HomeVerzeichnis(Self);
  OpenSchueler.FileName := '';
  if OpenSchueler.Execute then
    DoLoadSchueler(OpenSchueler.FileName);
end;

procedure TfrmErfassung.mitDruckenClick(Sender: TObject);
begin
//  Printer.PrinterIndex := Printer.Printers.IndexOf(GetDefaultPrinter);

//  if PrintDialog1.Execute then
  begin
//    SetDefaultPrinter2(Printer.Printers.Strings[Printer.PrinterIndex]);

    frmErfassung.mitDrucken.Enabled := False;
    frmErfassung.tbDrucken.Enabled := False;

    frmErfassung.mitVorschau.Enabled := False;
    frmErfassung.tbVorschau.Enabled := False;

    LLWorker := TLLWorker.MyCreate(paPrint, PrepearXMLDoc(paPrint), Printer.PrinterIndex);
    LLWorker.Copies     := PrintDialog1.Copies;
    LLWorker.PrintRange := PrintDialog1.PrintRange;
    LLWorker.FromPage   := PrintDialog1.FromPage;
    LLWorker.ToPage     := PrintDialog1.ToPage;
    LLWorker.Start;
  end;
end;

procedure TfrmErfassung.DoDesign;
begin
{$IFDEF _LL26_}
  InitLL26;

  {D:  Dateiauswahldialog. Aufruf ist optional, sonst einfach in FileName den
       gewünschten Dateinamen übergeben. Wenn nur bestehende Dateien auswählbar
       sein sollen, muss die Veroderung mit LL_FILE_ALSONEW weggelassen werden}
  if FileExists(VorlageFile) then
  begin
    {D:  Daten definieren}
    {D:  Daten definieren}
    DefineCurrentRecord_LL26(True, nil, '0', '0', '', '', '', '0', '', 'F', 'F', 'F', 'F', 'F', '', '0');

    {D:  Designer mit dem Titel 'Design report' und der gewählten Datei starten }
    LL26.LlDefineLayout(Handle, 'Design report', LL_PROJECT_LIST, VorlageFile);
  end else
    MessageDlg('Der Report "' + VorlageFile + '" kann nicht gefunden werden!', mtError, [mbOK], 0);
{$ENDIF}
end;

{$IFDEF _LL26_}
function TfrmErfassung.DoPrint_LL26(const DruckXML: IXMLDocument;
  PrintAktion: TPrintAktion; WithDialog: Boolean): Integer;
var
  Idx, Idy: Integer;
  FachAktiv,NurBemerkung: Boolean;
  Bericht, GesprGrdl, FKompetenz, FachBez: string;
  Root, PersonalDaten: IXMLNode;
  ZeugnisNode, FachNode: IXMLNode;
  TextFachNode, RTFTextNode, BemerkungNode: IXMLNode;
  FachZusatzTextNode: IXMLNode;
  Schriftgrad, PrintJobName: string;
  FachZusatzText: string;

  procedure LLPrintFields_LL26;
  begin
    {D:  Tabellenzeile ausgeben, auf Rückgabewert prüfen und ggf. Seitenumbruch
         oder Abbruch auslösen}
    Result := LL26.LlPrintFields;
    if Result = LL_ERR_USER_ABORTED then
    begin
       {D:  Benutzerabbruch}
       LL26.LlPrintEnd(0);
       Exit;
    end else
    while Result = LL_WRN_REPEAT_DATA do
    begin
       LL26.LlPrint;
       Result := LL26.LlPrintFields;
    end;
  end;
begin
  InitLL26;  DruckDatenNr := 0;

  Result := 1;
  Root := DruckXML.DocumentElement;
  Assert(Assigned(Root), 'Root ist leer');
  if Root.HasAttribute('Bericht') then
    Bericht := b2s(s2b(VarToStr(Root.Attributes['Bericht'])));
  if Root.HasAttribute('GesprGrdl') then
    GesprGrdl := b2s(s2b(VarToStr(Root.Attributes['GesprGrdl'])));

  PersonalDaten := Root.ChildNodes.FindNode('PersonalDaten');
  Assert(Assigned(PersonalDaten), 'Personal Daten sind leer');

  if Assigned(PersonalDaten.ChildNodes.FindNode('Schuljahr')) then
    if Length(PersonalDaten.ChildValues['Schuljahr']) <= 2 then
      PersonalDaten.ChildValues['Schuljahr'] := cmbSchuljahr.Items.Strings[PersonalDaten.ChildValues['Schuljahr']];
  if Assigned(PersonalDaten.ChildNodes.FindNode('Konferenz')) then
    if StrToIntDef(VarToStr(PersonalDaten.ChildValues['Konferenz']), -1) <> -1 then
      PersonalDaten.ChildValues['Konferenz'] := DateTimeToXMLTime(VarToDateTime(PersonalDaten.ChildValues['Konferenz']));
  if Assigned(PersonalDaten.ChildNodes.FindNode('Ausstellungsdatum')) then
    if StrToIntDef(VarToStr(PersonalDaten.ChildValues['Ausstellungsdatum']), -1) <> -1 then
      PersonalDaten.ChildValues['Ausstellungsdatum'] := DateTimeToXMLTime(VarToDateTime(PersonalDaten.ChildValues['Ausstellungsdatum']));

  {D:  Daten definieren. Die hier übergebenen Daten dienen nur der Syntaxprüfung - die Inhalte
       brauchen keine Echtdaten zu enthalten}
  DefineCurrentRecord_LL26(False, PersonalDaten, '0', '0', ' ', ' ', ' ', '0', '', 'F', 'F', 'F', Bericht, GesprGrdl, '', '0');

  PapierFormat := GetPapierFormat;
  if PrintAktion = paVorschau then
  begin
    SetPapierFormat(DMPAPER_A4);
    LL26.LlPreviewSetTempPath(IncludeTrailingBackslash(GetEnvironmentVariable('temp')));
    LL26.LlPrintStart(LL_PROJECT_LIST, VorlageFile, LL_PRINT_PREVIEW);
    LL26.LlViewerProhibitAction(l26.vbPrintPage);
    LL26.LlViewerProhibitAction(l26.vbPrintAll);
    LL26.LlViewerProhibitAction(l26.vbSendTo);
    LL26.LlViewerProhibitAction(l26.vbSaveAs);
    LL26.LlViewerProhibitAction(l26.vbFax);
    LL26.LlViewerProhibitAction(l26.vbPrintPageWithPrinterSelection);
    LL26.LlViewerProhibitAction(l26.vbPrintAllWithPrinterSelection);
    LL26.LlViewerProhibitAction(l26.vbPreviousFile);
    LL26.LlViewerProhibitAction(l26.vbNextFile);
  end;
  if PrintAktion = paPrint then
  begin
    PrintJobName := VarToStr(PersonalDaten.ChildValues['Nachname']) + '_' + VarToStr(PersonalDaten.ChildValues['Vorname']) + '_' + VarToStr(PersonalDaten.ChildValues['KlasseZiffer']) + VarToStr(PersonalDaten.ChildValues['KlasseBuchstabe']);
    if s2b(Bericht) then
       PrintJobName := PrintJobName + '_Bericht';
    if s2b(GesprGrdl) then
       PrintJobName := PrintJobName + '_GesprGrdl';

    LL26.LlSetOption(LL_OPTION_RESETPROJECTSTATE_FORCES_NEW_DC, 1);
    LL26.LlSetOption(LL_OPTION_RESETPROJECTSTATE_FORCES_NEW_PRINTJOB, 1);
    Result := LL26.LlPrintWithBoxStart(LL_PROJECT_LIST, VorlageFile, LL_PRINT_NORMAL, LL_BOXTYPE_NORMALMETER, Self.Handle, StringReplace(PrintJobName, '_', ' ', [rfReplaceAll]));
    if Result = LL_ERR_USER_ABORTED then
    begin
      LL26.LlPrintEnd(0);
      Exit;
    end;

    if WithDialog then
    begin
      Result := LL26.LlPrintOptionsDialog(Handle, 'Druck-Parameter');
      if Result = LL_ERR_USER_ABORTED then
      begin
        LL26.LlPrintEnd(0);
        Exit;
      end;
    end;

  {D:  Druckoptionsdialog. Aufruf ist optional, es können sonst Ausgabeziel und
       Exportdateiname über LlXSetParameter() gesetzt werden bzw. der Drucker und
       die Druckoptionen über LlSetPrinterInPrinterFile() vorgegeben werden.}

//    LL26.LlPrintSetOption(LL_PRNOPT_COPIES, PrintDialog1.Copies);
//    if PrintDialog1.PrintRange = prPageNums then
//    begin
//      LL26.LlPrintSetOption(LL_PRNOPT_FIRSTPAGE, PrintDialog1.FromPage);
//      LL26.LlPrintSetOption(LL_PRNOPT_LASTPAGE, PrintDialog1.ToPage);
//    end;
    LL26.LlPrintSetOptionString(LL_PRNOPTSTR_PRINTJOBNAME, PrintJobName);
  end;
  {D:  Erste Seite initialisieren; auch hier kann schon durch Objekte vor der Tabelle
       ein Seitenumbruch ausgelöst werden}
  while LL26.LlPrint = LL_WRN_REPEAT_DATA do;

  // Ersteseite (Deckblatt) ausdrucken
  if not s2b(GesprGrdl) then
  begin
    DefineCurrentRecord_LL26(False, PersonalDaten, '6', '0', ' ', ' ', ' ', '0', '', 'F', 'F', 'F', Bericht, GesprGrdl, '', '0');
    LLPrintFields_LL26;
    LL26.LlPrint;
  end else
  begin
    DefineCurrentRecord_LL26(False, PersonalDaten, '9', '0', ' ', ' ', ' ', '0', '', 'F', 'F', 'F', Bericht, GesprGrdl, '', '0');
    LLPrintFields_LL26;
  end;

  {D:  Eigentliche Druckschleife; Wiederholung, solange Daten vorhanden}
  if s2b(GesprGrdl) then
    ZeugnisNode := Root.ChildNodes.FindNode('ZeugnisInhaltGGL');
  if not Assigned(ZeugnisNode) then
    ZeugnisNode := Root.ChildNodes.FindNode('ZeugnisInhalt');
  if Assigned(ZeugnisNode) then
  begin
    for Idx := 0 to ZeugnisNode.ChildNodes.Count - 1 do
    begin
      {D:  Jetzt Echtdaten für aktuellen Datensatz übergeben}
      FachNode := ZeugnisNode.ChildNodes[Idx];
      if FachNode.HasAttribute('Bezeichnung') then
        FachBez := CheckLexicon(VarToStr(FachNode.Attributes['Bezeichnung']))
      else
        if FachNode.HasAttribute('Name') then
          FachBez := CheckLexicon(VarToStr(FachNode.Attributes['Name']));

      NurBemerkung := (FachNode.ChildNodes.Count <= 2) and not Assigned(FachNode.ChildNodes.FindNode('TextFach'));

      FachAktiv := True;
      if FachNode.HasAttribute('Aktiv') then
        FachAktiv := s2b(VarToStr(FachNode.Attributes['Aktiv']));

      FKompetenz := 'F';
      if FachNode.HasAttribute('Kompetenz') then
        FKompetenz := VarToStr(FachNode.Attributes['Kompetenz']);

      if SameText(FachNode.NodeName, 'FACH') and FachAktiv then
      begin
        FachZusatzText := '';
        if s2b(VarToStrDef(FachNode.Attributes['Seitenumbruch'], 'F')) then
          LL26.LlPrint;

        TextFachNode := FachNode.ChildNodes.FindNode('TextFach');
        if Assigned(TextFachNode) then
        begin
          RTFTextNode := TextFachNode.ChildNodes.FindNode('RTFText');
          if Assigned(RTFTextNode) then
          begin
            Schriftgrad := IntToStr(MemoSGDef);
            if (GetPapierFormat = DMPAPER_A3) and (PrintAktion = paPrint) then
            begin
              if RTFTextNode.HasAttribute('Schriftgrad') then
                Schriftgrad := VarToStrDef(RTFTextNode.Attributes['Schriftgrad'], IntToStr(MemoSGDef));
              DefineCurrentRecord_LL26(False, PersonalDaten, '7', '0', FachBez, RTF2PlainText(VarToStrDef(RTFTextNode.NodeValue, '')),
                 CheckLexicon(SetRTFFontSize(RTFOhneFarbe(VarToStrDef(RTFTextNode.NodeValue, '')), StrToIntDef(Schriftgrad, MemoSGDef))),
                 '0', '', 'F', 'F', FKompetenz, Bericht, GesprGrdl, FachZusatzText, Schriftgrad)
            end else
              DefineCurrentRecord_LL26(False, PersonalDaten, '7', '0', FachBez, RTF2PlainText(VarToStrDef(RTFTextNode.NodeValue, '')),
                 CheckLexicon(RTFOhneFarbe(VarToStrDef(RTFTextNode.NodeValue, ''))),
                 '0', '', 'F', 'F', FKompetenz, Bericht, GesprGrdl, FachZusatzText, Schriftgrad);
            LLPrintFields_LL26;
          end;
          BemerkungNode := FachNode.ChildNodes.FindNode('Bemerkung');
          if Assigned(BemerkungNode) then
          begin
            Schriftgrad := VarToStrDef(BemerkungNode.ChildValues['Schriftgrad'], IntToStr(MemoSGDef));
            if (GetPapierFormat = DMPAPER_A3) and (PrintAktion = paPrint) then
              DefineCurrentRecord_LL26(False, PersonalDaten, '8', '0', FachBez, RTF2PlainText(VarToStrDef(BemerkungNode.ChildValues['Text'], '')),
                 SetRTFFontSize(TrimRTF(VarToStrDef(BemerkungNode.ChildValues['Text'], '')), StrToIntDef(Schriftgrad, MemoSGDef)),
                 '0', '', 'F', 'F', FKompetenz, Bericht, GesprGrdl, FachZusatzText, Schriftgrad)
            else
              DefineCurrentRecord_LL26(False, PersonalDaten, '8', '0', FachBez, RTF2PlainText(VarToStrDef(BemerkungNode.ChildValues['Text'], '')),
                 TrimRTF(VarToStrDef(BemerkungNode.ChildValues['Text'], '')),
                 '0', '', 'F', 'F', FKompetenz, Bericht, GesprGrdl, FachZusatzText, Schriftgrad);
            LLPrintFields_LL26;
          end;
        end else
        begin
          FachZusatzTextNode := FachNode.ChildNodes.FindNode('FachZusatz');
          if Assigned(FachZusatzTextNode) then
            FachZusatzText := Trim(VarToStrDef(FachZusatzTextNode.ChildValues['LabelText1'], '') + ' ' +
                              Trim(VarToStrDef(FachZusatzTextNode.ChildValues['Text'], '')) + ' ' +
                                   VarToStrDef(FachZusatzTextNode.ChildValues['LabelText2'], ''));

          DefineCurrentRecord_LL26(False, PersonalDaten, '1', '0', FachBez, FachBez, ' ', '0', '', VarToStr(FachNode.Attributes['Torten']), 'F', FKompetenz, Bericht, GesprGrdl, FachZusatzText, '0');
          LLPrintFields_LL26;

          for Idy := 0 to FachNode.ChildNodes.Count - 1 do
          begin
            if not SameText(FachNode.ChildNodes[Idy].NodeName, 'FACHZUSATZ') then
            begin
              if SameText(FachNode.ChildNodes[Idy].NodeName, 'PUNKT') then
              begin
                if StrToInt(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Wert'], '0')) >= 0 then
                  DefineCurrentRecord_LL26(False, PersonalDaten, '2', VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Farbe'], '0'), FachBez,
                     CheckLexicon(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Text'], ' ')), ' ',
                     VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Wert'], '0'),
                     VarToStrDef(FachNode.ChildNodes[Idy].ChildNodes.FindNode('Font').Attributes['FontStyle'], ''),
                     'F', 'F', 'F', Bericht, GesprGrdl, '', '0')
                else
                  DefineCurrentRecord_LL26(False, PersonalDaten, '3', VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Farbe'], '0'), FachBez,
                    CheckLexicon(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Text'], ' ')), ' ',
                    VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Wert'], '0'),
                    VarToStrDef(FachNode.ChildNodes[Idy].ChildNodes.FindNode('Font').Attributes['FontStyle'], ''),
                    'F', 'F', 'F', Bericht, GesprGrdl, '', '0');
                LLPrintFields_LL26;
              end;
              if SameText(FachNode.ChildNodes[Idy].NodeName, 'BEMERKUNG') then
              begin
                Schriftgrad := VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Schriftgrad'], IntToStr(MemoSGDef));
                if (GetPapierFormat = DMPAPER_A3) and (PrintAktion = paPrint) then
                  DefineCurrentRecord_LL26(False, PersonalDaten, '4', '0', FachBez,
      //              StringReplace(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Text'], ' '), '<br>', #13#10, [rfReplaceAll]), '0', '', 'F',
                    RTF2PlainText(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Text'], ' ')),
                    SetRTFFontSize(TrimRTF(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Text'], ' ')), StrToIntDef(Schriftgrad, MemoSGDef)),
                    '0', '', 'F', b2s(NurBemerkung), 'F', Bericht, GesprGrdl, '', Schriftgrad)
                else
                  DefineCurrentRecord_LL26(False, PersonalDaten, '4', '0', FachBez,
      //              StringReplace(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Text'], ' '), '<br>', #13#10, [rfReplaceAll]), '0', '', 'F',
                    RTF2PlainText(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Text'], ' ')),
                    TrimRTF(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Text'], ' ')),
                    '0', '', 'F', b2s(NurBemerkung), 'F', Bericht, GesprGrdl, '', Schriftgrad);
                LLPrintFields_LL26;
              end;

              if s2b(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Seitenumbruch'], 'F')) then
                LL26.LlPrint;
            end;
          end;
        end;
      end;

      {D:  Seitenumbruch auslösen, bis Datensatz vollständig gedruckt wurde}
      while Result = LL_WRN_REPEAT_DATA do
      begin
        LL26.LlPrint;
        Result := LL26.LlPrintFields;
      end;

      {D:  Fortschrittsanzeige aktualisieren}
      LL26.LlPrintSetBoxText('Drucken ...', Round(Idx/ZeugnisNode.ChildNodes.Count * 100));
    end;
  end;

  // Schulleiter(in) und Erziehungs Text Drucken
  DefineCurrentRecord_LL26(False, PersonalDaten, '5', '0', ' ', ' ', ' ', '0', '', 'F', 'F', 'F', Bericht, GesprGrdl, '', '0');
  LLPrintFields_LL26;

  {D:  Druck der Tabelle beenden, angehängte Objekte drucken}
  while LL26.LlPrintFieldsEnd = LL_WRN_REPEAT_DATA do;
  LL26.LlPrintSetBoxText('Fertig', 100);

  {D:  Druck beenden}
  LL26.LlPrintEnd(0);

  if (PrintAktion = paVorschau) and (PapierFormat <> 0) then
    SetPapierFormat(PapierFormat);
end;

procedure TfrmErfassung.InitLL26;
begin
  LL26.LlSetOptionString(LL_OPTIONSTR_LICENSINGINFO, 'RE2RHQ'); // LL 26
  LL26.LlSetOptionString(LL_OPTIONSTR_EXPORTS_ALLOWED_IN_PREVIEW, 'PRN');
  LL26.LlSetOptionString(LL_OPTION_INCREMENTAL_PREVIEW, 'TRUE');
end;

procedure TfrmErfassung.DefineCurrentRecord_LL26(ForDesign: Boolean;
  PersonalDaten: IXMLNode; ATyp, AFarbe, AFachName, AText, ARTFText, AWert,
  AFontStyle, ATorten, ANurBemerkung, AKompetenz, ABericht, AGesprGrdl,
  AFachZusatzText, ASchriftgrad: string);
begin
  if ForDesign then
  begin
    LL26.LlDefineVariableExt('Nachname', 'Mustermann', LL_TEXT);
    LL26.LlDefineVariableExt('Vorname', 'Max', LL_TEXT);
    LL26.LlDefineVariableExt('Klasse', '3', LL_TEXT);
    LL26.LlDefineVariableExt('KlasseBuchstabe', 'a', LL_TEXT);
    LL26.LlDefineVariableExt('Schuljahr', '2018/2019', LL_TEXT);
    LL26.LlDefineVariableExt('Halbjahr', '1', LL_NUMERIC);
    LL26.LlDefineVariableExt('Konferenz', '10.12.2018', LL_TEXT);
    LL26.LlDefineVariableExt('Ausstellungsdatum', '10.12.2018', LL_TEXT);
    LL26.LlDefineVariableExt('Versaeumnisse', '5', LL_TEXT);
    LL26.LlDefineVariableExt('Logo', ApplicationPath + 'Reports\Logo.png', LL_DRAWING);
    LL26.LlDefineVariableExt('FSP', b2s(edFoerderschwerpunkt.Visible), LL_BOOLEAN);
    LL26.LlDefineVariableExt('Foerderschwerpunkt', 'Foerderschwerpunkt', LL_TEXT);
    LL26.LlDefineVariableExt('Bericht', 'F', LL_BOOLEAN);
    LL26.LlDefineVariableExt('GesprGrdl', 'F', LL_BOOLEAN);

    LL26.LlDefineFieldExt('DruckDatenNr', '1', LL_NUMERIC);
    LL26.LlDefineFieldExt('Typ', '1', LL_NUMERIC);
    LL26.LlDefineFieldExt('FachName', 'Deutsch', LL_TEXT);
    LL26.LlDefineFieldExt('Farbe', '0', LL_NUMERIC);
    LL26.LlDefineFieldExt('Text', 'Text', LL_TEXT);
    LL26.LlDefineFieldExt('RTFText', RTFBeispiel, LL_RTF);
    LL26.LlDefineFieldExt('Wert', '80', LL_NUMERIC);
    LL26.LlDefineFieldExt('FontStyle', '', LL_TEXT);
    LL26.LlDefineFieldExt('Torten', 'F', LL_BOOLEAN);
    LL26.LlDefineFieldExt('NurBemerkung', 'F', LL_BOOLEAN);
    LL26.LlDefineFieldExt('Kompetenz', 'F', LL_BOOLEAN);
    LL26.LlDefineFieldExt('FachZusatzText', 'FachZusatzText', LL_TEXT);
    LL26.LlDefineFieldExt('Schriftgrad', IntToStr(MemoSGDef), LL_NUMERIC);
    LL26.LlDefineFieldExt('Torte_100', ApplicationPath + 'Reports\Torte_100.png', LL_DRAWING);
    LL26.LlDefineFieldExt('Torte_80',  ApplicationPath + 'Reports\Torte_80.png', LL_DRAWING);
    LL26.LlDefineFieldExt('Torte_60',  ApplicationPath + 'Reports\Torte_60.png', LL_DRAWING);
    LL26.LlDefineFieldExt('Torte_40',  ApplicationPath + 'Reports\Torte_40.png', LL_DRAWING);
    LL26.LlDefineFieldExt('Torte_20',  ApplicationPath + 'Reports\Torte_20.png', LL_DRAWING);
  end else
  begin
    Inc(DruckDatenNr);
    LL26.LlDefineVariableExt('Nachname', VarToStr(PersonalDaten.ChildValues['Nachname']), LL_TEXT);
    LL26.LlDefineVariableExt('Vorname', VarToStr(PersonalDaten.ChildValues['Vorname']), LL_TEXT);
    LL26.LlDefineVariableExt('Klasse', VarToStr(PersonalDaten.ChildValues['KlasseZiffer']), LL_TEXT);
    LL26.LlDefineVariableExt('KlasseBuchstabe', VarToStr(PersonalDaten.ChildValues['KlasseBuchstabe']), LL_TEXT);
    LL26.LlDefineVariableExt('Schuljahr', VarToStr(PersonalDaten.ChildValues['Schuljahr']), LL_TEXT);
    LL26.LlDefineVariableExt('Halbjahr', PersonalDaten.ChildValues['Halbjahr'], LL_NUMERIC);
    LL26.LlDefineVariableExt('Konferenz', DateToStr(XMLTimeToDateTime(PersonalDaten.ChildValues['Konferenz'])), LL_TEXT);
    LL26.LlDefineVariableExt('Ausstellungsdatum', DateToStr(XMLTimeToDateTime(PersonalDaten.ChildValues['Ausstellungsdatum'])), LL_TEXT);
    if Assigned(PersonalDaten.ChildNodes.FindNode('Versaeumnisse2')) then
      LL26.LlDefineVariableExt('Versaeumnisse', VarToStr(PersonalDaten.ChildValues['Versaeumnisse2']), LL_TEXT)
    else
      LL26.LlDefineVariableExt('Versaeumnisse', VarToStr(PersonalDaten.ChildValues['Versaeumnisse']), LL_TEXT);
    LL26.LlDefineVariableExt('Logo',  ApplicationPath + 'Reports\Logo.png', LL_DRAWING);
    LL26.LlDefineVariableExt('FSP', b2s(Assigned(PersonalDaten.ChildNodes.FindNode('Foerderschwerpunkt'))), LL_BOOLEAN);
    if Assigned(PersonalDaten.ChildNodes.FindNode('Foerderschwerpunkt')) then
      LL26.LlDefineVariableExt('Foerderschwerpunkt', VarToStrDef(PersonalDaten.ChildValues['Foerderschwerpunkt'], ''), LL_TEXT)
    else
      LL26.LlDefineVariableExt('Foerderschwerpunkt', 'Foerderschwerpunkt', LL_TEXT);
    LL26.LlDefineVariableExt('Bericht', ABericht, LL_BOOLEAN);
    LL26.LlDefineVariableExt('GesprGrdl', AGesprGrdl, LL_BOOLEAN);

    LL26.LlDefineFieldExt('DruckDatenNr', IntToStr(DruckDatenNr), LL_NUMERIC);
    LL26.LlDefineFieldExt('Typ', ATyp, LL_NUMERIC);
    LL26.LlDefineFieldExt('FachName', AFachName, LL_TEXT);
    LL26.LlDefineFieldExt('Farbe', AFarbe, LL_NUMERIC);
    LL26.LlDefineFieldExt('Text', AText, LL_Text);
    LL26.LlDefineFieldExt('RTFText', ARTFText, LL_RTF);
    LL26.LlDefineFieldExt('Wert', AWert, LL_NUMERIC);
    LL26.LlDefineFieldExt('FontStyle', AFontStyle, LL_TEXT);
    LL26.LlDefineFieldExt('Torten', ATorten, LL_BOOLEAN);
    LL26.LlDefineFieldExt('NurBemerkung', ANurBemerkung, LL_BOOLEAN);
    LL26.LlDefineFieldExt('Kompetenz', AKompetenz, LL_BOOLEAN);
    LL26.LlDefineFieldExt('FachZusatzText', AFachZusatzText, LL_TEXT);
    LL26.LlDefineFieldExt('Schriftgrad', ASchriftgrad, LL_NUMERIC);
    LL26.LlDefineFieldExt('Torte_100', ApplicationPath + 'Reports\Torte_100.png', LL_DRAWING);
    LL26.LlDefineFieldExt('Torte_80',  ApplicationPath + 'Reports\Torte_80.png', LL_DRAWING);
    LL26.LlDefineFieldExt('Torte_60',  ApplicationPath + 'Reports\Torte_60.png', LL_DRAWING);
    LL26.LlDefineFieldExt('Torte_40',  ApplicationPath + 'Reports\Torte_40.png', LL_DRAWING);
    LL26.LlDefineFieldExt('Torte_20',  ApplicationPath + 'Reports\Torte_20.png', LL_DRAWING);
  end;
end;
{$ENDIF}

procedure TfrmErfassung.PersonalDaten2XML;
begin
  if Assigned(Root) then
  begin
    if not Assigned(PersonalDatenNode) then
      PersonalDatenNode := Root.AddChild('PersonalDaten', 0);
    PersonalDatenNode.ChildValues['Nachname']             := Trim(edNachname.Text);
    PersonalDatenNode.ChildValues['Vorname']              := Trim(edVorname.Text);
    PersonalDatenNode.ChildValues['KlasseZiffer']         := edKlasse.Text;
    PersonalDatenNode.ChildValues['KlasseBuchstabe']      := cmbKlasse.Items.Strings[cmbKlasse.ItemIndex];
    PersonalDatenNode.ChildValues['Schuljahr']            := cmbSchuljahr.Items.Strings[cmbSchuljahr.ItemIndex];
    PersonalDatenNode.ChildValues['Halbjahr']             := FHalbJahr;
    PersonalDatenNode.ChildValues['Konferenz']            := DateTimeToXMLTime(Int(dtKonferenzbeschluss.Date));
    PersonalDatenNode.ChildValues['Ausstellungsdatum']    := DateTimeToXMLTime(Int(dtAusstellungsdatum.Date));
    PersonalDatenNode.ChildValues['Versaeumnisse2']       := cmbVersaeumnisse.Items.Strings[cmbVersaeumnisse.ItemIndex];
    if edFoerderschwerpunkt.Visible then
      PersonalDatenNode.ChildValues['Foerderschwerpunkt'] := edFoerderschwerpunkt.Text
    else
      if Assigned(PersonalDatenNode.ChildNodes.FindNode('Foerderschwerpunkt')) then
        PersonalDatenNode.ChildNodes.Remove(PersonalDatenNode.ChildNodes.FindNode('Foerderschwerpunkt'));
  end;
end;

procedure TfrmErfassung.Info1Click(Sender: TObject);
var
  AboutBox: TAboutBox;
begin
  AboutBox := TAboutBox.Create(Self);
  with AboutBox do
  try
    ShowModal;
  finally
    Free;
  end;
end;

function TfrmErfassung.IstXMLDatei(const FileName: TFileName): Boolean;
var
  TmpStrLst: TStringList;
begin
  TmpStrLst := TStringList.Create;
  try
    TmpStrLst.LoadFromFile(FileName);
    Result := IsXML(TmpStrLst.Text);
  finally
    TmpStrLst.Free;
  end;
end;

procedure TfrmErfassung.DoLoadSchueler(const SchuelerFile: TFileName);
var
  SFVersion: Integer;
  EncriptFileName, TempFileName: TFileName;
begin
  TempFileName := SchuelerFile;
  if {(ExtractFileExt(SchuelerFile) = '.xschueler') and} not IstXMLDatei(SchuelerFile) then
  begin
    EncriptFileName := GetTempFile;
    Codec1.DecryptFile(EncriptFileName, SchuelerFile);
    TempFileName := EncriptFileName;
  end;
  if FileExists(TempFileName) and IstXMLDatei(TempFileName) then
  begin
    FileName := SchuelerFile;

    XMLSchueler.XML.Clear;
    XMLSchueler.LoadFromFile(TempFileName);
    Root := XMLSchueler.DocumentElement;

    PersonalDatenNode := nil;
    ZeugnisInhaltNode := nil;
    ZeugnisInhaltGGLNode := nil;

    SFVersion := 1;
    if Root.HasAttribute('Version') then
       SFVersion := StrToIntDef(VarToStr(Root.Attributes['Version']), 0);
    if SFVersion > SchueleVersion then
    begin
      MessageDlg('Die Schülerdatei ist nicht lesbar. Sie wurde von einer neueren Version der Software erzeugt!'+#13#10+
                 'Bitte führen Sie ein Update durch!', mtError, [mbOK], 0);
      FileName := '';
      Abort;
    end;

    if FileExists(EncriptFileName) then
      DeleteFile(EncriptFileName);

    LoadDocumnetInfo(Root);

    if Root.HasAttribute('LastChange') then
    begin
      if StrToDateTimeDef(VarToStr(Root.Attributes['LastChange']), -1) = -1 then
        StatusBar.Panels.Items[1].Text := DateTimeToStr(XMLTimeToDateTime(VarToStr(Root.Attributes['LastChange'])))
      else
        StatusBar.Panels.Items[1].Text := VarToStr(Root.Attributes['LastChange']);
    end else
      StatusBar.Panels.Items[1].Text := 'unbekannt';

    if Root.ChildNodes.Count > 0 then
    begin
      InXMLToTabSheet := True;
      try
        PersonalDatenNode := Root.ChildNodes.FindNode('PersonalDaten');
        if Assigned(PersonalDatenNode) then
        begin
          if Assigned(PersonalDatenNode.ChildNodes.FindNode('Nachname')) then
            edNachname.Text := VarToStr(PersonalDatenNode.ChildValues['Nachname']);
          if Assigned(PersonalDatenNode.ChildNodes.FindNode('Vorname')) then
            edVorname.Text := VarToStr(PersonalDatenNode.ChildValues['Vorname']);
          StatusBar.Panels.Items[2].Text := 'Schüler(in): ' + edNachname.Text + ' ' + edVorname.Text;
          if Assigned(PersonalDatenNode.ChildNodes.FindNode('KlasseZiffer')) then
            edKlasse.Text := VarToStr(PersonalDatenNode.ChildValues['KlasseZiffer']);
          if Assigned(PersonalDatenNode.ChildNodes.FindNode('KlasseBuchstabe')) then
            cmbKlasse.ItemIndex := cmbKlasse.Items.IndexOf(VarToStr(PersonalDatenNode.ChildValues['KlasseBuchstabe']));
          StatusBar.Panels.Items[0].Text := 'Klasse: ' + edKlasse.Text + cmbKlasse.Items.Strings[cmbKlasse.ItemIndex];
          if Assigned(PersonalDatenNode.ChildNodes.FindNode('Schuljahr')) then
            if Length(VarToStr(PersonalDatenNode.ChildValues['Schuljahr'])) > 2 then
              cmbSchuljahr.ItemIndex := cmbSchuljahr.Items.IndexOf(VarToStr(PersonalDatenNode.ChildValues['Schuljahr']))
            else
              cmbSchuljahr.ItemIndex := PersonalDatenNode.ChildValues['Schuljahr'];
          if Assigned(PersonalDatenNode.ChildNodes.FindNode('Halbjahr')) then
            FHalbJahr := PersonalDatenNode.ChildValues['Halbjahr'];
          dtKonferenzbeschluss.Date := XMLNodeStrToDate(PersonalDatenNode.ChildNodes.FindNode('Konferenz'));
          dtAusstellungsdatum.Date  := XMLNodeStrToDate(PersonalDatenNode.ChildNodes.FindNode('Ausstellungsdatum'));
          if Assigned(PersonalDatenNode.ChildNodes.FindNode('Versaeumnisse2')) then
            cmbVersaeumnisse.ItemIndex := cmbVersaeumnisse.Items.IndexOf(PersonalDatenNode.ChildValues['Versaeumnisse2'])
          else
          if Assigned(PersonalDatenNode.ChildNodes.FindNode('Versaeumnisse')) then
          begin
            if SFVersion = 1 then
            begin
              if PersonalDatenNode.ChildValues['Versaeumnisse'] > 0 then
                cmbVersaeumnisse.ItemIndex := PersonalDatenNode.ChildValues['Versaeumnisse'] + 1
              else
                cmbVersaeumnisse.ItemIndex := 0;
            end else
              cmbVersaeumnisse.ItemIndex := PersonalDatenNode.ChildValues['Versaeumnisse'];
          end;
          if Assigned(PersonalDatenNode.ChildNodes.FindNode('Foerderschwerpunkt')) then
            edFoerderschwerpunkt.Text := VarToStr(PersonalDatenNode.ChildValues['Foerderschwerpunkt']);
          Self.Caption := GSHoisbuettel + '   ' + StatusBar.Panels.Items[0].Text + ' ' + StatusBar.Panels.Items[2].Text;
        end;

        ZeugnisInhaltNode := Root.ChildNodes.FindNode('ZeugnisInhalt');
        ZeugnisInhaltGGLNode := Root.ChildNodes.FindNode('ZeugnisInhaltGGL');

        pgZeugnisControl.Visible := False;
        tabZeugnis.TabVisible := Assigned(ZeugnisInhaltNode) and Assigned(ZeugnisInhaltGGLNode);
        tabZeugnisGGL.TabVisible := Assigned(ZeugnisInhaltNode) and Assigned(ZeugnisInhaltGGLNode);
        pgZeugnisControl.ActivePage := tabZeugnis;
        if Assigned(ZeugnisInhaltNode) then
        begin
          if ZeugnisInhaltNode.HasAttribute('Bezeichnung') then
            tabZeugnis.Caption := ZeugnisInhaltNode.Attributes['Bezeichnung'];
          XMLToTabSheet(pgZeugnis, ZeugnisInhaltNode, False);
        end;
        if Assigned(ZeugnisInhaltGGLNode) then
        begin
          if ZeugnisInhaltGGLNode.HasAttribute('Bezeichnung') then
            tabZeugnisGGL.Caption := ZeugnisInhaltGGLNode.Attributes['Bezeichnung'];
          XMLToTabSheet(pgZeugnisGGL, ZeugnisInhaltGGLNode, False);
        end;
      finally
        pgZeugnisControl.Visible := True;
        InXMLToTabSheet := False;
      end;
    end;

    REG_Einstellungen.WriteString('OPEN', 'Lastpath', IncludeTrailingBackslash(ExtractFilePath(SchuelerFile)));
    RecentList.CustomItemAdd(SchuelerFile);
    edNachname.SetFocus;
  end else
  begin
    MessageDlg('Die Datei existiert nicht oder hat ein ungültiges Format!', mtError, [mbOK], 0);
  end;
end;

function TfrmErfassung.CreateFachTabSheet(aPageControl: TPageControl; const FachNode, FachGGLNode: IXMLNode;
  AlignBlocksatz: Boolean): TFachTabSheet;
var
  Idx: Integer;
  FachID, FachBez: string;
  NurBemerkung: Boolean;
  ScrollBoxEingabe: TScrollBox;
  Splitter: TSplitter;
  FTextFach       : TfrmTextFach;
  FZusatzFach     : TfrmZusatzFach;
  FachZusatzNode  : IXMLNode;
  TextFachNode    : IXMLNode;
  BemerkungNode, BemerkungGGLNode: IXMLNode;
begin
  Result := nil;

  if Assigned(FachNode) then
  begin
    if FachNode.HasAttribute('Name')then
    begin
      if not FFSP then
        FachBez := Trim(StringReplace(VarToStr(FachNode.Attributes['Name']), '*', '', []))
      else
        FachBez := VarToStr(FachNode.Attributes['Name']);
      FachID := Trim(StringReplace(VarToStr(FachNode.Attributes['Name']), '*', '', []));
    end;

    if FachNode.HasAttribute('Bezeichnung')then
    begin
      if not FFSP then
        FachBez := Trim(StringReplace(VarToStr(FachNode.Attributes['Bezeichnung']), '*', '', []))
      else
        FachBez := VarToStr(FachNode.Attributes['Bezeichnung']);
    end;

    FachZusatzNode := FachNode.ChildNodes.FindNode('FachZusatz');
    TextFachNode   := FachNode.ChildNodes.FindNode('TextFach');
    BemerkungNode  := FachNode.ChildNodes.FindNode('Bemerkung');
    NurBemerkung   := (FachNode.ChildNodes.Count <= 2) and not Assigned(TextFachNode);

    if Assigned(FachGGLNode) then
      BemerkungGGLNode := FachGGLNode.ChildNodes.FindNode('Bemerkung');

    Result := TFachTabSheet.Create(aPageControl);
    Result.PageControl     := aPageControl;
    Result.FID             := FachID;
//    Result.Name            := GetUniqueComponentName(NormalizeString('ts' + FachName));
    Result.Caption         := FachBez;
    if FachNode.HasAttribute('Seitenumbruch') then
      Result.Seitenumbruch := s2b(VarToStr(FachNode.Attributes['Seitenumbruch']));
    if FachNode.HasAttribute('Torten') then
      Result.Torten        := s2b(VarToStr(FachNode.Attributes['Torten']));
    if FachNode.HasAttribute('Kompetenz') then
      Result.Kompetenz     := s2b(VarToStr(FachNode.Attributes['Kompetenz']));

    if FachNode.HasAttribute('Aktiv') then
    begin
      Result.FFachStatus := fsNoAktiv;
      if s2b(VarToStr(FachNode.Attributes['Aktiv'])) then
      begin
        rbReligion.Checked := SameText(FachID, 'Religion');
        rbPhilosophie.Checked := SameText(FachID, 'Philosophie');
        Result.FFachStatus := fsAktiv;
      end else
        Result.TabVisible := False;
    end;

    if not NurBemerkung then
    begin
      if Assigned(TextFachNode) then
      begin
        FTextFach := TfrmTextFach.Create(Result);
        FTextFach.OnTextFachChange := OnChangeEreignis;
        FTextFach.OnFachPunktChange := OnFachPunktChangeFromText;
        FTextFach.FachID := Result.FID;
        FTextFach.InitFromXML(TextFachNode, FachGGLNode, AlignBlocksatz);
        FTextFach.Show;
      end else
      begin
        if Assigned(FachZusatzNode) then
        begin
          FZusatzFach := TfrmZusatzFach.Create(Result);
          FZusatzFach.OnZusatzFachChange := OnChangeEreignis;
          FZusatzFach.InitFromXML(FachZusatzNode);
          FZusatzFach.Show;
        end;

        TfrmTorte.Create(Result).Show;

        ScrollBoxEingabe := TScrollBox.Create(Result);
        ScrollBoxEingabe.Parent := Result;
  //      ScrollBoxEingabe.Name := GetUniqueComponentName(NormalizeString('scr' + FachName + 'Eingabe'));
        ScrollBoxEingabe.ParentBackground := False;
        ScrollBoxEingabe.Tag := 10;
        ScrollBoxEingabe.Align := alClient;
        ScrollBoxEingabe.OnResize := scrEingabeOnResize;
        ScrollBoxEingabe.BorderStyle := bsNone;
  //      ScrollBoxEingabe.VertScrollBar.Tracking := True;
  //      ScrollBoxEingabe.AutoScroll := False;

        Result.FScrollBox := ScrollBoxEingabe;

        for Idx := 0 to FachNode.ChildNodes.Count - 1 do
        begin
          if SameText(VarToStr(FachNode.ChildNodes[Idx].NodeName), 'PUNKT') then
          begin
            with TfrmFachPunkt.Create(ScrollBoxEingabe) do
            begin
              FachID := Result.FID;
              OnFachPunktChange   := OnChangeEreignis;
              OnFachPunktDblClick := FachPunktDblClick;
              OnPunktFachChange   := OnFachPunktChangeFromPunkt;
              InitFromXML(FachNode.ChildNodes[Idx]);
              Show;
            end;
          end;
        end;
      end;

      Splitter := TSplitter.Create(Result);
      Splitter.Parent := Result;
      Splitter.Color := clTeal;
      Splitter.Align := alCustom;
      Splitter.Height := 2;
      Splitter.Width := Result.Width;
      Splitter.OnMoved := SplitterMoved;
      Splitter.Align := alBottom;
    end;

    Result.FBemerkung := TfrmBemerkung.Create(Result);
    Result.FBemerkung.FachID := FachID;
    Result.FBemerkung.PageControlName := aPageControl.Name;
    Result.FBemerkung.OnBemerkungChange := OnABemerkungChange;
    Result.FBemerkung.NurBemerkung := NurBemerkung;
    Result.FBemerkung.SchriftgradVisible := (NurBemerkung and not FBericht) or FBericht;
    Result.FBemerkung.InitFromXML(BemerkungNode, BemerkungGGLNode, AlignBlocksatz);

    Result.FBemerkung.PopupActionBar.Images := ImageList;
    Result.FBemerkung.mitUndo.Action        := EditUndo;
    Result.FBemerkung.mitRedo.Action        := EdiTRedo;
    Result.FBemerkung.mitCut.Action         := EditCut;
    Result.FBemerkung.mitCopy.Action        := EditCopy;
    Result.FBemerkung.mitPaste.Action       := EditPaste;
    Result.FBemerkung.mitSelectAll.Action   := EditSelectAll;
//    Result.FBemerkung.mitDelete.Action      := EditDelete;

    Result.FBemerkung.mitAlignLeft.Action   := FormatRichEditAlignLeft;
    Result.FBemerkung.mitAlignCenter.Action := FormatRichEditAlignCenter;
    Result.FBemerkung.mitAlignRight.Action  := FormatRichEditAlignRight;
    Result.FBemerkung.mitAlignBlock.Action  := FormatRichEditAlignBlocksatz;

    Result.FBemerkung.Show;
  end;
end;

procedure TfrmErfassung.FachPunktDblClick(Sender: TObject);
var
  Passwort: string;
  Std, Min, Sek, MSek: Word;
begin
  if not EditModus then
  begin
    if InputQuery('Bearbeiten Modus', 'Passwort:', Passwort) then
    begin
      DecodeTime(Now, Std, Min, Sek, MSek);
      if Passwort = FormatFloat('00', Std) + FormatFloat('00', Min) then
        EditModus := True
      else
        Abort;
    end else
      Abort;
  end;
end;

function TfrmErfassung.FindAtributeNode(Input: IXMLNode; const AttributesName, AttributesValue: WideString): IXMLNode;
var
  Idx: Integer;
begin
  Result := nil;
  if Assigned(Input) then
  begin
    if Input.HasChildNodes then
      for Idx := 0 to Input.ChildNodes.Count - 1 do
        if Input.ChildNodes[Idx].HasAttribute(AttributesName) then
           if SameText(VarToStr(Input.ChildNodes[Idx].Attributes[AttributesName]), AttributesValue) then
           begin
             Result := Input.ChildNodes[Idx];
             Break;
           end;
  end;
end;

procedure TfrmErfassung.FormActivate(Sender: TObject);
begin
  LLVorschauToFront;
end;

procedure TfrmErfassung.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  MessDlgResult: Integer;
  LLWindow: THandle;
begin
  LLWindow := FindWindow(PChar('L&LViewer'), PChar('Vorschau'));
  CanClose := LLWindow = 0;

  if CanClose then
    CanClose := FLLObjekts.Count = 0;

  if CanClose and Change then
  begin
    CanClose := False;
    MessDlgResult := MessageDlg('Möchten Sie die Änderungen speichern?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    case MessDlgResult of
      mrYes: if IstEingabeOK then
             begin
                mitSpeichernClick(nil);
                CanClose := True;
             end else
               Abort;
      mrNo: CanClose := True;
      mrCancel: Abort;
    end;
  end;
end;

procedure TfrmErfassung.FormCreate(Sender: TObject);
var
  WindowStateInt: Integer;
  ATop: Integer;
  ALeft: Integer;
  AWidth: Integer;
  AHeight: Integer;
begin
//  InstallExt('.schueler', 'ZeugnisFile', 'Zeugnis File', ParamStr(0), '%1', 1);
//  InstallExt('.xschueler', 'VerschlZeugnisFile', 'Verschl. Zeugnis File', ParamStr(0), '%1', 2);

  XMLSchueler.Active := True;
  XMLSchueler.Encoding := 'UTF-8';
  XMLSchueler.Options := XMLSchueler.Options + [doNodeAutoIndent];

{$IFDEF _LL26_}
  LL26 := TL26_.Create(Self);
  LL26.Language := l26.ltDeutsch;
  LL26.LicensingInfo := 'RE2RHQ';

  LL26Preview := TLl26PreviewControl.Create(Self);
  LL26Preview.Parent := pnlQuickPreview;
  LL26Preview.Align := alClient;
  LL26Preview.ShowToolbar := False;
  LL26Preview.CloseMode := l26.cmDeleteFile;
{$ENDIF}

  Ini2Reg(Self);
  Fehler := TStringList.Create;

  Application.OnActivate := FormActivate;

{$IFDEF DEBUG}
  Label1.Visible := True;
{$ELSE}
  Label1.Visible := False;
{$ENDIF}

  Codec1.Password := GSHoisbuettel;
  InitComboBox;
//  Clipboard.Clear;

  Constraints.MinHeight := 600;
  if Screen.WorkAreaWidth > 1050 then
  begin
    Constraints.MinWidth := 1050;
    chkQuickPreview.Anchors := [akTop, akRight];
  end else
  begin
    Constraints.MinWidth := 800;
    chkQuickPreview.Anchors := [akTop, akLeft];
  end;

  RecentList := TRecentListe.Create(Self, mitRecentFiles, 10, RecentListClick);

  DragAcceptFiles(Self.Handle, True);

  StatusPanelFarbe := 1;
  EditModus := False;

  InXMLToTabSheet := False;

//  SpinButtonWatch.OnSpinButtonClick := DoOnSpinButtonClick;
//  StartMouseHook(True, Handle);

  FormatRichEditAlignBlocksatz := TRichEditAlignBlocksatz.Create(Self);
  FormatRichEditAlignBlocksatz.Name := 'FormatRichEditAlignBlocksatz';
  FormatRichEditAlignBlocksatz.Category := 'Format';
  FormatRichEditAlignBlocksatz.AutoCheck := True;
  FormatRichEditAlignBlocksatz.Caption := '&Blocksatz';
  FormatRichEditAlignBlocksatz.Hint := 'Blocksatz|Text am linken und rechten Rand ausrichten';
  FormatRichEditAlignBlocksatz.ImageIndex := 19;

  EdiTRedo := TEditRedo.Create(Self);
  EdiTRedo.Name := 'EditRedo';
  EdiTRedo.Category := 'Bearbeiten';
  EdiTRedo.Caption := '&Wiederholen';
  EdiTRedo.Hint := 'Wiederholen';
  EdiTRedo.ShortCut := ShortCut(Ord('Z'), [ssShift, ssCtrl]); //16473 - Shift+Ctrl+Z
  EdiTRedo.ImageIndex := 10;

  tbAlignBlock.Action := FormatRichEditAlignBlocksatz;
  mitAlignBlock.Action := FormatRichEditAlignBlocksatz;

  mitRedo.Action := EdiTRedo;

  WindowStateInt := REG_Einstellungen.ReadInteger('FORM', 'WindowState', 0);

  ATop    := REG_Einstellungen.ReadInteger('FORM', 'Top', 50);
  ALeft   := REG_Einstellungen.ReadInteger('FORM', 'Left', 50);
  AWidth  := REG_Einstellungen.ReadInteger('FORM', 'Width', IfThen(Screen.WorkAreaWidth > 930, 930, Screen.WorkAreaWidth - 10));
  AHeight := REG_Einstellungen.ReadInteger('FORM', 'Height', IfThen(Screen.WorkAreaHeight > 650, 650, Screen.WorkAreaHeight - 10));

  chkQuickPreview.Checked := REG_Einstellungen.ReadBool('EINGABE', 'QuickVorschau', False);
  pnlQuickPreview.Width := REG_Einstellungen.ReadInteger('EINGABE', 'PnlQuickVorschauWidth', 185);

  case WindowStateInt of
    0: begin
         WindowState := wsNormal;
         Top := ATop;
         Left := ALeft;
         Width := IfThen(Screen.WorkAreaWidth < AWidth, Screen.WorkAreaWidth - 10, AWidth);
         Height := IfThen(Screen.WorkAreaHeight < AHeight, Screen.WorkAreaHeight - 10, AHeight);
       end;
    1: WindowState := wsNormal;
    2: WindowState := wsMaximized;
  end;

  InitEingabe('', 0, 0, False);
end;

procedure TfrmErfassung.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  case WindowState of
    wsNormal: begin
                REG_Einstellungen.WriteInteger('FORM', 'WindowState', 0);
                REG_Einstellungen.WriteInteger('FORM', 'Top', Self.Top);
                REG_Einstellungen.WriteInteger('FORM', 'Left', Self.Left);
                REG_Einstellungen.WriteInteger('FORM', 'Width', Self.Width);
                REG_Einstellungen.WriteInteger('FORM', 'Height', Self.Height);
              end;
    wsMinimized: REG_Einstellungen.WriteInteger('FORM', 'WindowState', 1);
    wsMaximized: REG_Einstellungen.WriteInteger('FORM', 'WindowState', 2);
  end;

  DragAcceptFiles(Self.Handle, False);

  REG_Einstellungen.WriteBool('EINGABE', 'QuickVorschau', chkQuickPreview.Checked);
  REG_Einstellungen.WriteInteger('EINGABE', 'PnlQuickVorschauWidth', pnlQuickPreview.Width);

//  StopMouseHook;
  if FileExists(LLVorschauDatei) then
    DeleteFile(LLVorschauDatei);

  XMLSchueler.Active := False;

  RecentList.Free;
  FormatRichEditAlignBlocksatz.Free;
  EdiTRedo.Free;
{$IFDEF _LL26_}
  LL26.Free;
{$ENDIF}
  Fehler.Free;
//  Clipboard.Free;
end;

procedure TfrmErfassung.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = Ord('D')) and (Shift = [ssCtrl, ssShift]) then
    DoDesign;
end;

procedure TfrmErfassung.FormResize(Sender: TObject);
var
  Idx: Integer;
  FachName: string;
begin
  for Idx := 0 to pgZeugnis.PageCount - 1 do
  begin
    if pgZeugnis.Pages[Idx].TabVisible and (pgZeugnis.Pages[Idx] is TFachTabSheet) then
    begin
      FachName := TFachTabSheet(pgZeugnis.Pages[Idx]).FID;
      if Assigned(TFachTabSheet(pgZeugnis.Pages[Idx]).FBemerkung) and not TFachTabSheet(pgZeugnis.Pages[Idx]).FBemerkung.NurBemerkung then
        TFachTabSheet(pgZeugnis.Pages[Idx]).FBemerkung.Height := Trunc(REG_Einstellungen.ReadFloat(Trim(StringReplace('Faecher\' + FachName, '*', '', [])), 'Height Prozent', 15) * pgZeugnis.Height / 100);
    end;
  end;

  pnlQuickPreview.Width := Trunc(REG_Einstellungen.ReadFloat('EINGABE', 'PnlQuickVorschauWidth Prozent', 25) * pgZeugnis.Width / 100);
  pgZeugnis.Invalidate;
end;

procedure TfrmErfassung.FormShow(Sender: TObject);
begin
  CheckAenderungen;

  if (ParamCount > 0) and (ParamStr(1) <> '') then
    DoLoadSchueler(ParamStr(1));
end;

procedure TfrmErfassung.SetChange(const Value: Boolean);
begin
  FChange := Value;
  tbSave.Enabled := Change;
  mitSpeichern.Enabled := Change;
  mitStapeldruck.Enabled := not Change;
//  tbSaveAs.Enabled := Change;
//  mitSpeichernUnter.Enabled := Change;
  QVFertig := False;

  LastChange := Now;
end;

procedure TfrmErfassung.SetFileName(const Value: TFileName);
begin
  FFileName := Value;

  tbSaveAs.Enabled          := FileName <> '';
  mitSpeichernUnter.Enabled := FileName <> '';
  tbVorschau.Enabled        := FileName <> '';
  mitVorschau.Enabled       := FileName <> '';
  tbDrucken.Enabled         := FileName <> '';
  mitDrucken.Enabled        := FileName <> '';
  mitEingabepruefen.Enabled := FileName <> '';
  tbEingabepruefen.Enabled  := FileName <> '';
  mitZusatz.Enabled         := FileName <> '';

  EingabeOnOff(FileName <> '');

  mitSchliessen.Enabled := (KlasseVorlage <> '') or (FileName <> '');
  mitBerichtzuClipboard.Enabled := (FileName = '') and FBericht;

  LastChange := Now;
  Timer1.Enabled := True;
  QVFertig := False;
end;

procedure TfrmErfassung.SetBericht(const Value: Boolean);
begin
  FBericht := Value;
  mitBerichtzuClipboard.Enabled := (FileName = '') and FBericht;
end;

procedure TfrmErfassung.SetKlasseVorlage(const Value: TFileName);
begin
  FKlasseVorlage := Value;

  tbSaveAs.Enabled := KlasseVorlage <> '';
  mitSpeichernUnter.Enabled := KlasseVorlage <> '';

  mitSchliessen.Enabled := (KlasseVorlage <> '') or (FileName <> '');

  EingabeOnOff(KlasseVorlage <> '');

  QVFertig := False;
end;

procedure TfrmErfassung.DoLoadKlasseVorlage(const KlasseVorlage: TFileName);
begin
  if FileExists(KlasseVorlage) then
  begin
    XMLSchueler.XML.Clear;
    XMLSchueler.LoadFromFile(KlasseVorlage);
    Root := XMLSchueler.DocumentElement;

    PersonalDatenNode := nil;
    ZeugnisInhaltNode := nil;
    ZeugnisInhaltGGLNode := nil;

    LoadDocumnetInfo(Root);

    InXMLToTabSheet := True;
    try
      ZeugnisInhaltNode    := Root.ChildNodes.FindNode('ZeugnisInhalt');
      ZeugnisInhaltGGLNode := Root.ChildNodes.FindNode('ZeugnisInhaltGGL');

      pgZeugnisControl.Visible := False;
      tabZeugnis.TabVisible := Assigned(ZeugnisInhaltNode) and Assigned(ZeugnisInhaltGGLNode);
      tabZeugnisGGL.TabVisible := Assigned(ZeugnisInhaltNode) and Assigned(ZeugnisInhaltGGLNode);
      pgZeugnisControl.ActivePage := tabZeugnis;
      if Assigned(ZeugnisInhaltNode) then
      begin
        if ZeugnisInhaltNode.HasAttribute('Bezeichnung') then
          tabZeugnis.Caption := ZeugnisInhaltNode.Attributes['Bezeichnung'];
        XMLToTabSheet(pgZeugnis, ZeugnisInhaltNode, True);
      end;
      if Assigned(ZeugnisInhaltGGLNode) then
      begin
        if ZeugnisInhaltGGLNode.HasAttribute('Bezeichnung') then
          tabZeugnisGGL.Caption := ZeugnisInhaltGGLNode.Attributes['Bezeichnung'];
        XMLToTabSheet(pgZeugnisGGL, ZeugnisInhaltGGLNode, True);
      end;
    finally
      pgZeugnisControl.Visible := True;
      InXMLToTabSheet := False;
    end;
    edNachname.SetFocus;
  end;
end;

procedure TfrmErfassung.LoadQuickPreview(TempLLVorschauDatei: TFileName);
begin
  LLVorschauDatei := TempLLVorschauDatei;

  if FileExists(LLVorschauDatei) then
  begin
{$IFDEF _LL26_}
    LL26Preview.InputFileName := PChar(LLVorschauDatei);
    while LL26Preview.CurrentPage < QuickPreviewCurrentPage do
      LL26Preview.GotoNext;
{$ENDIF}
    QVFertig := True;
  end;

  QVFertig := True;
  Timer1.Enabled := True;
end;

function TfrmErfassung.PrepearXMLDoc(PrintAktion: TPrintAktion): IXMLDocument;
var
  LLRoot: IXMLNode;
begin
  Result := nil;

  if PrintAktion <> paPrintXML then
  begin
    PersonalDaten2XML;
    Zeugnis2XML;

    Result := NewXMLDocument;
    Result.Encoding := 'UTF-8';
    Result.Options := Result.Options + [doNodeAutoCreate];

    LLRoot := Result.AddChild('LL');
    LLRoot.Attributes['Bericht']   := b2s(frmErfassung.FBericht);
    LLRoot.Attributes['GesprGrdl'] := b2s(frmErfassung.FGesprGrdl);
    if Assigned(frmErfassung.PersonalDatenNode) then
      LLRoot.ChildNodes.Add(frmErfassung.PersonalDatenNode.CloneNode(True));
    if Assigned(frmErfassung.ZeugnisInhaltNode) then
      LLRoot.ChildNodes.Add(frmErfassung.ZeugnisInhaltNode.CloneNode(True));
    if Assigned(frmErfassung.ZeugnisInhaltGGLNode) then
      LLRoot.ChildNodes.Add(frmErfassung.ZeugnisInhaltGGLNode.CloneNode(True));
  end;
end;

procedure TfrmErfassung.LoadDocumnetInfo(aRoot: IXMLNode);
begin
  if Assigned(aRoot) then
  begin
    Bericht                       := aRoot.HasAttribute('Bericht') and s2b(VarToStr(aRoot.Attributes['Bericht']));
    FGesprGrdl                    := aRoot.HasAttribute('GesprGrdl') and s2b(VarToStr(aRoot.Attributes['GesprGrdl']));
    if aRoot.HasAttribute('Foerderschwerpunkt') then
    begin
      FFSP                          := s2b(VarToStr(aRoot.Attributes['Foerderschwerpunkt']));
      lblFoerderschwerpunkt.Visible := s2b(VarToStr(aRoot.Attributes['Foerderschwerpunkt']));
      edFoerderschwerpunkt.Visible  := s2b(VarToStr(aRoot.Attributes['Foerderschwerpunkt']));
      mitTextbaustein.Visible       := s2b(VarToStr(aRoot.Attributes['Foerderschwerpunkt']));
    end else
    begin
      FFSP                          := False;
      lblFoerderschwerpunkt.Visible := False;
      edFoerderschwerpunkt.Visible  := False;
      mitTextbaustein.Visible       := False;
    end;
  end;
end;

function TfrmErfassung.LLVorschauToFront: Boolean;
var
  LLWindow: THandle;
begin
  Result := False;
  LLWindow := FindWindow(PChar('L&LViewer'), PChar('Vorschau'));
  if LLWindow <> 0 then
  begin
    Result := True;
    Self.SendToBack;
    BringWindowToTop(LLWindow);
//    ShowWindow(LLWindow, SW_NORMAL);
    SetActiveWindow(LLWindow);
  end;
end;

procedure TfrmErfassung.EingabeOnOff(const Value: Boolean);
begin
  edNachname.Enabled           := Value;
  edVorname.Enabled            := Value;
  edKlasse.Enabled             := Value;
  cmbKlasse.Enabled            := Value;
  cmbSchuljahr.Enabled         := Value;
  dtKonferenzbeschluss.Enabled := Value;
  dtAusstellungsdatum.Enabled  := Value;
  cmbVersaeumnisse.Enabled     := Value;
  chkQuickPreview.Enabled      := Value;
end;

procedure TfrmErfassung.mitBerichtzuClipboardClick(Sender: TObject);
var
  TextFach, PlatzHalter: IXMLNode;
  Idx, Idy, idz: Integer;
  FachName, FachText, TorteName: string;
  ValueStr, ResultStr: string;
begin
  ResultStr := '';

  frmErfassung.Zeugnis2XML;
  if Assigned(ZeugnisInhaltNode) then
  begin
    for Idx := 0 to ZeugnisInhaltNode.ChildNodes.Count - 1 do
    begin
      if SameText(ZeugnisInhaltNode.ChildNodes[Idx].NodeName, 'Fach') then
      begin
        if ZeugnisInhaltNode.ChildNodes[Idx].HasAttribute('Bezeichnung') then
          FachName := ZeugnisInhaltNode.ChildNodes[Idx].Attributes['Bezeichnung']
        else
         if ZeugnisInhaltNode.ChildNodes[Idx].HasAttribute('Name') then
           FachName := VarToStr(ZeugnisInhaltNode.ChildNodes[Idx].Attributes['Name']);
        ResultStr := ResultStr + FachName + #13#10 + #13#10;
        TextFach := ZeugnisInhaltNode.ChildNodes[Idx].ChildNodes.FindNode('TextFach');
        if Assigned(TextFach) then
        begin
          FachText := VarToStr(TextFach.ChildValues['RTFText']);
          if IsRTF(FachText) then
            FachText := RTF2PlainText(FachText);
          PlatzHalter := TextFach.ChildNodes.FindNode('PLATZHALTER');
          if Assigned(PlatzHalter) then
          begin
            for Idy := 0 to PlatzHalter.ChildNodes.Count - 1 do
            begin
              ValueStr := '{';
              TorteName := VarToStr(PlatzHalter.ChildNodes[Idy].Attributes['NAME']);
              for idz := 0 to PlatzHalter.ChildNodes[Idy].ChildNodes.Count - 1 do
              begin
                ValueStr := VarToStr(ValueStr + VarToStr(PlatzHalter.ChildNodes[Idy].ChildNodes[idz].NodeValue));
                if idz <> PlatzHalter.ChildNodes[Idy].ChildNodes.Count - 1 then
                  ValueStr := ValueStr + ', ';
              end;
              ValueStr := ValueStr + '}';
              FachText := StringReplace(FachText, TorteName, ValueStr, []);
            end;
          end;
          ResultStr := ResultStr + FachText;
        end;
      end;
      if Idx <> ZeugnisInhaltNode.ChildNodes.Count - 1 then
        ResultStr := ResultStr + #13#10 + #13#10;
    end;
    if ResultStr <> '' then
      Clipboard.AsText := ResultStr;
  end;
end;

procedure TfrmErfassung.mitEingabepruefenClick(Sender: TObject);
var
  Ida, Idx, Idy, Idz: Integer;
  FachPage: TFachTabSheet;
  FachScrollBox: TScrollBox;
  TmpPageControl: TPageControl;
begin
  Fehler.Clear;

  for Ida := 0 to 1 do
  begin
    if Ida = 0 then
      TmpPageControl := pgZeugnis
    else
      TmpPageControl := pgZeugnisGGL;

    for Idx := 0 to TmpPageControl.PageCount - 1 do
    begin
      if TmpPageControl.Pages[Idx] is TFachTabSheet then
      begin
        FachPage := TmpPageControl.Pages[Idx] as TFachTabSheet;
        if (FachPage.FFachStatus = fsNone) or (FachPage.FFachStatus = fsAktiv) then
        begin
          for Idy := 0 to FachPage.ComponentCount - 1 do
          begin
            if FachPage.Components[Idy] is TScrollBox then
              CheckFach(FachPage.Components[Idy] as TScrollBox);
            if FachPage.Components[Idy] is TfrmTextFach then
              CheckTextFach(FachPage.Caption, FachPage.Components[Idy] as TfrmTextFach);
          end;
        end;
        if (FachPage.FFachStatus = fsNoAktiv) then
        begin
          for Idy := 0 to FachPage.ComponentCount - 1 do
          begin
            if FachPage.Components[Idy] is TScrollBox then
            begin
              FachScrollBox := TScrollBox(FachPage.Components[Idy]);
              for Idz := 0 to FachScrollBox.ComponentCount - 1 do
                if FachScrollBox.Components[Idz] is TfrmFachPunkt then
                  TfrmFachPunkt(FachScrollBox.Components[Idz]).FachPunktColor := clBtnFace;
            end;
          end;
        end;
      end;
    end;
  end;
  if Fehler.Count > 0 then
  begin
    for Idx := 0 to Fehler.Count - 1 do
    begin
      if Fehler.Objects[Idx] is TfrmFachPunkt then
        (Fehler.Objects[Idx] as TfrmFachPunkt).FachPunktColor := clRed;

//      if Fehler.Objects[Idx] is TfrmTextFach then
//        (Fehler.Objects[Idx] as TfrmTextFach).reTextFach.
    end;
    if Fehler.Objects[0] is TfrmFachPunkt then
      if (Fehler.Objects[0] as TfrmFachPunkt).Owner is TScrollBox then
        if ((Fehler.Objects[0] as TfrmFachPunkt).Owner as TScrollBox).Owner is TFachTabSheet then
        begin
          pgZeugnis.ActivePage := (((Fehler.Objects[0] as TfrmFachPunkt).Owner as TScrollBox).Owner as TFachTabSheet);
          if (((Fehler.Objects[0] as TfrmFachPunkt).Owner as TScrollBox).Owner as TTabSheet).CanFocus then
            (((Fehler.Objects[0] as TfrmFachPunkt).Owner as TScrollBox).Owner as TTabSheet).SetFocus;
        end;

    MessageDlg('Es sind folgende Punkte nicht komplett ausgefüllt:' + #13#10 + #13#10 +
      StringReplace(Fehler.CommaText, ',', #13#10, [rfReplaceAll]), mtWarning, [mbOK], 0)
  end else
    MessageDlg('Es wurden keine Fehler gefunden.', mtInformation, [mbOk], 0);
end;

procedure TfrmErfassung.mitLexiconClick(Sender: TObject);
var
  Lexicon: TfrmLexicon;
begin
  Lexicon := TfrmLexicon.Create(Self);
  with Lexicon do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmErfassung.mitNeuSchuelerClick(Sender: TObject);
var
  FormularDlg: TfrmFormularDlg;
  KV: TKlasseVorlage;
begin
  CheckAenderungen;

  FormularDlg := TfrmFormularDlg.Create(Self);
  with FormularDlg do
  try
    if ShowModal = mrOk then
    begin
      KV := TKlasseVorlage(cmbFormular.Items.Objects[cmbFormular.ItemIndex]);
      InitEingabe(KV.FileName, KV.HalbJahr, KV.Klasse, KV.FSP);
      DoLoadKlasseVorlage(KV.FileName);
    end;
  finally
    Free;
  end;
end;

procedure TfrmErfassung.InitComboBox;
begin
  cmbKlasse.Items.Clear;
  cmbKlasse.Items.Add('a');
  cmbKlasse.Items.Add('b');
  cmbKlasse.Items.Add('c');
  cmbKlasse.Items.Add('d');

  cmbSchuljahr.Items.Clear;
  cmbSchuljahr.Items.Add('2014/2015');
  cmbSchuljahr.Items.Add('2015/2016');
  cmbSchuljahr.Items.Add('2016/2017');
  cmbSchuljahr.Items.Add('2017/2018');
  cmbSchuljahr.Items.Add('2018/2019');
  cmbSchuljahr.Items.Add('2019/2020');
  cmbSchuljahr.Items.Add('2020/2021');
  cmbSchuljahr.Items.Add('2021/2022');
  cmbSchuljahr.Items.Add('2022/2023');
  cmbSchuljahr.Items.Add('2023/2024');
  cmbSchuljahr.Items.Add('2024/2025');

  cmbVersaeumnisse.Items.Clear;
  cmbVersaeumnisse.Items.Add('leer');
  cmbVersaeumnisse.Items.Add('0');
  cmbVersaeumnisse.Items.Add('1');
  cmbVersaeumnisse.Items.Add('2');
  cmbVersaeumnisse.Items.Add('3');
  cmbVersaeumnisse.Items.Add('4');
  cmbVersaeumnisse.Items.Add('5');
  cmbVersaeumnisse.Items.Add('6');
  cmbVersaeumnisse.Items.Add('7');
  cmbVersaeumnisse.Items.Add('8');
  cmbVersaeumnisse.Items.Add('9');
  cmbVersaeumnisse.Items.Add('10');
  cmbVersaeumnisse.Items.Add('11');
  cmbVersaeumnisse.Items.Add('12');
  cmbVersaeumnisse.Items.Add('13');
  cmbVersaeumnisse.Items.Add('14');
  cmbVersaeumnisse.Items.Add('15');
  cmbVersaeumnisse.Items.Add('16');
  cmbVersaeumnisse.Items.Add('17');
  cmbVersaeumnisse.Items.Add('18');
  cmbVersaeumnisse.Items.Add('19');
  cmbVersaeumnisse.Items.Add('20');
  cmbVersaeumnisse.Items.Add('21');
  cmbVersaeumnisse.Items.Add('22');
  cmbVersaeumnisse.Items.Add('23');
  cmbVersaeumnisse.Items.Add('24');
  cmbVersaeumnisse.Items.Add('25');
  cmbVersaeumnisse.Items.Add('26');
  cmbVersaeumnisse.Items.Add('27');
  cmbVersaeumnisse.Items.Add('28');
  cmbVersaeumnisse.Items.Add('29');
  cmbVersaeumnisse.Items.Add('30');
end;

procedure TfrmErfassung.InitEingabe(aKlassVorlage: TFileName; aHalbJahr, aKlasse: Integer; aFSP: Boolean);
var
  Jahr, Monat, Tag: Word;
  Heute: TDate;
begin
  Heute := Now;
  DecodeDate(Heute, Jahr, Monat, Tag);

  FileName := '';
  KlasseVorlage := aKlassVorlage;
  FHalbJahr := aHalbJahr;
  edNachname.Text := '';
  edVorname.Text := '';
  cmbKlasse.ItemIndex := -1;
  if KlasseVorlage <> '' then
  begin
    if (Monat >= 1) and (Monat <= 8) then
      cmbSchuljahr.ItemIndex := cmbSchuljahr.Items.IndexOf(IntToStr(Jahr - 1) + '/' + IntToStr(Jahr))
    else
      cmbSchuljahr.ItemIndex := cmbSchuljahr.Items.IndexOf(IntToStr(Jahr) + '/' + IntToStr(Jahr + 1));
    edKlasse.Text := IntToStr(aKlasse);
    cmbVersaeumnisse.ItemIndex := 0;

    if Trunc(Heute - REG_Einstellungen.ReadDate('EINGABE', 'LastEingabe', Heute)) < 5 * 30 then  // 5 Monate
    begin
      dtKonferenzbeschluss.Date := REG_Einstellungen.ReadDate('EINGABE', 'Konferenz', Heute);
      dtAusstellungsdatum.Date := REG_Einstellungen.ReadDate('EINGABE', 'Ausstellungsdatum', Heute);
      cmbKlasse.ItemIndex := cmbKlasse.Items.IndexOf(REG_Einstellungen.ReadString('EINGABE', 'KlasseBuchstabe', ''));
    end;
  end else
  begin
    cmbSchuljahr.ItemIndex := -1;
    edKlasse.Text := '';
    cmbVersaeumnisse.ItemIndex := -1;

    dtKonferenzbeschluss.Date := Now;
    dtAusstellungsdatum.Date := Now;
    cmbKlasse.ItemIndex := -1;
    pnlReligionPhilosophie.Visible := False;
  end;
  edFoerderschwerpunkt.Text := '';

  StatusBar.Panels[0].Text := 'Klasse: ' + edKlasse.Text + cmbKlasse.Items.Strings[cmbKlasse.ItemIndex];
  StatusBar.Panels[1].Text := '';
  StatusBar.Panels[2].Text := 'Schüler(in):';
  StatusBar.Panels[3].Text := '';
  StatusBar.Panels[4].Style := psText;
  StatusBar.Panels[4].Text := '';
  Self.Caption := GSHoisbuettel + '   ' + StatusBar.Panels.Items[0].Text + ' ' + StatusBar.Panels.Items[2].Text;

  Timer1.Enabled := False;
{$IFDEF _LL26_}
  LL26Preview.InputFileName := '';
{$ENDIF}
  QuickPreviewCurrentPage := 0;

  tabZeugnis.TabVisible := False;
  tabZeugnisGGL.TabVisible := False;

  lblFoerderschwerpunkt.Visible := aFSP;
  edFoerderschwerpunkt.Visible := aFSP;
  mitTextbaustein.Visible := aFSP;

  REG_Einstellungen.WriteDate('EINGABE', 'LastEingabe', Heute);

  Change := False;
end;

procedure TfrmErfassung.mitVorschauClick(Sender: TObject);
begin
  frmErfassung.mitVorschau.Enabled := False;
  frmErfassung.tbVorschau.Enabled := False;

  frmErfassung.mitDrucken.Enabled := False;
  frmErfassung.tbDrucken.Enabled := False;

  LLWorker := TLLWorker.MyCreate(paVorschau, PrepearXMLDoc(paVorschau), Printer.Printers.IndexOf(Schule.GetDefaultPrinter));
  LLWorker.Start;
end;

procedure TfrmErfassung.mitZusatzClick(Sender: TObject);
const
  FSPText = 'Die Leistungen entsprechen dem Stand vom 13. März. ' + #13#10 +
            'Während der Homeschoolingzeit wurde der Unterrichtsstoff fortgesetzt.';
var
  ABemerkung: TfrmBemerkung;
  Schriftgrad: Byte;
begin
  ABemerkung := GetActiveBemerkung;
  Schriftgrad := ABemerkung.Schriftgrad;
  if Assigned(ABemerkung) then
    ABemerkung.PlanText := FSPText;
  ABemerkung.Schriftgrad := Schriftgrad;
end;

procedure TfrmErfassung.OnChangeEreignis(Sender: TObject);
begin
  if not InXMLToTabSheet then
    Change := True;
end;

procedure TfrmErfassung.OnFachPunktChangeFromPunkt(Sender: TfrmFachPunkt;
  PunktNr, Wert: Word);
var
  Idx, Idy: Integer;
begin
  if Assigned(ZeugnisInhaltGGLNode) then
    for Idx := 0 to pgZeugnis.PageCount - 1 do
    begin
      if TFachTabSheet(pgZeugnis.Pages[Idx]).FID = Sender.FachID then
      begin
        for Idy := 0 to TFachTabSheet(pgZeugnis.Pages[Idx]).ControlCount - 1 do
          if TFachTabSheet(pgZeugnis.Pages[Idx]).Controls[Idy] is TfrmTextFach then
          begin
            TfrmTextFach(TFachTabSheet(pgZeugnis.Pages[Idx]).Controls[Idy]).ReplaceFachText(PunktNr, Wert);
            Break;
          end;
      end;
    end;
end;

procedure TfrmErfassung.OnFachPunktChangeFromText(Sender: TfrmTextFach; PunktNr,
  Wert: Word);
var
  Idx, Idy: Integer;
begin
  if Assigned(ZeugnisInhaltGGLNode) then
    for Idx := 0 to pgZeugnisGGL.PageCount - 1 do
    begin
      if TFachTabSheet(pgZeugnisGGL.Pages[Idx]).FID = Sender.FachID then
      begin
        for Idy := 0 to TFachTabSheet(pgZeugnisGGL.Pages[Idx]).FScrollBox.ControlCount - 1 do
          if (TFachTabSheet(pgZeugnisGGL.Pages[Idx]).FScrollBox.Controls[Idy] is TfrmFachPunkt) and
            (TfrmFachPunkt(TFachTabSheet(pgZeugnisGGL.Pages[Idx]).FScrollBox.Controls[Idy]).OrderNr = PunktNr) then
          begin
            TfrmFachPunkt(TFachTabSheet(pgZeugnisGGL.Pages[Idx]).FScrollBox.Controls[Idy]).Wert := Wert;
            Break;
          end;
      end;
    end;
end;

procedure TfrmErfassung.OnABemerkungChange(Sender: TObject);
begin
  OnChangeEreignis(Sender);
  ShowAnzahlZeichen(TRichEdit(Sender));
end;

//procedure TfrmErfassung.PanelBemerkungResize(Sender: TObject);
//var
//  ABemerkung: TRichEdit;
//begin
//  ABemerkung := GetActiveBemerkung;
//  if Assigned(ABemerkung) then
//    ABemerkung.Invalidate;
//end;

procedure TfrmErfassung.pgZeugnisChange(Sender: TObject);
var
  ScrollBox: TScrollBox;
  frmTextFach: TfrmTextFach;
begin
  frmTextFach := GetActiveTextFach;
  if Assigned(frmTextFach) then
  begin
    if frmTextFach.reTextFach.CanFocus then
      frmTextFach.reTextFach.SetFocus;
  end else
  begin
    ScrollBox := GetActiveScrollBox;
    if Assigned(ScrollBox) then
      if ScrollBox.CanFocus then
        ScrollBox.SetFocus;
  end;

  ShowAnzahlZeichenEx;
end;

procedure TfrmErfassung.pgZeugnisDragDrop(Sender, Source: TObject; X,
  Y: Integer);
const
  TCM_GETITEMRECT = $130A;
var
  Idx: Integer;
  Rect: TRect;
begin
  if (Sender is TPageControl) then
  begin
    with pgZeugnis do
    begin
      for Idx := 0 to PageCount - 1 do
      begin
        Perform(TCM_GETITEMRECT, Idx, lParam(@Rect));
        if PtInRect(Rect, Point(X, Y)) then
        begin
          if Idx <> ActivePage.PageIndex then
          begin
            ActivePage.PageIndex := Idx;
            Change := True;
          end;
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TfrmErfassung.pgZeugnisDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
//  if Sender is TPageControl then
//    Accept := True;
end;

procedure TfrmErfassung.pgZeugnisDrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
  function GetIndex: integer;
  var
    Idx: integer;
  begin
    Idx := -1;
    for Result := 0 to TPageControl(Control).PageCount - 1 do
    begin
      if TPageControl(Control).Pages[Result].TabVisible then
        inc(Idx);
      if TabIndex = Idx then
        Break;
    end;
  end;
begin
  with Control.Canvas do
  begin
    if Active then
      Font.Color := clRed
    else
      Font.Color := clWindowText;

    TextOut(Rect.Left + 4, Rect.Top + 4, TPageControl(Control).Pages[GetIndex].Caption);
  end;
end;

procedure TfrmErfassung.pgZeugnisMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//  pgZeugnis.BeginDrag(False);
end;

procedure TfrmErfassung.RecentListClick(SchuelerFile: TFileName);
begin
  CheckAenderungen;
  if FileExists(SchuelerFile) then
    DoLoadSchueler(SchuelerFile)
  else
    ShowMessage('Die Schüler-Datei "' + SchuelerFile + '" kann nicht gefunden werden!');
end;

procedure TfrmErfassung.rgFachClick(Sender: TObject);
var
  Ida, Idx: Integer;
  FachPage: TFachTabSheet;
  BActivePage: Boolean;
  ActivePage: TFachTabSheet;
  TmpPageControl: TPageControl;
begin
  if not InXMLToTabSheet then
  begin
    ActivePage := nil;
    for Ida := 0 to 1 do
    begin
      if Ida = 0 then
        TmpPageControl := pgZeugnis
      else
        TmpPageControl := pgZeugnisGGL;

      BActivePage := False;
      if Assigned(TmpPageControl.ActivePage) then
        BActivePage := SameText(TFachTabSheet(TmpPageControl.ActivePage).FID, 'Religion') or SameText(TFachTabSheet(TmpPageControl.ActivePage).FID, 'Philosophie');
      for Idx := 0 to TmpPageControl.PageCount - 1 do
      begin
        if TmpPageControl.Pages[Idx] is TFachTabSheet then
        begin
          FachPage := TmpPageControl.Pages[Idx] as TFachTabSheet;
          if FachPage.FFachStatus <> fsNone then
          begin
            if SameText(FachPage.FID, 'Religion') then
              FachPage.TabVisible := rbReligion.Checked;
            if SameText(FachPage.FID, 'Philosophie') then
              FachPage.TabVisible := rbPhilosophie.Checked;

            if FachPage.TabVisible then
            begin
              FachPage.FFachStatus := fsAktiv;
              ActivePage := FachPage;
            end else
              FachPage.FFachStatus := fsNoAktiv;
          end;
        end;
      end;
    end;
    if Assigned(ZeugnisInhaltNode) then
    begin
      for Idx := 0 to ZeugnisInhaltNode.ChildNodes.Count - 1 do
      begin
        if SameText(ZeugnisInhaltNode.ChildNodes.Get(idx).Attributes['Name'], 'Religion') then
          ZeugnisInhaltNode.ChildNodes.Get(idx).Attributes['Aktiv'] := b2s(rbReligion.Checked);
        if SameText(ZeugnisInhaltNode.ChildNodes.Get(idx).Attributes['Name'], 'Philosophie') then
          ZeugnisInhaltNode.ChildNodes.Get(idx).Attributes['Aktiv'] := b2s(rbPhilosophie.Checked);
      end;
    end;
    if Assigned(ZeugnisInhaltGGLNode) then
    begin
      for Idx := 0 to ZeugnisInhaltGGLNode.ChildNodes.Count - 1 do
      begin
        if SameText(ZeugnisInhaltGGLNode.ChildNodes.Get(idx).Attributes['Name'], 'Religion') then
          ZeugnisInhaltGGLNode.ChildNodes.Get(idx).Attributes['Aktiv'] := b2s(rbReligion.Checked);
        if SameText(ZeugnisInhaltGGLNode.ChildNodes.Get(idx).Attributes['Name'], 'Philosophie') then
          ZeugnisInhaltGGLNode.ChildNodes.Get(idx).Attributes['Aktiv'] := b2s(rbPhilosophie.Checked);
      end;
    end;

    if BActivePage and Assigned(ActivePage) then
      pgZeugnis.ActivePage := ActivePage;

    Change := True;
  end;
end;

procedure TfrmErfassung.CheckAenderungen;
var
  MessDlgResult: Integer;
begin
  if Change then
  begin
    MessDlgResult := MessageDlg('Möchten Sie die Änderungen speichern?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    case MessDlgResult of
      mrYes:
        mitSpeichernClick(nil);
      mrNo:
        Change := False;
      mrCancel:
        Abort;
    end;
  end;
end;

procedure TfrmErfassung.CheckFach(ScrollBox: TScrollBox);
var
  Idx: Integer;
  FachPunkt: TfrmFachPunkt;
begin
  for Idx := 0 to ScrollBox.ComponentCount - 1 do
  begin
    if ScrollBox.Components[Idx] is TfrmFachPunkt then
    begin
      FachPunkt := ScrollBox.Components[Idx] as TfrmFachPunkt;
      if FachPunkt.Wert = 0 then
        Fehler.AddObject(FachPunkt.FachPunktText, FachPunkt);
    end;
  end;
end;

procedure TfrmErfassung.CheckTextFach(const FachName: string; TextFach: TForm);
var
  frmTextFach: TfrmTextFach;
begin
  if Assigned(TextFach) then
    if TextFach is TfrmTextFach then
    begin
      frmTextFach := TextFach as TfrmTextFach;
      if frmTextFach.reTextFach.FindText('TORTE', 0, Length(frmTextFach.reTextFach.Text), []) >= 0 then
        Fehler.AddObject(FachName, frmTextFach);
    end;
end;

procedure TfrmErfassung.chkQuickPreviewClick(Sender: TObject);
begin
  QVFertig := False;
  Timer1.Enabled := chkQuickPreview.Checked;

  pnlQuickPreview.Visible := chkQuickPreview.Checked;
  Splitter2.Visible := chkQuickPreview.Checked;
end;

procedure TfrmErfassung.DeleteActivTabSheet(aPageControl: TPageControl);
var
  Idx: Integer;
begin
  aPageControl.Visible := False;
  try
    for Idx := aPageControl.PageCount - 1 downto 0 do
    begin
      if aPageControl.Pages[Idx] is TFachTabSheet then
        aPageControl.Pages[Idx].Free;
    end;

    pnlReligionPhilosophie.Visible := False;
  finally
    aPageControl.Visible := True;
  end;
end;

procedure TfrmErfassung.Zeugnis2XML;
var
  Ida, Idx, Idy, Idz: Integer;
  EingabeScrollBox: TScrollBox;
  FachPage: TFachTabSheet;
  TmpPageContorl: TPageControl;
begin
  if Assigned(Root) then
  begin
    for ida := 0 to 1 do
    begin
      if Ida = 0 then
        TmpPageContorl := pgZeugnis
      else
        TmpPageContorl := pgZeugnisGGL;
      for Idx := 0 to TmpPageContorl.PageCount - 1 do
      begin
        if TmpPageContorl.Pages[Idx] is TFachTabSheet then
        begin
          FachPage := TmpPageContorl.Pages[Idx] as TFachTabSheet;
          for Idy := 0 to FachPage.ComponentCount - 1 do
          begin
            if (FachPage.Components[Idy] is TfrmZusatzFach) then
              (FachPage.Components[Idy] as TfrmZusatzFach).SaveZusatzFachNode;

            if (FachPage.Components[Idy] is TScrollBox) and (FachPage.Components[Idy].Tag = 10) then
            begin
              EingabeScrollBox := FachPage.Components[Idy] as TScrollBox;
              for Idz := 0 to EingabeScrollBox.ComponentCount - 1 do
              begin
                if EingabeScrollBox.Components[Idz] is TfrmFachPunkt then
                  (EingabeScrollBox.Components[Idz] as TfrmFachPunkt).SaveFachPunktNode;
              end;
            end;
            if (FachPage.Components[Idy] is TfrmTextFach) then
              (FachPage.Components[Idy] as TfrmTextFach).SaveTextFachNode;

            if (FachPage.Components[Idy] is TfrmBemerkung) then
              (FachPage.Components[Idy] as TfrmBemerkung).SaveBemerkungNode;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmErfassung.Timer1Timer(Sender: TObject);
begin
  if chkQuickPreview.Checked then
    if Now - LastChange > 3 / 24 / 3600 then    // 3 Sekunden
    begin
      if (Change or (FileName <> '') or (KlasseVorlage <> '')) and not QVFertig then
      begin
//        if AnzPW <= 0 then
        begin
          Timer1.Enabled := False;
{$IFDEF _LL26_}
          QuickPreviewCurrentPage := LL26Preview.CurrentPage;
          LL26Preview.InputFileName := '';
{$ENDIF}
          if FileExists(LLVorschauDatei) then
            DeleteFile(LLVorschauDatei);
          DoQuickPreview;
        end;
      end;
    end;
end;

procedure TfrmErfassung.Timer2Timer(Sender: TObject);
begin
  if Assigned(ActiveControl) then
    Label1.Caption := ActiveControl.Name;
end;

//procedure TfrmErfassung.tbUndoClick(Sender: TObject);
//begin
//  if (ActiveControl is TRichEdit) then
//    TRichEdit(ActiveControl).Perform(EM_UNDO, 0, 0);
//end;

function TfrmErfassung.VorlageFile: TFileName;
begin
  Result := IncludeTrailingBackslash(ApplicationPath + 'Reports') + 'zeugnis.lst';
end;

procedure TfrmErfassung.ShowAnzahlZeichen(Sender: TObject);
const
  // Schriftgrad                                   8;   9;  10; 11; 12; 13; 14; 15; 16; 17; 18
  AnzMaxLineFach = 3;
  AnzZeichInLineSchrift: Array[8..18] of Word = (132, 117, 105, 95, 87, 84, 80, 78, 75, 70, 64);
  AnzMaxLineBem12:       Array[8..18] of Word = ( 19,  18,  17, 16, 16, 16, 15, 15, 15, 14, 14);  //40
  AnzMaxLineBem34:       Array[8..18] of Word = ( 21,  20,  19, 18, 18, 18, 17, 17, 17, 16, 16);  //50
  AnzMaxLineVermerk:     Array[8..18] of Word = (  7,   6,   5,  5,  5,  5,  4,  4,  4,  3,  3);  //5;
var
  MaxLine: Integer;
  Idx: Integer;
  aText: TStringList;
  AnzLine: Integer;
begin
  if Sender is TfrmBemerkung then
  begin
    aText := TStringList.Create;
    try
      aText.Text := DeleteTrailingBlanks((Sender as TfrmBemerkung).PlanText);  AnzLine := 0;
      for Idx := 0 to aText.Count - 1 do
      begin
        if Length(aText.Strings[Idx]) < AnzZeichInLineSchrift[(Sender as TfrmBemerkung).Schriftgrad] then
          Inc(AnzLine)
        else
          AnzLine := AnzLine + Length(aText.Strings[Idx]) div AnzZeichInLineSchrift[(Sender as TfrmBemerkung).Schriftgrad] + 1;
      end;

      if (Sender as TfrmBemerkung).NurBemerkung then
      begin
        //Nur Bemerkung
        MaxLine := IfThen(StrToInt(edKlasse.Text) in [1, 2], AnzMaxLineBem12[(Sender as TfrmBemerkung).Schriftgrad], AnzMaxLineBem34[(Sender as TfrmBemerkung).Schriftgrad]);
        if Pos('Vermerke', TTabSheet((Sender as TfrmBemerkung).Owner).Caption) > 0 then
          MaxLine := AnzMaxLineVermerk[(Sender as TfrmBemerkung).Schriftgrad];
      end else
        //Fach Bemerkung
        MaxLine := AnzMaxLineFach;
    finally
      aText.Free;
    end;

    StatusBar.Panels[3].Text := 'Zeichen (mit Leerzeichen): ' + IntToStr(Length((Sender as TfrmBemerkung).PlanText));
    StatusBar.Panels[4].Text := 'Zeile(n)/Papierversion: ' + IntToStr(AnzLine) + ' von ' + IntToStr(MaxLine);
    if AnzLine > MaxLine then
      StatusBar.Panels[4].Style := psOwnerDraw
    else
      StatusBar.Panels[4].Style := psText;
    StatusPanelFarbe := IfThen(AnzLine > MaxLine, 2, 1);
    StatusBar.Repaint;
  end;
end;

procedure TfrmErfassung.ShowAnzahlZeichenEx;
var
  ABemerkung: TfrmBemerkung;
begin
  ABemerkung := GetActiveBemerkung;
  if Assigned(ABemerkung) then
  begin
//    if ABemerkung.reBemerkung.CanFocus then
//      ABemerkung.reBemerkung.SetFocus;
    ShowAnzahlZeichen(ABemerkung);
  end;
end;

procedure TfrmErfassung.Splitter2Moved(Sender: TObject);
begin
  REG_Einstellungen.WriteFloat('EINGABE', 'PnlQuickVorschauWidth Prozent', RoundTo(pnlQuickPreview.Width / pgZeugnis.Width * 100, -2));
end;

procedure TfrmErfassung.SplitterMoved(Sender: TObject);
var
  FachName: string;
begin
  if Sender is TSplitter then
  begin
    if TSplitter(Sender).Owner is TFachTabSheet then
    begin
      FachName := TFachTabSheet(TSplitter(Sender).Owner).FID;
      if not TFachTabSheet(TSplitter(Sender).Owner).FBemerkung.NurBemerkung then
        REG_Einstellungen.WriteFloat(Trim(StringReplace('Faecher\' + FachName, '*', '', [])), 'Height Prozent', RoundTo(TFachTabSheet(TSplitter(Sender).Owner).FBemerkung.Height / pgZeugnis.Height * 100, -2));
    end;
  end;
end;

procedure TfrmErfassung.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
const
  status_color : Array[1..2] of TColor = (clBtnFace, clRed);
begin
  if Panel = StatusBar.Panels[4] then // drittes Panel
  begin
    with StatusBar.Canvas do
    begin
      Brush.Color := status_color[StatusPanelFarbe]; // Farbe aus dem Array
      FillRect(Rect); // Mit der Farbe füllen
      TextOut(Rect.Left, Rect.Top, Panel.Text); // Textausgeben
    end;
  end;
end;

procedure TfrmErfassung.StatusBarResize(Sender: TObject);
begin
  ShowAnzahlZeichenEx;
end;

function TfrmErfassung.XMLNodeStrToDate(Value: IXMLNode): TDateTime;
begin
  Result := Now;
  if Assigned(Value) then
  begin
    Result := StrToIntDef(VarToStr(Value.NodeValue), -1);
    if Result = -1 then
      Result := XMLTimeToDateTime(VarToStr(Value.NodeValue))
  end;
end;

procedure TfrmErfassung.XMLSchuelerAfterOpen(Sender: TObject);
begin
  XMLSchueler.Version := '1.0';
  XMLSchueler.Encoding := 'UTF-8';
end;

procedure TfrmErfassung.XMLToTabSheet(aPageControl: TPageControl; aZeugnisInhaltNode: IXMLNode; AlignBlocksatz: Boolean);
var
  Idx: Integer;
//  FachPage: TFachTabSheet;
  FachGGLNode: IXMLNode;
begin
  InXMLToTabSheet := True; FachGGLNode := nil;
  try
    aPageControl.Visible := False;
    DeleteActivTabSheet(aPageControl);

    for Idx := 0 to aZeugnisInhaltNode.ChildNodes.Count - 1 do
    begin
      if SameText(aZeugnisInhaltNode.ChildNodes[Idx].NodeName, 'FACH') then
      try
        InXMLToFach := True;
        if Assigned(ZeugnisInhaltGGLNode) then
          FachGGLNode := FindAtributeNode(ZeugnisInhaltGGLNode, 'Name', VarToStr(aZeugnisInhaltNode.ChildNodes[Idx].Attributes['Name']));
        CreateFachTabSheet(aPageControl, aZeugnisInhaltNode.ChildNodes[Idx], FachGGLNode, AlignBlocksatz);

//        FachPage := CreateFachTS(ZeugnisInhalt.ChildNodes[Idx], FachGGL, AlignBlocksatz);
//        pgZeugnis.ActivePage := FachPage;
      finally
        InXMLToFach := False;
      end;
    end;
  finally
    pnlReligionPhilosophie.Visible := True;
    if pgZeugnis.PageCount > 1 then
      pgZeugnis.ActivePageIndex := 0;
    pgZeugnisChange(nil);

    InXMLToTabSheet := False;
    aPageControl.Visible := True;
  end;
end;

function TfrmErfassung.IstEingabeOK: Boolean;
begin
  Result := True;
  if SameText(Trim(edNachname.Text), '') then
  begin
    MessageDlg('Der Nachname ist ein Pflichtfeld!', mtError, [mbOK], 0);
    edNachname.SetFocus;
    Result := False;
    Exit;
  end;
  if SameText(Trim(edVorname.Text), '') then
  begin
    MessageDlg('Der Vorname ist ein Pflichtfeld!', mtError, [mbOK], 0);
    edVorname.SetFocus;
    Result := False;
    Exit;
  end;
  if cmbKlasse.ItemIndex < 0 then
  begin
    MessageDlg('Die Klasse ist ein Pflichtfeld!', mtError, [mbOK], 0);
    cmbKlasse.SetFocus;
    Result := False;
    Exit;
  end;
  if edFoerderschwerpunkt.Visible then
  begin
    if Trim(edFoerderschwerpunkt.Text) = '' then
    begin
      MessageDlg('Der Förderschwerpunkt ist ein Pflichtfeld!', mtError, [mbOK], 0);
      if edFoerderschwerpunkt.CanFocus then
        edFoerderschwerpunkt.SetFocus;
      Result := False;
      Exit;
    end;
  end;
end;

procedure TfrmErfassung.DoSaveSchueler(const SchuelerFile: TFileName);
var
  DecriptFileName: TFileName;
begin
  if Assigned(Root) then
  begin
    Root.Attributes['Nachname']           := Trim(edNachname.Text);
    Root.Attributes['Vorname']            := Trim(edVorname.Text);
    Root.Attributes['LastChange']         := DateTimeToXMLTime(Now);
    Root.Attributes['Version']            := SchueleVersion;
    Root.Attributes['Bericht']            := b2s(FBericht);
    Root.Attributes['GesprGrdl']          := b2s(FGesprGrdl);
    Root.Attributes['Foerderschwerpunkt'] := b2s(edFoerderschwerpunkt.Visible);
  end;

  PersonalDaten2XML;

  REG_Einstellungen.WriteString('EINGABE', 'KlasseBuchstabe', cmbKlasse.Items.Strings[cmbKlasse.ItemIndex]);
  REG_Einstellungen.WriteDate('EINGABE', 'Konferenz', Int(dtKonferenzbeschluss.Date));
  REG_Einstellungen.WriteDate('EINGABE', 'Ausstellungsdatum', Int(dtAusstellungsdatum.Date));

  StatusBar.Panels.Items[0].Text := 'Klasse: ' + edKlasse.Text + cmbKlasse.Items.Strings[cmbKlasse.ItemIndex];
  StatusBar.Panels.Items[1].Text := DateTimeToStr(XMLTimeToDateTime(VarToStr(Root.Attributes['LastChange'])));
  StatusBar.Panels.Items[2].Text := 'Schüler(in): ' + Trim(edNachname.Text) + ' ' + Trim(edVorname.Text);
  Self.Caption := GSHoisbuettel + '   ' + StatusBar.Panels.Items[0].Text + ' ' + StatusBar.Panels.Items[2].Text;

  Zeugnis2XML;

  if SameStr(ExtractFileExt(SchuelerFile), '.xschueler') then
  begin
    DecriptFileName := GetTempFile;
    XMLSchueler.SaveToFile(DecriptFileName);
    Codec1.EncryptFile(DecriptFileName, SchuelerFile);
    DeleteFile(DecriptFileName);
  end else
    XMLSchueler.SaveToFile(SchuelerFile);

  Change := False;
  RecentList.CustomItemAdd(SchuelerFile);
end;

procedure TfrmErfassung.DoQuickPreview;
begin
  LLWorker := TLLWorker.MyCreate(paExport, PrepearXMLDoc(paExport), Printer.Printers.IndexOf(Schule.GetDefaultPrinter));
  LLWorker.Start;
end;

procedure TfrmErfassung.scrEingabeOnResize(Sender: TObject);
var
  Idx: Integer;
  FrmTorten: TfrmTorte;
  SB_Visible: Boolean;
  SB_Visible_Alt: Boolean;
begin
  SB_Visible := (GetWindowlong((Sender as TScrollBox).Handle, GWL_STYLE) and WS_VSCROLL) <> 0;

  if not InXMLToFach then
  begin
    for Idx := 0 to (Sender as TScrollBox).Parent.ComponentCount - 1 do
    begin
      if (Sender as TScrollBox).Parent.Components[Idx] is TfrmTorte then
      begin
        FrmTorten := (Sender as TScrollBox).Parent.Components[Idx] as TfrmTorte;
        if FrmTorten.Showing then
        begin
          SB_Visible_Alt := FrmTorten.Torte_020.Left + 2 < FrmTorten.pnlTorten.Width - (FrmTorten.Torte_020.Width div 2) - RightTortenAbstand;

          FrmTorten.Torte_020.Left := FrmTorten.Torte_020.Left + IfThen(SB_Visible, IfThen(not SB_Visible_Alt, GetSystemMetrics(SM_CXVSCROLL) * -1, 0), IfThen(SB_Visible_Alt, GetSystemMetrics(SM_CXVSCROLL), 0));
          FrmTorten.Torte_040.Left := FrmTorten.Torte_040.Left + IfThen(SB_Visible, IfThen(not SB_Visible_Alt, GetSystemMetrics(SM_CXVSCROLL) * -1, 0), IfThen(SB_Visible_Alt, GetSystemMetrics(SM_CXVSCROLL), 0));
          FrmTorten.Torte_060.Left := FrmTorten.Torte_060.Left + IfThen(SB_Visible, IfThen(not SB_Visible_Alt, GetSystemMetrics(SM_CXVSCROLL) * -1, 0), IfThen(SB_Visible_Alt, GetSystemMetrics(SM_CXVSCROLL), 0));
          FrmTorten.Torte_080.Left := FrmTorten.Torte_080.Left + IfThen(SB_Visible, IfThen(not SB_Visible_Alt, GetSystemMetrics(SM_CXVSCROLL) * -1, 0), IfThen(SB_Visible_Alt, GetSystemMetrics(SM_CXVSCROLL), 0));
          FrmTorten.Torte_100.Left := FrmTorten.Torte_100.Left + IfThen(SB_Visible, IfThen(not SB_Visible_Alt, GetSystemMetrics(SM_CXVSCROLL) * -1, 0), IfThen(SB_Visible_Alt, GetSystemMetrics(SM_CXVSCROLL), 0));
        end;

        Break;
      end;
    end;
  end;
end;

procedure TfrmErfassung.mitSchliessenClick(Sender: TObject);
begin
  CheckAenderungen;

  DeleteActivTabSheet(pgZeugnis);
  DeleteActivTabSheet(pgZeugnisGGL);
{$IFDEF _LL26_}
    LL26Preview.InputFileName := PChar('');
    LL26Preview.Refresh;
{$ENDIF}
  InitEingabe('', 0, 0, False);
end;

procedure TfrmErfassung.mitSpeichernClick(Sender: TObject);
begin
  if IstEingabeOK then
  begin
    if FileName <> '' then
      DoSaveSchueler(FileName)
    else
      mitSpeichernUnterClick(nil);
  end else
    Abort;
end;

procedure TfrmErfassung.mitSpeichernUnterClick(Sender: TObject);
var
  LastPath: string;
  TmpFileName: TFileName;
begin
  if IstEingabeOK then
  begin
    LastPath := REG_Einstellungen.ReadString('SAVE', 'Lastpath', HomeVerzeichnis(Self));
    if DirectoryExists(LastPath) then
      SaveSchueler.InitialDir := LastPath
    else
      SaveSchueler.InitialDir := HomeVerzeichnis(Self);
    TmpFileName := 'Klasse ' + edKlasse.Text + cmbKlasse.Items.Strings[cmbKlasse.ItemIndex] + '_' + Trim(edNachname.Text) + ' ' + Trim(edVorname.Text);
    if FBericht then
      TmpFileName := TmpFileName + ' Bericht';
    if FGesprGrdl then
      TmpFileName := TmpFileName + ' GesprGrdl';
    SaveSchueler.FileName := TmpFileName;
    {$IFDEF DEBUG}
    SaveSchueler.FilterIndex := 2;
    {$ELSE}
    SaveSchueler.FilterIndex := 1;
    {$ENDIF}
    if SaveSchueler.Execute then
    begin
      DoSaveSchueler(SaveSchueler.FileName);
      REG_Einstellungen.WriteString('SAVE', 'Lastpath', IncludeTrailingBackslash(ExtractFilePath(SaveSchueler.FileName)));
      FileName := SaveSchueler.FileName;
    end;
  end;
end;

procedure TfrmErfassung.mitStapeldruckClick(Sender: TObject);
var
  StapelDruck: TfrmStapeldruck;
begin
  StapelDruck := TfrmStapeldruck.Create(Self);
  with StapelDruck do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmErfassung.mitTextbausteinClick(Sender: TObject);
const
  FSPText = '* In den gekennzeichneten Fächern wurden dem Zeugnis die Anforderungen der Lehrpläne des ' +
            'besuchten Bildungsganges zu Grunde gelegt. In allen anderen Fächern wurde Unterricht ' +
            'ensprechend dem oben vermerkten Förderschwerpunkt erteilt.';
var
  ABemerkung: TfrmBemerkung;
begin
  ABemerkung := GetActiveBemerkung;
  if Assigned(ABemerkung) then
    ABemerkung.PlanText := FSPText;
end;

function TfrmErfassung.GetActiveBemerkung: TfrmBemerkung;
var
  FachPage: TFachTabSheet;
begin
  Result := nil;
  FachPage := TFachTabSheet(pgZeugnis.ActivePage);
  if Assigned(FachPage) then
    Result := FachPage.FBemerkung;
end;

function TfrmErfassung.GetActiveScrollBox: TScrollBox;
var
  FachPage: TFachTabSheet;
  Idx: Integer;
begin
  Result := nil;
  FachPage := TFachTabSheet(pgZeugnis.ActivePage);
  if Assigned(FachPage) then
  begin
    for Idx := 0 to FachPage.ComponentCount - 1 do
    begin
      if (FachPage.Components[Idx] is TScrollBox) then
      begin
        Result := TScrollBox(FachPage.Components[Idx]);
        Break;
      end;
    end;
  end;
end;

function TfrmErfassung.GetActiveTextFach: TfrmTextFach;
var
  FachPage: TFachTabSheet;
  Idx: Integer;
begin
  Result := nil;
  FachPage := TFachTabSheet(pgZeugnis.ActivePage);
  if Assigned(FachPage) then
  begin
    for Idx := 0 to FachPage.ComponentCount - 1 do
    begin
      if (FachPage.Components[Idx] is TfrmTextFach) then
      begin
        Result := TfrmTextFach(FachPage.Components[Idx]);
        Break;
      end;
    end;
  end;
end;

procedure TfrmErfassung.WMDropFiles(var Msg: TWMDropFiles);
const
  maxlen = 254;
var
  Handle: THandle;
  PChr: array[0..maxlen] of Char;
  FileName: TFileName;
begin
  Handle := Msg.Drop;

  // дана реализация для одного файла, а
  //если предполагается принимать группу файлов, то можно добавить:
  //num:=DragQueryFile(h,Dword(-1),nil,0);
  //for i:=0 to num-1 do begin
  //  DragQueryFile(h,i,pchr,maxlen);
  //...обработка каждого
  //end;

  DragQueryFile(Handle, 0, PChr, maxlen);
  FileName := string(PChr);
  if SameStr(ExtractFileExt(FileName), '.schueler') or SameStr(ExtractFileExt(FileName), '.xschueler') then
  begin
    CheckAenderungen;
    DoLoadSchueler(FileName);
  end;
  DragFinish(Handle);
end;

procedure TfrmErfassung.WMMOUSEWHEEL(var Msg: TMessage);
var
  zDelta: Integer;
  ScrollBox: TScrollBox;
begin
  inherited;

  ScrollBox := GetActiveScrollBox;
  if Assigned(ScrollBox) then
  begin
//    if WindowFromPoint(Mouse.CursorPos) = GetActiveScrollBox.Handle then
    begin
      zDelta := IfThen(Msg.WParam < 10000000, 10, -10);
      with ScrollBox do
      begin
        if ((VertScrollBar.Position = 0) and (zDelta > 0)) or ((VertScrollBar.Position = VertScrollBar.Range - ClientHeight) and (zDelta < 0)) then
          Exit;
        ScrollBy(0, zDelta);
        VertScrollBar.Position := VertScrollBar.Position - zDelta;
      end;
    end;
  end;
end;

{ TEditRedo }

procedure TEditRedo.ExecuteTarget(Target: TObject);
begin
//  inherited;
  SendMessage(GetControl(Target).Handle, EM_REDO, 0, 0);
end;

procedure TEditRedo.UpdateTarget(Target: TObject);
begin
//  inherited;
  Enabled := (SendMessage(GetControl(Target).Handle, EM_CANREDO, 0, 0) <> 0) and not GetControl(Target).ReadOnly;
end;

{ TFachTabSheet }

constructor TFachTabSheet.Create(AOwner: TComponent);
begin
  inherited;

  FBemerkung := nil;
  FScrollBox := nil;
  Seitenumbruch := False;
  Torten := False;
  Kompetenz := False;
  FFachStatus := fsNone;
end;

destructor TFachTabSheet.Destroy;
begin
  if Assigned(FBemerkung) then
    FBemerkung.Free;
  if Assigned(FScrollBox) then
    FScrollBox.Free;

  inherited;
end;

{ TQuickPreviewWorker }

procedure TLLWorker.RepairXML;
var
  Root, PersonalDaten: IXMLNode;
begin
  Root := BXMLDoc.DocumentElement;
  PersonalDaten := Root.ChildNodes.FindNode('PersonalDaten');
  if Assigned(PersonalDaten) then
  begin
    if Assigned(PersonalDaten.ChildNodes.FindNode('Schuljahr')) then
      if Length(PersonalDaten.ChildValues['Schuljahr']) <= 2 then
        PersonalDaten.ChildValues['Schuljahr'] := frmErfassung.cmbSchuljahr.Items.Strings[PersonalDaten.ChildValues['Schuljahr']];
    if Assigned(PersonalDaten.ChildNodes.FindNode('Konferenz')) then
      if StrToIntDef(VarToStr(PersonalDaten.ChildValues['Konferenz']), -1) <> -1 then
        PersonalDaten.ChildValues['Konferenz'] := DateTimeToXMLTime(VarToDateTime(PersonalDaten.ChildValues['Konferenz']));
    if Assigned(PersonalDaten.ChildNodes.FindNode('Ausstellungsdatum')) then
      if StrToIntDef(VarToStr(PersonalDaten.ChildValues['Ausstellungsdatum']), -1) <> -1 then
        PersonalDaten.ChildValues['Ausstellungsdatum'] := DateTimeToXMLTime(VarToDateTime(PersonalDaten.ChildValues['Ausstellungsdatum']));
  end;
end;

//procedure TLLWorker.Daten2XML;
//var
//  Root: IXMLNode;
//begin
//  Root := BXMLDoc.AddChild('LL');
//  Root.Attributes['Bericht'] := b2s(frmErfassung.FBericht);
//  Root.Attributes['GesprGrdl'] := b2s(frmErfassung.FGesprGrdl);
//
//  frmErfassung.PersonalDaten2XML(frmErfassung.Root);
//  frmErfassung.ZeugnisToXML(False);

//  Root.ChildNodes.Add(frmErfassung.PersonalDatenNode.CloneNode(True));
//  Root.ChildNodes.Add(frmErfassung.ZeugnisInhaltNode.CloneNode(True));
//  Root.ChildNodes.Add(frmErfassung.ZeugnisInhaltGGLNode.CloneNode(True));
//end;

procedure TLLWorker.DecThread;
begin
  if FLLObjekts.Count > 0 then
    FLLObjekts.Delete(FLLObjekts.IndexOf(Self));
end;

procedure TLLWorker.DeleteEncriptFileName;
begin
  if FileExists(BEncriptFileName) then
    DeleteFile(BEncriptFileName);
end;

destructor TLLWorker.Destroy;
begin
{$IFDEF _LL26_}
  if Assigned(FLL26) then
    FLL26.Free;
{$ENDIF}

  Synchronize(DecThread);
  inherited Destroy;
end;

{$IFDEF _LL26_}
procedure TLLWorker.BDefineCurrentRecord_LL26(ForDesign: Boolean;
  PersonalDaten: IXMLNode; ATyp, AFarbe, AFachName, AText, ARTFText, AWert,
  AFontStyle, ATorten, ANurBemerkung, AKompetenz, ABericht, AGesprGrdl,
  AFachZusatzText, ASchriftgrad: string);
begin
  if ForDesign then
  begin
    FLL26.LlDefineVariableExt('Nachname', 'Mustermann', LL_TEXT);
    FLL26.LlDefineVariableExt('Vorname', 'Max', LL_TEXT);
    FLL26.LlDefineVariableExt('Klasse', '3', LL_TEXT);
    FLL26.LlDefineVariableExt('KlasseBuchstabe', 'a', LL_TEXT);
    FLL26.LlDefineVariableExt('Schuljahr', '2018/2019', LL_TEXT);
    FLL26.LlDefineVariableExt('Halbjahr', '1', LL_NUMERIC);
    FLL26.LlDefineVariableExt('Konferenz', '10.12.2018', LL_TEXT);
    FLL26.LlDefineVariableExt('Ausstellungsdatum', '10.12.2018', LL_TEXT);
    FLL26.LlDefineVariableExt('Versaeumnisse', '5', LL_TEXT);
    FLL26.LlDefineVariableExt('Logo', ApplicationPath + 'Reports\Logo.png', LL_DRAWING);
    FLL26.LlDefineVariableExt('FSP', 'F', LL_BOOLEAN);
    FLL26.LlDefineVariableExt('Foerderschwerpunkt', 'Foerderschwerpunkt', LL_TEXT);
    FLL26.LlDefineVariableExt('Bericht', 'F', LL_BOOLEAN);
    FLL26.LlDefineVariableExt('GesprGrdl', 'F', LL_BOOLEAN);

    FLL26.LlDefineFieldExt('DruckDatenNr', '1', LL_NUMERIC);
    FLL26.LlDefineFieldExt('Typ', '1', LL_NUMERIC);
    FLL26.LlDefineFieldExt('FachName', 'Deutsch', LL_TEXT);
    FLL26.LlDefineFieldExt('Farbe', '0', LL_NUMERIC);
    FLL26.LlDefineFieldExt('Text', 'Text', LL_TEXT);
    FLL26.LlDefineFieldExt('RTFText', RTFBeispiel, LL_RTF);
    FLL26.LlDefineFieldExt('Wert', '80', LL_NUMERIC);
    FLL26.LlDefineFieldExt('FontStyle', '', LL_TEXT);
    FLL26.LlDefineFieldExt('Torten', 'F', LL_BOOLEAN);
    FLL26.LlDefineFieldExt('NurBemerkung', 'F', LL_BOOLEAN);
    FLL26.LlDefineFieldExt('Kompetenz', 'F', LL_BOOLEAN);
    FLL26.LlDefineFieldExt('FachZusatzText', 'FachZusatzText', LL_TEXT);
    FLL26.LlDefineFieldExt('Schriftgrad', IntToStr(MemoSGDef), LL_NUMERIC);
    FLL26.LlDefineFieldExt('Torte_100', ApplicationPath + 'Reports\Torte_100.png', LL_DRAWING);
    FLL26.LlDefineFieldExt('Torte_80',  ApplicationPath + 'Reports\Torte_80.png', LL_DRAWING);
    FLL26.LlDefineFieldExt('Torte_60',  ApplicationPath + 'Reports\Torte_60.png', LL_DRAWING);
    FLL26.LlDefineFieldExt('Torte_40',  ApplicationPath + 'Reports\Torte_40.png', LL_DRAWING);
    FLL26.LlDefineFieldExt('Torte_20',  ApplicationPath + 'Reports\Torte_20.png', LL_DRAWING);
  end else
  begin
    Inc(BDruckDatenNr);
    FLL26.LlDefineVariableExt('Nachname', VarToStr(PersonalDaten.ChildValues['Nachname']), LL_TEXT);
    FLL26.LlDefineVariableExt('Vorname', VarToStr(PersonalDaten.ChildValues['Vorname']), LL_TEXT);
    FLL26.LlDefineVariableExt('Klasse', VarToStr(PersonalDaten.ChildValues['KlasseZiffer']), LL_TEXT);
    FLL26.LlDefineVariableExt('KlasseBuchstabe', VarToStr(PersonalDaten.ChildValues['KlasseBuchstabe']), LL_TEXT);
    FLL26.LlDefineVariableExt('Schuljahr', VarToStr(PersonalDaten.ChildValues['Schuljahr']), LL_TEXT);
    FLL26.LlDefineVariableExt('Halbjahr', VarToStr(PersonalDaten.ChildValues['Halbjahr']), LL_NUMERIC);
    FLL26.LlDefineVariableExt('Konferenz', DateToStr(XMLTimeToDateTime(VarToStr(PersonalDaten.ChildValues['Konferenz']))), LL_TEXT);
    FLL26.LlDefineVariableExt('Ausstellungsdatum', DateToStr(XMLTimeToDateTime(VarToStr(PersonalDaten.ChildValues['Ausstellungsdatum']))), LL_TEXT);
    if Assigned(PersonalDaten.ChildNodes.FindNode('Versaeumnisse2')) then
      FLL26.LlDefineVariableExt('Versaeumnisse', VarToStr(PersonalDaten.ChildValues['Versaeumnisse2']), LL_TEXT)
    else
      FLL26.LlDefineVariableExt('Versaeumnisse', VarToStr(PersonalDaten.ChildValues['Versaeumnisse']), LL_TEXT);
    FLL26.LlDefineVariableExt('Logo',  ApplicationPath + 'Reports\Logo.png', LL_DRAWING);
    FLL26.LlDefineVariableExt('FSP', b2s(Assigned(PersonalDaten.ChildNodes.FindNode('Foerderschwerpunkt'))), LL_BOOLEAN);
    if Assigned(PersonalDaten.ChildNodes.FindNode('Foerderschwerpunkt')) then
      FLL26.LlDefineVariableExt('Foerderschwerpunkt', VarToStrDef(PersonalDaten.ChildValues['Foerderschwerpunkt'], ''), LL_TEXT)
    else
      FLL26.LlDefineVariableExt('Foerderschwerpunkt', 'Foerderschwerpunkt', LL_TEXT);
    FLL26.LlDefineVariableExt('Bericht', ABericht, LL_BOOLEAN);
    FLL26.LlDefineVariableExt('GesprGrdl', AGesprGrdl, LL_BOOLEAN);

    FLL26.LlDefineFieldExt('DruckDatenNr', IntToStr(BDruckDatenNr), LL_NUMERIC);
    FLL26.LlDefineFieldExt('Typ', ATyp, LL_NUMERIC);
    FLL26.LlDefineFieldExt('FachName', AFachName, LL_TEXT);
    FLL26.LlDefineFieldExt('Farbe', AFarbe, LL_NUMERIC);
    FLL26.LlDefineFieldExt('Text', AText, LL_Text);
    FLL26.LlDefineFieldExt('RTFText', ARTFText, LL_RTF);
    FLL26.LlDefineFieldExt('Wert', AWert, LL_NUMERIC);
    FLL26.LlDefineFieldExt('FontStyle', AFontStyle, LL_TEXT);
    FLL26.LlDefineFieldExt('Torten', ATorten, LL_BOOLEAN);
    FLL26.LlDefineFieldExt('NurBemerkung', ANurBemerkung, LL_BOOLEAN);
    FLL26.LlDefineFieldExt('Kompetenz', AKompetenz, LL_BOOLEAN);
    FLL26.LlDefineFieldExt('FachZusatzText', AFachZusatzText, LL_TEXT);
    FLL26.LlDefineFieldExt('Schriftgrad', ASchriftgrad, LL_NUMERIC);
    FLL26.LlDefineFieldExt('Torte_100', ApplicationPath + 'Reports\Torte_100.png', LL_DRAWING);
    FLL26.LlDefineFieldExt('Torte_80',  ApplicationPath + 'Reports\Torte_80.png', LL_DRAWING);
    FLL26.LlDefineFieldExt('Torte_60',  ApplicationPath + 'Reports\Torte_60.png', LL_DRAWING);
    FLL26.LlDefineFieldExt('Torte_40',  ApplicationPath + 'Reports\Torte_40.png', LL_DRAWING);
    FLL26.LlDefineFieldExt('Torte_20',  ApplicationPath + 'Reports\Torte_20.png', LL_DRAWING);
  end;
end;

procedure TLLWorker.BDoPrint_LL26;
var
  Ret: Integer;
  Idx, Idy: Integer;
  FachAktiv,NurBemerkung: Boolean;
  Bericht, GesprGrdl, FKompetenz, FachBez: string;
  PersonalDaten: IXMLNode;
  ZeugnisInhaltNode, FachNode: IXMLNode;
  TextFachNode, RTFTextNode, BemerkungNode: IXMLNode;
  FachZusatzTextNode: IXMLNode;
  Schriftgrad, PrintJobName: string;
  FachZusatzText: string;

  procedure FLLPrintFields_LL26;
  begin
    {D:  Tabellenzeile ausgeben, auf Rückgabewert prüfen und ggf. Seitenumbruch
         oder Abbruch auslösen}
    Ret := FLL26.LlPrintFields;
    if Ret = LL_ERR_USER_ABORTED then
    begin
       {D:  Benutzerabbruch}
       FLL26.LlPrintEnd(0);
       Exit;
    end else
    while Ret = LL_WRN_REPEAT_DATA do
    begin
       FLL26.LlPrint;
       Ret := FLL26.LlPrintFields;
    end;
  end;
begin
  BDruckDatenNr := 0;

  Assert(Assigned(BRoot), 'Root ist leer');

  Bericht := 'F';
  if BRoot.HasAttribute('Bericht') then
    Bericht := b2s(s2b(VarToStr(BRoot.Attributes['Bericht'])));

  GesprGrdl := 'F';
  if BRoot.HasAttribute('GesprGrdl') then
    GesprGrdl := b2s(s2b(VarToStr(BRoot.Attributes['GesprGrdl'])));

  PersonalDaten := BRoot.ChildNodes.FindNode('PersonalDaten');
  Assert(Assigned(PersonalDaten), 'Personal Daten sind leer');

  {D:  Daten definieren. Die hier übergebenen Daten dienen nur der Syntaxprüfung - die Inhalte
       brauchen keine Echtdaten zu enthalten}
  BDefineCurrentRecord_LL26(False, PersonalDaten, '0', '0', ' ', ' ', ' ', '0', '', 'F', 'F', 'F', Bericht, GesprGrdl, '', '0');

  BSavePapierFormat := GetPapierFormat;
  if BPrintAktion = paVorschau then
  begin
    SetPapierFormat(DMPAPER_A4);
    FLL26.LlPreviewSetTempPath(IncludeTrailingBackslash(GetEnvironmentVariable('temp')));
    FLL26.LlPrintStart(LL_PROJECT_LIST, BVorlageFile, LL_PRINT_PREVIEW);
    FLL26.LlViewerProhibitAction(l26.vbPrintPage);
    FLL26.LlViewerProhibitAction(l26.vbPrintAll);
    FLL26.LlViewerProhibitAction(l26.vbSendTo);
    FLL26.LlViewerProhibitAction(l26.vbSaveAs);
    FLL26.LlViewerProhibitAction(l26.vbFax);
    FLL26.LlViewerProhibitAction(l26.vbPrintPageWithPrinterSelection);
    FLL26.LlViewerProhibitAction(l26.vbPrintAllWithPrinterSelection);
    FLL26.LlViewerProhibitAction(l26.vbPreviousFile);
    FLL26.LlViewerProhibitAction(l26.vbNextFile);
  end else
  if BPrintAktion in [paPrint, paPrintXML] then
  begin
    PrintJobName := VarToStr(PersonalDaten.ChildValues['Nachname']) + '_' + VarToStr(PersonalDaten.ChildValues['Vorname']) + '_' + VarToStr(PersonalDaten.ChildValues['KlasseZiffer']) + VarToStr(PersonalDaten.ChildValues['KlasseBuchstabe']);
    if s2b(Bericht) then
       PrintJobName := PrintJobName + '_Bericht';
    if s2b(GesprGrdl) then
       PrintJobName := PrintJobName + '_GesprGrdl';

    FLL26.LlSetOption(LL_OPTION_RESETPROJECTSTATE_FORCES_NEW_DC, 1);
    FLL26.LlSetOption(LL_OPTION_RESETPROJECTSTATE_FORCES_NEW_PRINTJOB, 1);
    Ret := FLL26.LlPrintWithBoxStart(LL_PROJECT_LIST, BVorlageFile, LL_PRINT_NORMAL, LL_BOXTYPE_BRIDGEMETER, Handle, StringReplace(PrintJobName, '_', ' ', [rfReplaceAll]));

    if BWithDialog then
    begin
      Ret := FLL26.LlPrintOptionsDialog(Handle, 'Druck-Parameter');
      if Ret = LL_ERR_USER_ABORTED then
      begin
        FLL26.LlPrintEnd(0);
        Exit;
      end;
    end;

  {D:  Druckoptionsdialog. Aufruf ist optional, es können sonst Ausgabeziel und
       Exportdateiname über LlXSetParameter() gesetzt werden bzw. der Drucker und
       die Druckoptionen über LlSetPrinterInPrinterFile() vorgegeben werden.}

//    FLL26.LlPrintSetOption(LL_PRNOPT_COPIES, BCopies);
//    if BPrintRange = prPageNums then
//    begin
//      FLL26.LlPrintSetOption(LL_PRNOPT_FIRSTPAGE, BFromPage);
//      FLL26.LlPrintSetOption(LL_PRNOPT_LASTPAGE, BToPage);
//    end;
    FLL26.LlPrintSetOptionString(LL_PRNOPTSTR_PRINTJOBNAME, PrintJobName);
  end else
  if BPrintAktion = paExport then
  begin
    BTempFile := BGetTempLL2XFile;
  //  Ret := FLL26.LlPrintWithBoxStart(LL_PROJECT_LIST, FVorlageFile, LL_PRINT_EXPORT, LL_BOXTYPE_STDABORT, 0, '');
    Ret := FLL26.LlPrintStart(LL_PROJECT_LIST, BVorlageFile, LL_PRINT_EXPORT);

    FLL26.LlXSetParameter(LL_LLX_EXTENSIONTYPE_EXPORT, 'PRV', 'Export.Target', 'PRV');
    FLL26.LlXSetParameter(LL_LLX_EXTENSIONTYPE_EXPORT, 'PRV', 'Export.File', ExtractFileName(BTempFile));
    FLL26.LlXSetParameter(LL_LLX_EXTENSIONTYPE_EXPORT, 'PRV', 'Export.Path', ExtractFilePath(BTempFile));
    FLL26.LlXSetParameter(LL_LLX_EXTENSIONTYPE_EXPORT, 'PRV', 'Export.Quiet', '1');
    FLL26.LlPrintSetOptionString(LL_PRNOPTSTR_EXPORT, 'PRV');
  end;

  {D:  Erste Seite initialisieren; auch hier kann schon durch Objekte vor der Tabelle
       ein Seitenumbruch ausgelöst werden}
  while FLL26.LlPrint = LL_WRN_REPEAT_DATA do;

  // Ersteseite (Deckblatt) ausdrucken
  if not s2b(GesprGrdl) then
  begin
    BDefineCurrentRecord_LL26(False, PersonalDaten, '6', '0', ' ', ' ', ' ', '0', '', 'F', 'F', 'F', Bericht, GesprGrdl, '', '0');
    FLLPrintFields_LL26;
    FLL26.LlPrint;
  end else
  begin
    BDefineCurrentRecord_LL26(False, PersonalDaten, '9', '0', ' ', ' ', ' ', '0', '', 'F', 'F', 'F', Bericht, GesprGrdl, '', '0');
    FLLPrintFields_LL26;
  end;

  {D:  Eigentliche Druckschleife; Wiederholung, solange Daten vorhanden}
  if s2b(GesprGrdl) then
    ZeugnisInhaltNode := BRoot.ChildNodes.FindNode('ZeugnisInhaltGGL');
  if not Assigned(ZeugnisInhaltNode) then
    ZeugnisInhaltNode := BRoot.ChildNodes.FindNode('ZeugnisInhalt');
  if Assigned(ZeugnisInhaltNode) then
  begin
    for Idx := 0 to ZeugnisInhaltNode.ChildNodes.Count - 1 do
    begin
      {D:  Jetzt Echtdaten für aktuellen Datensatz übergeben}
      FachNode := ZeugnisInhaltNode.ChildNodes[Idx];
      if FachNode.HasAttribute('Bezeichnung') then
        FachBez := CheckLexicon(VarToStr(FachNode.Attributes['Bezeichnung']))
      else
        if FachNode.HasAttribute('Name') then
          FachBez := CheckLexicon(VarToStr(FachNode.Attributes['Name']));

      NurBemerkung := (FachNode.ChildNodes.Count <= 2) and not Assigned(FachNode.ChildNodes.FindNode('TextFach'));

      FachAktiv := True;
      if FachNode.HasAttribute('Aktiv') then
        FachAktiv := s2b(VarToStr(FachNode.Attributes['Aktiv']));

      FKompetenz := 'F';
      if FachNode.HasAttribute('Kompetenz') then
        FKompetenz := VarToStr(FachNode.Attributes['Kompetenz']);

      if SameText(FachNode.NodeName, 'FACH') and FachAktiv then
      begin
        FachZusatzText := '';
        if s2b(VarToStrDef(FachNode.Attributes['Seitenumbruch'], 'F')) then
          FLL26.LlPrint;

        TextFachNode := FachNode.ChildNodes.FindNode('TextFach');
        if Assigned(TextFachNode) then
        begin
          RTFTextNode := TextFachNode.ChildNodes.FindNode('RTFText');
          if Assigned(RTFTextNode) then
          begin
            if (BPrintAktion = paPrint) and (GetPapierFormat = DMPAPER_A3) then
            begin
              Schriftgrad := IntToStr(MemoSGDef);
              if RTFTextNode.HasAttribute('Schriftgrad') then
                Schriftgrad := VarToStrDef(RTFTextNode.Attributes['Schriftgrad'], IntToStr(MemoSGDef));
              BDefineCurrentRecord_LL26(False, PersonalDaten, '7', '0', FachBez, RTF2PlainText(VarToStrDef(RTFTextNode.NodeValue, '')),
                 CheckLexicon(SetRTFFontSize(RTFOhneFarbe(VarToStrDef(RTFTextNode.NodeValue, '')), StrToIntDef(Schriftgrad, MemoSGDef))),
                 '0', '', 'F', 'F', FKompetenz, Bericht, GesprGrdl, FachZusatzText, Schriftgrad)
            end else
              BDefineCurrentRecord_LL26(False, PersonalDaten, '7', '0', FachBez, RTF2PlainText(VarToStrDef(RTFTextNode.NodeValue, '')),
                 CheckLexicon(RTFOhneFarbe(VarToStrDef(RTFTextNode.NodeValue, ''))),
                 '0', '', 'F', 'F', FKompetenz, Bericht, GesprGrdl, FachZusatzText, Schriftgrad);
            FLLPrintFields_LL26;
          end;
          BemerkungNode := FachNode.ChildNodes.FindNode('Bemerkung');
          if Assigned(BemerkungNode) then
          begin
            Schriftgrad := VarToStrDef(BemerkungNode.ChildValues['Schriftgrad'], IntToStr(MemoSGDef));
            if (BPrintAktion = paPrint) and (GetPapierFormat = DMPAPER_A3) then
              BDefineCurrentRecord_LL26(False, PersonalDaten, '8', '0', FachBez, RTF2PlainText(VarToStrDef(BemerkungNode.ChildValues['Text'], '')),
                 SetRTFFontSize(TrimRTF(VarToStrDef(BemerkungNode.ChildValues['Text'], '')), StrToIntDef(Schriftgrad, MemoSGDef)),
                 '0', '', 'F', 'F', FKompetenz, Bericht, GesprGrdl, FachZusatzText, Schriftgrad)
            else
              BDefineCurrentRecord_LL26(False, PersonalDaten, '8', '0', FachBez, RTF2PlainText(VarToStrDef(BemerkungNode.ChildValues['Text'], '')),
                 TrimRTF(VarToStrDef(BemerkungNode.ChildValues['Text'], '')),
                 '0', '', 'F', 'F', FKompetenz, Bericht, GesprGrdl, FachZusatzText, Schriftgrad);
            FLLPrintFields_LL26;
          end;
        end else
        begin
          FachZusatzTextNode := FachNode.ChildNodes.FindNode('FachZusatz');
          if Assigned(FachZusatzTextNode) then
            FachZusatzText := Trim(VarToStrDef(FachZusatzTextNode.ChildValues['LabelText1'], '') + ' ' +
                              Trim(VarToStrDef(FachZusatzTextNode.ChildValues['Text'], '')) + ' ' +
                                   VarToStrDef(FachZusatzTextNode.ChildValues['LabelText2'], ''));

          BDefineCurrentRecord_LL26(False, PersonalDaten, '1', '0', FachBez, FachBez, ' ', '0', '', VarToStr(FachNode.Attributes['Torten']), 'F', FKompetenz, Bericht, GesprGrdl, FachZusatzText, '0');
          FLLPrintFields_LL26;

          for Idy := 0 to FachNode.ChildNodes.Count - 1 do
          begin
            if not SameText(FachNode.ChildNodes[Idy].NodeName, 'FACHZUSATZ') then
            begin
              if SameText(FachNode.ChildNodes[Idy].NodeName, 'PUNKT') then
              begin
                if StrToInt(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Wert'], '0')) >= 0 then
                  BDefineCurrentRecord_LL26(False, PersonalDaten, '2', VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Farbe'], '0'), FachBez,
                     CheckLexicon(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Text'], ' ')), ' ',
                     VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Wert'], '0'),
                     VarToStrDef(FachNode.ChildNodes[Idy].ChildNodes.FindNode('Font').Attributes['FontStyle'], ''),
                     'F', 'F', 'F', Bericht, GesprGrdl, '', '0')
                else
                  BDefineCurrentRecord_LL26(False, PersonalDaten, '3', VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Farbe'], '0'), FachBez,
                    CheckLexicon(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Text'], ' ')), ' ',
                    VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Wert'], '0'),
                    VarToStrDef(FachNode.ChildNodes[Idy].ChildNodes.FindNode('Font').Attributes['FontStyle'], ''),
                    'F', 'F', 'F', Bericht, GesprGrdl, '', '0');
                FLLPrintFields_LL26;
              end;
              if SameText(FachNode.ChildNodes[Idy].NodeName, 'BEMERKUNG') then
              begin
                Schriftgrad := VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Schriftgrad'], IntToStr(MemoSGDef));
                if (BPrintAktion = paPrint) and (GetPapierFormat = DMPAPER_A3) then
                  BDefineCurrentRecord_LL26(False, PersonalDaten, '4', '0', FachBez,
      //              StringReplace(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Text'], ' '), '<br>', #13#10, [rfReplaceAll]), '0', '', 'F',
                    RTF2PlainText(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Text'], ' ')),
                    SetRTFFontSize(TrimRTF(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Text'], ' ')), StrToIntDef(Schriftgrad, MemoSGDef)),
                    '0', '', 'F', b2s(NurBemerkung), 'F', Bericht, GesprGrdl, '', Schriftgrad)
                else
                  BDefineCurrentRecord_LL26(False, PersonalDaten, '4', '0', FachBez,
      //              StringReplace(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Text'], ' '), '<br>', #13#10, [rfReplaceAll]), '0', '', 'F',
                    RTF2PlainText(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Text'], ' ')),
                    TrimRTF(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Text'], ' ')),
                    '0', '', 'F', b2s(NurBemerkung), 'F', Bericht, GesprGrdl, '', Schriftgrad);
                FLLPrintFields_LL26;
              end;

              if s2b(VarToStrDef(FachNode.ChildNodes[Idy].ChildValues['Seitenumbruch'], 'F')) then
                FLL26.LlPrint;
            end;
          end;
        end;
      end;

      {D:  Seitenumbruch auslösen, bis Datensatz vollständig gedruckt wurde}
      while Ret = LL_WRN_REPEAT_DATA do
      begin
        FLL26.LlPrint;
        Ret := FLL26.LlPrintFields;
      end;

      {D:  Fortschrittsanzeige aktualisieren}
      FLL26.LlPrintSetBoxText('Drucken ...', Round(Idx/ZeugnisInhaltNode.ChildNodes.Count * 100));
    end;
  end;

  // Schulleiter(in) und Erziehungs Text Drucken
  BDefineCurrentRecord_LL26(False, PersonalDaten, '5', '0', ' ', ' ', ' ', '0', '', 'F', 'F', 'F', Bericht, GesprGrdl, '', '0');
  FLLPrintFields_LL26;

  {D:  Druck der Tabelle beenden, angehängte Objekte drucken}
  while FLL26.LlPrintFieldsEnd = LL_WRN_REPEAT_DATA do;
  if BPrintAktion <> paExport then
    FLL26.LlPrintSetBoxText('Fertig', 100);

  {D:  Druck beenden}
  FLL26.LlPrintEnd(0);

  if (BPrintAktion = paVorschau) and (BSavePapierFormat <> 0) then
    SetPapierFormat(BSavePapierFormat);
end;
{$ENDIF}

procedure TLLWorker.LoadQuickPreview;
begin
  frmErfassung.LoadQuickPreview(TempFile);
end;

procedure TLLWorker.EnableButton;
begin
  if BPrintAktion in [paVorschau, paPrint] then
  begin
    if not frmErfassung.mitVorschau.Enabled then
      frmErfassung.mitVorschau.Enabled := True;
    if not frmErfassung.tbVorschau.Enabled then
      frmErfassung.tbVorschau.Enabled := True;
    if not frmErfassung.mitDrucken.Enabled then
      frmErfassung.mitDrucken.Enabled := True;
    if not frmErfassung.tbDrucken.Enabled then
      frmErfassung.tbDrucken.Enabled := True;
  end;
end;

procedure TLLWorker.Execute;
begin
  if Assigned(BXMLDoc) and not BXMLDoc.IsEmptyDoc then
  begin
  {$IFDEF _LL26_}
    FLL26 := TL26_.Create(nil);

    FLL26.LlSetOptionString(LL_OPTIONSTR_LICENSINGINFO, 'RE2RHQ'); // LL 26
    FLL26.LlSetOptionString(LL_OPTIONSTR_EXPORTS_ALLOWED_IN_PREVIEW, 'PRN');
    FLL26.LlSetOptionString(LL_OPTION_INCREMENTAL_PREVIEW, 'TRUE');
  {$ENDIF}

    if BPrintAktion = paVorschau then
      Restore_ViewerSketchListWidth;
    try
      try
  //      if BPrintAktion in [paVorschau, paPrint, paExport] then
  //        Synchronize(Daten2XML);
        if BPrintAktion = paPrintXML then
          Synchronize(RepairXML);

        BRoot := BXMLDoc.DocumentElement;
        if Assigned(BRoot) then
        begin
          if BRoot.HasAttribute('Bericht') and BRoot.HasAttribute('GesprGrdl') and
              s2b(VarToStr(BRoot.Attributes['Bericht'])) and s2b(VarToStr(BRoot.Attributes['GesprGrdl'])) then
          begin
            BRoot.Attributes['Bericht'] := 'T';
            BRoot.Attributes['GesprGrdl'] := 'F';
            BWithDialog := True;
  {$IFDEF _LL26_}
            Synchronize(BDoPrint_LL26);
  {$ENDIF}

            if BPrintAktion in [paVorschau, paPrint, paPrintXML] then
            begin
              BRoot.Attributes['Bericht'] := 'F';
              BRoot.Attributes['GesprGrdl'] := 'T';
              BWithDialog := False;
  {$IFDEF _LL26_}
              Synchronize(BDoPrint_LL26);
  {$ENDIF}
            end;
          end else
          begin
            BWithDialog := True;
  {$IFDEF _LL26_}
            Synchronize(BDoPrint_LL26);
  {$ENDIF}
          end;
        end;

        if BPrintAktion = paExport then
          Synchronize(LoadQuickPreview);

        if BEncriptFileName <> '' then
          Synchronize(DeleteEncriptFileName);

        Synchronize(EnableButton);
      except
        on E: Exception do
          raise Exception.Create('Fehlermeldung: ' + E.Message);
      end;
    finally
      if BPrintAktion = paVorschau then
        Save_ViewerSketchListWidth;
    end;
  end;
end;

procedure TLLWorker.IncThread;
begin
  FLLObjekts.Add(Self);
end;

function TLLWorker.BGetTempLL2XFile: string;
var
  Buffer: PXChar;
begin
  GetMem(Buffer, (MAX_PATH + 1) * SizeOf(XChar));
  LlGetTempFileName('~', 'll', Buffer, MAX_PATH + 1, 0);
  Result := String(Buffer);
  FreeMem(Buffer);
end;

constructor TLLWorker.MyCreate(PrintAktion: TPrintAktion; Doc: IXMLDocument; const PrinterIndex: Integer);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  Priority := tpLower;

  BPrinterIndex := PrinterIndex;
  BPrintAktion := PrintAktion;
  Synchronize(IncThread);

  if BPrintAktion <> paPrintXML then
  begin
    BXMLDoc := Doc;
//    BXMLDoc := NewXMLDocument;
//    BXMLDoc.Encoding := 'UTF-8';
//    BXMLDoc.Options := BXMLDoc.Options + [doNodeAutoCreate];
  end;
end;

function TLLWorker.BVorlageFile: TFileName;
begin
  Result := IncludeTrailingBackslash(ApplicationPath + 'Reports') + 'zeugnis.lst';
end;

initialization
  FLLObjekts := TList.Create;

finalization
  FLLObjekts.Free;

end.
