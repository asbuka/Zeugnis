unit StapelDruck;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, Xml.xmldom, Soap.XSBuiltIns,
  Xml.XMLIntf, Xml.XMLDoc, System.Actions, Vcl.ActnList, Vcl.StdActns,
  System.ImageList, Vcl.ImgList, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.Menus, Vcl.StdCtrls, Vcl.ComCtrls,
  uTPLb_CryptographicLibrary, uTPLb_BaseNonVisualComponent, uTPLb_Codec,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinOffice2019Colorful, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinTheBezier, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, dxDateRanges, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxCheckBox, dxmdaset, cxLabel, dxSkinBasic, dxSkinOffice2019Black,
  dxSkinOffice2019DarkGray, dxSkinOffice2019White, dxScrollbarAnnotations,
  cxLocalization, cxImageList;

const
  AnzPrintJob = ' - Anzahl der unbearbeitet Druckaufträgen: %d';

type
  TfrmStapeldruck = class(TForm)
    pnlHaupt: TPanel;
    pnlGrid: TPanel;
    pnlButton: TPanel;
    OpenSchueler: TOpenDialog;
    ImageList1: TImageList;
    btnOeffnen: TButton;
    btnDrucken: TButton;
    ProgressBar1: TProgressBar;
    Codec1: TCodec;
    CryptographicLibrary1: TCryptographicLibrary;
    btnDebug: TButton;
    Label1: TLabel;
    btnAbrechen: TButton;
    Timer1: TTimer;
    sgrSchuelerDBTableView1: TcxGridDBTableView;
    sgrSchuelerLevel1: TcxGridLevel;
    sgrSchueler: TcxGrid;
    DataSource1: TDataSource;
    dxMemData1: TdxMemData;
    dxMemData1auswahl: TStringField;
    dxMemData1klasse: TStringField;
    dxMemData1vorname: TStringField;
    dxMemData1nachname: TStringField;
    dxMemData1standard: TStringField;
    dxMemData1bericht: TStringField;
    dxMemData1gsprgrdl: TStringField;
    dxMemData1dateiname: TStringField;
    sgrSchuelerDBTableView1auswahl: TcxGridDBColumn;
    sgrSchuelerDBTableView1klasse: TcxGridDBColumn;
    sgrSchuelerDBTableView1vorname: TcxGridDBColumn;
    sgrSchuelerDBTableView1nachname: TcxGridDBColumn;
    sgrSchuelerDBTableView1standard: TcxGridDBColumn;
    sgrSchuelerDBTableView1bericht: TcxGridDBColumn;
    sgrSchuelerDBTableView1gsprgrdl: TcxGridDBColumn;
    sgrSchuelerDBTableView1dateiname: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxGridTableViewStyleSheet1: TcxGridTableViewStyleSheet;
    cxLocalizer1: TcxLocalizer;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    dxMemData1standard_alt: TStringField;
    dxMemData1bericht_alt: TStringField;
    dxMemData1gsprgrdl_alt: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnOeffnenClick(Sender: TObject);
    procedure btnDruckenClick(Sender: TObject);
    procedure sgrSchuelerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnDebugClick(Sender: TObject);
    procedure btnAbrechenClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sgrSchuelerDBTableView1berichtPropertiesChange(Sender: TObject);
    procedure sgrSchuelerDBTableView1standardPropertiesChange(Sender: TObject);
    procedure sgrSchuelerDBTableView1DataControllerDataChanged(Sender: TObject);
  private
    FAbort: Boolean;
    XMLSchueler: IXMLDocument;
    InLoadSchueler: Boolean;
    function EnableDruck: Boolean;
    procedure LoadSchueler(const SchuelerFile: TFileName; Row: DWORD);
    procedure ButtonOnOff(const Value: Boolean);
    function SetPrinterJob: Cardinal;
    { Private-Deklarationen }
  public
    InProgress: Boolean;
    { Public-Deklarationen }
  end;

var
  frmStapeldruck: TfrmStapeldruck;

implementation

uses
  Schule, WinSpool, Printers, Erfassung, StrUtils;

{$R *.dfm}
{$WARN SYMBOL_PLATFORM OFF}

procedure TfrmStapeldruck.btnAbrechenClick(Sender: TObject);
begin
  FAbort := MessageBox(0, PChar('Sollen alle Druckaufträge abgebrochen werden?'), 'Nachfrage', MB_YESNO or MB_ICONQUESTION) = IDYES;
end;

procedure TfrmStapeldruck.btnDebugClick(Sender: TObject);
var
  JobListe: TStringList;
begin
  JobListe := TStringList.Create;
  Printer.PrinterIndex := Printer.Printers.IndexOf(schule.GetDefaultPrinter);
  if TfrmErfassung(Owner).PrintDialog1.Execute then
  try
//    SetPrinterJob;
//    EnumerateSpoolJobs(Printer.Printers.Strings[Printer.PrinterIndex], JobListe);
//    ShowMessage(JobListe.Text);
  finally
    JobListe.Free;
  end;
end;

procedure TfrmStapeldruck.btnDruckenClick(Sender: TObject);
var
  Idx: Integer;
  AnzDoc: Integer;
//  AnzPrintJobs: Cardinal;
//  JobReady: Boolean;
  Root: IXMLNode;
//  PersonalDaten: IXMLNode;
  EncriptFileName, TempFileName: TFileName;
begin
//  Printer.PrinterIndex := Printer.Printers.IndexOf(Schule.GetDefaultPrinter);
//  if TfrmErfassung(Owner).PrintDialog1.Execute then
  try
//    SetDefaultPrinter1(Printer.Printers.Strings[Printer.PrinterIndex]);

    ButtonOnOff(False);
    AnzDoc := 0;
    ProgressBar1.Max := dxMemData1.RecordCount;
    ProgressBar1.Position := 0;
    dxMemData1.First;
    while not dxMemData1.Eof do
    begin
      if FAbort then
        Break;

//      JobReady := False;

//      AnzPrintJobs := SetPrinterJob;
//      repeat
//        if AnzPrintJobs <= 3 then
//        begin
      if s2b(dxMemData1auswahl.AsString) then
      begin
        TempFileName := dxMemData1dateiname.AsString;
        if ExtractFileExt(dxMemData1dateiname.AsString) = '.xschueler' then
        begin
          EncriptFileName := GetTempFile;
          Codec1.DecryptFile(EncriptFileName, dxMemData1dateiname.AsString);
          TempFileName := EncriptFileName;
        end;
        if FileExists(TempFileName) then
        begin
          XMLSchueler.XML.Clear;
          XMLSchueler.LoadFromFile(TempFileName);

          Root := XMLSchueler.DocumentElement;

//              PersonalDaten := Root.ChildNodes.FindNode('PersonalDaten');
//              if Assigned(PersonalDaten) then
//              begin
//                if Assigned(PersonalDaten.ChildNodes.FindNode('Schuljahr')) then
//                  if Length(PersonalDaten.ChildValues['Schuljahr']) <= 2 then
//                    PersonalDaten.ChildValues['Schuljahr'] := frmErfassung.cmbSchuljahr.Items.Strings[PersonalDaten.ChildValues['Schuljahr']];
//                if Assigned(PersonalDaten.ChildNodes.FindNode('Konferenz')) then
//                  if StrToIntDef(VarToStr(PersonalDaten.ChildValues['Konferenz']), -1) <> -1 then
//                    PersonalDaten.ChildValues['Konferenz'] := DateTimeToXMLTime(VarToDateTime(PersonalDaten.ChildValues['Konferenz']));
//                if Assigned(PersonalDaten.ChildNodes.FindNode('Ausstellungsdatum')) then
//                  if StrToIntDef(VarToStr(PersonalDaten.ChildValues['Ausstellungsdatum']), -1) <> -1 then
//                    PersonalDaten.ChildValues['Ausstellungsdatum'] := DateTimeToXMLTime(VarToDateTime(PersonalDaten.ChildValues['Ausstellungsdatum']));
//              end;

          if Root.HasAttribute('Bericht') and Root.HasAttribute('GesprGrdl') and
              s2b(Root.Attributes['Bericht']) and s2b(Root.Attributes['GesprGrdl']) then
          begin
            Root.Attributes['Bericht'] := b2s(s2b(dxMemData1bericht.AsString));
            Root.Attributes['GesprGrdl'] := b2s(s2b(dxMemData1gsprgrdl.AsString));
          end;

          if s2b(Root.Attributes['Bericht']) and s2b(Root.Attributes['GesprGrdl']) then
          begin
            for Idx := 0 to 1 do
            begin
              Root.Attributes['Bericht'] := b2s(Idx = 0);
              Root.Attributes['GesprGrdl'] := b2s(Idx = 1);
{$IFDEF _LL23_}
              if TfrmErfassung(Owner).DoPrint_LL23(XMLSchueler, paPrint, AnzDoc = 0) = -99 then
{$ENDIF}
{$IFDEF _LL26_}
              if TfrmErfassung(Owner).DoPrint_LL26(XMLSchueler, paPrint, AnzDoc = 0) = -99 then
{$ENDIF}
              begin
                FAbort := True;
                Break;
              end;
              Inc(AnzDoc);
            end;
          end else
          begin
{$IFDEF _LL23_}
            if TfrmErfassung(Owner).DoPrint_LL23(XMLSchueler, paPrint, AnzDoc = 0) = -99 then
{$ENDIF}
{$IFDEF _LL26_}
            if TfrmErfassung(Owner).DoPrint_LL26(XMLSchueler, paPrint, AnzDoc = 0) = -99 then
{$ENDIF}
            begin
              FAbort := True;
              Break;
            end;
            Inc(AnzDoc);
          end;
        end;
        dxMemData1.Edit;
        dxMemData1auswahl.AsString := 'F';
        dxMemData1.Post;
      end;
      ProgressBar1.Position := dxMemData1.RecNo;
//        JobReady := True;

      dxMemData1.Next;
    end;

//        end else
//        begin
//          Delay(1000);
//          AnzPrintJobs := SetPrinterJob;
//        end;
//      until (AnzPrintJobs <= 3) or JobReady or FAbort
  finally
    if not FAbort then
    begin
      dxMemData1.Close;
      dxMemData1.Open;
    end;
    ProgressBar1.Position := 0;
    ButtonOnOff(True);
  end;
end;

procedure TfrmStapeldruck.ButtonOnOff(const Value: Boolean);
begin
  InProgress := not Value;
  btnOeffnen.Enabled := Value;
  btnDrucken.Enabled := Value;
  btnAbrechen.Enabled := not Value;
end;

function TfrmStapeldruck.EnableDruck: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to sgrSchuelerDBTableView1.DataController.FilteredRecordCount - 1 do
  begin
    Result := s2b(sgrSchuelerDBTableView1.DataController.Values[sgrSchuelerDBTableView1.DataController.FilteredRecordIndex[I], sgrSchuelerDBTableView1auswahl.Index]);
    if Result then
      Break;
  end;
end;

procedure TfrmStapeldruck.btnOeffnenClick(Sender: TObject);
var
  Idx: Integer;
begin
  if OpenSchueler.Execute then
  begin
    dxMemData1.Close;
    dxMemData1.Open;
    InLoadSchueler := True;
    try
      for Idx := 0 to OpenSchueler.Files.Count - 1 do
        LoadSchueler(OpenSchueler.Files.Strings[Idx], Idx);
      btnDrucken.Enabled := EnableDruck;
    finally
      InLoadSchueler := False;
    end;
    FAbort := False;
  end;
end;

procedure TfrmStapeldruck.LoadSchueler(const SchuelerFile: TFileName; Row: DWORD);
var
  Root: IXMLNode;
  XMLNode: IXMLNode;
  Idx: Integer;
  Nachname: string;
  Vorname: string;
  KlasseZiffer: string;
  KlasseBuchstabe: string;
  Bericht, GesprGrdl: Boolean;
  EncriptFileName, TempFileName: TFileName;
begin
  TempFileName := SchuelerFile;
  if ExtractFileExt(SchuelerFile) = '.xschueler' then
  begin
    EncriptFileName := GetTempFile;
    Codec1.DecryptFile(EncriptFileName, SchuelerFile);
    TempFileName := EncriptFileName;
  end;
  if FileExists(TempFileName) then
  begin
    XMLSchueler.XML.Clear;
    XMLSchueler.LoadFromFile(TempFileName);
    Root := XMLSchueler.DocumentElement;

    Bericht := False;
    if Root.HasAttribute('Bericht') then
      Bericht := s2b(Root.Attributes['Bericht']);
    GesprGrdl := False;
    if Root.HasAttribute('GesprGrdl') then
      GesprGrdl := s2b(Root.Attributes['GesprGrdl']);
    for Idx := 0 to Root.ChildNodes.Count - 1 do
    begin
      XMLNode := Root.ChildNodes[Idx];
      if SameText(XMLNode.NodeName, 'PERSONALDATEN') then
      begin
        if Assigned(XMLNode.ChildNodes.FindNode('Nachname')) then
          Nachname := VarToStr(XMLNode.ChildValues['Nachname']);
        if Assigned(XMLNode.ChildNodes.FindNode('Vorname')) then
          Vorname := VarToStr(XMLNode.ChildValues['Vorname']);
        if Assigned(XMLNode.ChildNodes.FindNode('KlasseZiffer')) then
          KlasseZiffer := VarToStr(XMLNode.ChildValues['KlasseZiffer']);
        if Assigned(XMLNode.ChildNodes.FindNode('KlasseBuchstabe')) then
          KlasseBuchstabe := VarToStr(XMLNode.ChildValues['KlasseBuchstabe']);

        dxMemData1.Append;
        dxMemData1auswahl.AsString      := 'T';
        dxMemData1klasse.AsString       := KlasseZiffer + KlasseBuchstabe;
        dxMemData1vorname.AsString      := Vorname;
        dxMemData1nachname.AsString     := Nachname;
        dxMemData1standard.AsString     := IfThen(not Bericht and not GesprGrdl, 'T', 'F');
        dxMemData1standard_alt.AsString := dxMemData1standard.AsString;
        dxMemData1bericht.AsString      := IfThen(Bericht, 'T', 'F');
        dxMemData1bericht_alt.AsString  := dxMemData1bericht.AsString;
        dxMemData1gsprgrdl.AsString     := IfThen(GesprGrdl, 'T', 'F');
        dxMemData1gsprgrdl_alt.AsString := dxMemData1gsprgrdl.AsString;
        dxMemData1dateiname.AsString    := SchuelerFile;
        dxMemData1.Post;
      end;
    end;

    if FileExists(EncriptFileName) then
      DeleteFile(EncriptFileName);
  end;
end;

procedure TfrmStapeldruck.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := not InProgress;
end;

procedure TfrmStapeldruck.FormCreate(Sender: TObject);
begin
  sgrSchueler.Font.Assign(GS_Hoisbuettel_FontLabel);
  Constraints.MaxWidth := Constraints.MinWidth;
  pnlHaupt.Align := alClient;

  cxLocalizer1.Active := False;
  if not FileExists(cxLocalizer1.FileName) then
  begin
    if FileExists(IncludeTrailingBackslash(ApplicationPath) + 'devex_language_german.ini') then
    begin
      cxLocalizer1.FileName := IncludeTrailingBackslash(ApplicationPath) + 'devex_language_german.ini';
      cxLocalizer1.Active := True;
      cxLocalizer1.Locale := 1031;
    end
  end else
  begin
    cxLocalizer1.Active := True;
    cxLocalizer1.Locale := 1031;
  end;

  XMLSchueler := NewXMLDocument;
  XMLSchueler.Encoding := 'UTF-8';

  Self.Top := REG_Einstellungen.ReadInteger('STAPELDRUCK', 'Top', 150);
  Self.Left := REG_Einstellungen.ReadInteger('STAPELDRUCK', 'Left', 250);
  Self.Width := REG_Einstellungen.ReadInteger('STAPELDRUCK', 'Width', 350);
  Self.Height := REG_Einstellungen.ReadInteger('STAPELDRUCK', 'Height', 500);

  FAbort := False;
  Codec1.Password := GSHoisbuettel;
  Label1.Caption := '';
//  Timer1.Enabled := True;

{$IFDEF DEBUG}
  btnDebug.Visible := True;
{$ELSE}
  btnDebug.Visible := False;
{$ENDIF}
end;

procedure TfrmStapeldruck.FormDestroy(Sender: TObject);
begin
  REG_Einstellungen.WriteInteger('STAPELDRUCK', 'Top', Self.Top);
  REG_Einstellungen.WriteInteger('STAPELDRUCK', 'Left', Self.Left);
  REG_Einstellungen.WriteInteger('STAPELDRUCK', 'Width', Self.Width);
  REG_Einstellungen.WriteInteger('STAPELDRUCK', 'Height', Self.Height);
end;

procedure TfrmStapeldruck.sgrSchuelerDBTableView1berichtPropertiesChange(
  Sender: TObject);
begin
  if not InLoadSchueler and TcxCheckBox(sender).Checked then
    if not s2b(dxMemData1bericht_alt.AsString) then
    begin
       TcxCheckBox(sender).Checked := False;
       Abort;
    end;
end;

procedure TfrmStapeldruck.sgrSchuelerDBTableView1DataControllerDataChanged(
  Sender: TObject);
begin
  if not InLoadSchueler then
    btnDrucken.Enabled := EnableDruck;
end;

procedure TfrmStapeldruck.sgrSchuelerDBTableView1standardPropertiesChange(
  Sender: TObject);
begin
  if not InLoadSchueler and TcxCheckBox(sender).Checked then
    if not s2b(dxMemData1standard_alt.AsString) then
    begin
       TcxCheckBox(sender).Checked := False;
       Abort;
    end;
end;

procedure TfrmStapeldruck.sgrSchuelerKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //
end;

procedure TfrmStapeldruck.Timer1Timer(Sender: TObject);
begin
  Label1.Caption := Caption + Format(AnzPrintJob, [SetPrinterJob]);
end;

function TfrmStapeldruck.SetPrinterJob: Cardinal;
type
  TJobs = array[0..20] of TJobInfo2;
  PJobs = ^TJobs;
var
  Needed, JobCounter : DWORD;
  i : Integer;
  Device, Driver, Port : array[0..255] of Char;
  hPrinter, hDeviceMode : THandle;
  Buffer : Pointer;
  Job : PJobs;
const
  NoJobs = 100;
begin
  Result := 0;
  Printer.PrinterIndex := -1;
  Printer.GetPrinter(Device, Driver, Port, hDeviceMode);
  if WinSpool.OpenPrinter(@Device, hPrinter, nil) then
  begin
    EnumJobs(hPrinter, 0, NoJobs, 2, nil, 0, Needed, JobCounter);
    GetMem(Buffer, Needed);
    try
      Job := Buffer;
      if EnumJobs(hPrinter, 0, NoJobs, 2, Buffer, Needed, Needed, JobCounter) then
        begin
          Result := JobCounter;
          Label1.Caption := Caption + Format(AnzPrintJob, [Result]);
          Application.ProcessMessages;
          if FAbort then
          begin
//            if MessageBox(0, PChar('Soll der Druckauftrag des Dokuments "' + Job[i].pDocument + '" mit ' + inttostr( Job[i].TotalPages)+ ' zu druckenden Seiten abgebrochen werden?')
            for i := JobCounter - 1 downto 0 do
            begin
              if Job[i].pDocument <> nil then
                SetJob(hPrinter, Job[i].JobId, 0, nil, JOB_CONTROL_DELETE);//JOB_CONTROL_PAUSE
            end;
            Label1.Caption := Caption + Format(AnzPrintJob, [0]);
          end;
        end;
    finally
      FreeMem(Buffer, Needed);
    end;
    WinSpool.ClosePrinter(hPrinter);
  end;
end;

end.



