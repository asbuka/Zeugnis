unit DruckenDlg;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Winapi.ShellAPI,
  Winapi.WinSpool, Printers;

type
  TPaperName = array[0..63] of Char;
  TPaperInfo = packed record
    PaperName: TPaperName;
    PaperID: Word;
    PaperSize: TPoint;
  end;
  TPaperInfos = array of TPaperInfo;
  TPaperSizes = array of TPoint;

  TfrmDruckenDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    grbPrinter: TGroupBox;
    lblPrinterName: TLabel;
    cmbPrinter: TComboBox;
    btnEigenschaften: TButton;
    lblStatus: TLabel;
    lblTyp: TLabel;
    lblStatusValue: TLabel;
    lblTypValue: TLabel;
    grbPapier: TGroupBox;
    lblGrosse: TLabel;
    cmbPapier: TComboBox;
    lblQuelle: TLabel;
    cmbQuelle: TComboBox;
    lblDuplex: TLabel;
    cmbDuplex: TComboBox;
    procedure btnEigenschaftenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbPrinterChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmbDuplexChange(Sender: TObject);
  private
//    Device, Driver, Port: array[0..255] of Char;
//    hDevMode: THandle;
    procedure InitDrucker;
    function GerDruckerName: string;
    procedure GetBinNames(aBinName: TStrings; aDruckIndex: Integer);
    procedure SetDuplex(aDuplexMode: SmallInt; aDruckIndex: Integer);

    function GetPaperID(aDruckIndex: Integer): SmallInt;
    procedure GetPaperNames(aPaperName: TStrings; aDruckIndex: Integer);
    procedure GetPaperSizes(var aPaperSizes: TPaperSizes; aDruckIndex: Integer);
    procedure GetPaperInfo(var aPaperInfos: TPaperInfos; aDruckerIndex: Integer);
    function PrinterSupportsDuplex(aDruckIndex: Integer): Boolean;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    property DruckerName: string read GerDruckerName;
//    property Paper
//    property
    class function Execute(Owner: TComponent): Boolean;
  end;

var
  frmDruckenDlg: TfrmDruckenDlg;

implementation

uses
  Schule;

{$R *.dfm}

procedure TfrmDruckenDlg.btnEigenschaftenClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'rundll32.exe', PChar('printui.dll,PrintUIEntry /e /n "'+cmbPrinter.Items[cmbPrinter.ItemIndex]+'" '), nil, SW_HIDE);
end;

procedure TfrmDruckenDlg.cmbDuplexChange(Sender: TObject);
begin
  case cmbDuplex.ItemIndex of
    0: SetDuplex(DMDUP_SIMPLEX, Printer.PrinterIndex);
    1: SetDuplex(DMDUP_VERTICAL, Printer.PrinterIndex);
    2: SetDuplex(DMDUP_HORIZONTAL, Printer.PrinterIndex);
  end;
end;

procedure TfrmDruckenDlg.cmbPrinterChange(Sender: TObject);
var
//  pDev: pDevMode;
  PaperID, Idx: Integer;
  PapersInfos: TPaperInfos;
begin
  Printer.PrinterIndex := Printer.Printers.IndexOf(cmbPrinter.Items[cmbPrinter.ItemIndex]);
//  Printer.GetPrinter(Device, Driver, Port, hDevmode);
//  GetPrinterDevMode(Printer.Printers.Strings[Printer.PrinterIndex], pDev);
  PaperID := GetPaperID(Printer.PrinterIndex);
  GetPaperInfo(PapersInfos, Printer.PrinterIndex);
  for Idx := Low(PapersInfos) to High(PapersInfos) do
  begin
    if PaperID = PapersInfos[Idx].PaperID then
    begin
      cmbPapier.ItemIndex := cmbPapier.Items.IndexOf(PapersInfos[Idx].PaperName);
      Break;
    end;
  end;
  GetBinnames(cmbQuelle.Items, Printer.PrinterIndex);
  cmbQuelle.ItemIndex := 0;

  cmbDuplex.Enabled := PrinterSupportsDuplex(Printer.PrinterIndex);
end;

class function TfrmDruckenDlg.Execute(Owner: TComponent): Boolean;
var
  frmDrDlg: TfrmDruckenDlg;
begin
  frmDrDlg := TfrmDruckenDlg.Create(Owner);
  try
    Result := frmDrDlg.ShowModal = mrOk;
  finally
    frmDrDlg.Free;
  end;
end;

procedure TfrmDruckenDlg.FormCreate(Sender: TObject);
begin
  lblStatusValue.Caption := '';
  lblTypValue.Caption := '';

  cmbDuplex.ItemIndex := 0;

  InitDrucker;
end;

procedure TfrmDruckenDlg.FormDestroy(Sender: TObject);
begin
  //
end;

function TfrmDruckenDlg.GerDruckerName: string;
begin
  Result := Printer.Printers.Strings[Printer.PrinterIndex];
end;

procedure TfrmDruckenDlg.InitDrucker;
var
  Idx: Integer;
begin
  cmbPrinter.Clear;
  for Idx := 0 to Printer.Printers.Count - 1 do
  begin
    cmbPrinter.Items.Add(Printer.Printers.Strings[Idx]);
  end;
  cmbPrinter.ItemIndex := 0;
  cmbPrinterChange(nil);
end;

procedure TfrmDruckenDlg.GetBinnames(aBinName: TStrings; aDruckIndex: Integer);
type
  TBinName = array[0..23] of Char;
  TBinNameArray = array[1..High(Integer) div Sizeof(TBinName)] of TBinName;
  PBinNameArray = ^TBinNameArray;
  TBinArray = array[1..High(Integer) div Sizeof(Word)] of Word;
  PBinArray = ^TBinArray;

var
  Device, Driver, Port: array[0..255] of Char;
  hDeviceMode: THandle;
  numBinNames, numBins, Idx, Temp: Integer;
  pBinNames: PBinNameArray;
  pBins: PBinArray;
begin
  with Printer do
  begin
    PrinterIndex := aDruckIndex;
    GetPrinter(Device, Driver, Port, hDeviceMode);
    numBinNames := Winapi.WinSpool.DeviceCapabilities(Device, Port, DC_BINNAMES, nil, nil);
    numBins := Winapi.WinSpool.DeviceCapabilities(Device, Port, DC_BINS, nil, nil);
    if numBins <> numBinNames then
      raise Exception.Create('DeviceCapabilities reports different number of bins and ' + 'bin names!');

    if numBinNames > 0 then
    begin
      GetMem(pBinNames, numBinNames * Sizeof(TBinname));
      GetMem(pBins, numBins * Sizeof(Word));
      try
        Winapi.WinSpool.DeviceCapabilities(Device, Port, DC_BINNAMES, PChar(pBinNames), nil);
        Winapi.WinSpool.DeviceCapabilities(Device, Port, DC_BINS, PChar(pBins), nil);
        aBinName.Clear;
        for Idx := 1 to numBinNames do
        begin
          Temp := pBins^[Idx];
          aBinName.AddObject(pBinNames^[Idx], TObject(Temp));
        end;
      finally
        FreeMem(pBinNames);
        if pBins <> nil then
          FreeMem(pBins);
      end;
    end;
  end;
end;

function TfrmDruckenDlg.PrinterSupportsDuplex(aDruckIndex: Integer): Boolean;
var
  Device, Driver, Port: array[0..255] of Char;
  hDeviceMode: THandle;
begin
  with Printer do
  begin
    PrinterIndex := aDruckIndex;
    GetPrinter(Device, Driver, Port, hDeviceMode);
    Result := Winapi.WinSpool.DeviceCapabilities(Device, Port, DC_DUPLEX, nil, nil) <> 0;
  end;
end;

procedure TfrmDruckenDlg.SetDuplex(aDuplexMode: SmallInt; aDruckIndex: Integer);
var
  Device, Driver, Port: array[0..255] of Char;
  hDeviceMode: THandle;
  pDevMode: PDeviceMode;
begin
  with Printer do
  begin
    PrinterIndex := aDruckIndex;
    Printer.GetPrinter(Device, Driver, Port, hDeviceMode);
    if hDeviceMode <> 0 then begin
       // lock it to get pointer to DEVMODE record
      pDevMode := GlobalLock(hDeviceMode);
      if pDevMode <> nil then
      try
        with pDevMode^ do begin
          dmDuplex := aDuplexMode;
          dmFields := dmFields or DM_DUPLEX;
        end;
      finally
        // unlock devmode handle.
        GlobalUnlock(hDeviceMode);
      end;
    end;
  end;
end;

procedure TfrmDruckenDlg.GetPaperNames(aPaperName: TStrings; aDruckIndex: Integer);
type
  TPaperNameArray = array[1..High(Integer) div Sizeof(TPaperName)] of TPaperName;
  PPapernameArray = ^TPaperNameArray;
  TPaperArray = array[1..High(Integer) div Sizeof(Word)] of Word;
  PPaperArray = ^TPaperArray;
var
  Device, Driver, Port: array[0..255] of Char;
  hDeviceMode: THandle;
  Idx, numPaperNames, numPapers, temp: Integer;
  pPaperNames: PPapernameArray;
  pPapers: PPaperArray;
begin
  Assert(Assigned(aPaperName));
  Printer.PrinterIndex := aDruckIndex;
  Printer.GetPrinter(Device, Driver, Port, hDeviceMode);
  numPaperNames := Winapi.WinSpool.DeviceCapabilities(Device, Port, DC_PAPERNAMES, nil, nil);
  numPapers := Winapi.WinSpool.DeviceCapabilities(Device, Port, DC_PAPERS, nil, nil);
  if numPapers <> numPaperNames then
    raise Exception.Create('DeviceCapabilities reports different number of papers and paper-names');

  if numPaperNames > 0 then
  begin
    GetMem(pPaperNames, numPaperNames * Sizeof(TPapername));
    GetMem(pPapers, numPapers * Sizeof(Word));
    try
      Winapi.WinSpool.DeviceCapabilities(Device, Port, DC_PAPERNAMES, Pchar(pPaperNames), nil);
      Winapi.WinSpool.DeviceCapabilities(Device, Port, DC_PAPERS, Pchar(pPapers), nil);
      aPaperName.Clear;
      for Idx := 1 to numPaperNames do
      begin
        temp := pPapers^[Idx];
        aPaperName.AddObject(pPaperNames^[Idx], TObject(temp));
      end;
    finally
      FreeMem(pPaperNames);
      if pPapers <> nil then
        FreeMem(pPapers);
    end;
  end;
end;

procedure TfrmDruckenDlg.GetPaperSizes(var aPaperSizes: TPaperSizes;
  aDruckIndex: Integer);
var
  Device, Driver, Port: array[0..255] of Char;
  hDeviceMode: THandle;
  numPapers: Integer;
begin
  with Printer do
  begin
    PrinterIndex := aDruckIndex;
    GetPrinter(Device, Driver, Port, hDeviceMode);
    numPapers := Winapi.WinSpool.DeviceCapabilities(Device, Port, DC_PAPERS, nil, nil);
    SetLength(aPaperSizes, numPapers);
    if numPapers > 0 then
      Winapi.WinSpool.DeviceCapabilities(Device, Port, DC_PAPERSIZE, PChar(@aPaperSizes[0]), nil);
  end;
end;

function TfrmDruckenDlg.GetPaperID(aDruckIndex: Integer): SmallInt;
var
  Device, Driver, Port: array[0..255] of Char;
  hDeviceMode: THandle;
  pDevMode: PDeviceMode;
begin
  Result := 0;
  with Printer do
  begin
    PrinterIndex := aDruckIndex;
    GetPrinter(Device, Driver, Port, hDeviceMode);
    pDevMode := GlobalLock(hDeviceMode);
    if pDevMode <> nil then
    try
      with pDevMode^ do
      begin
        dmFields := dmFields or DM_PAPERSIZE;
        Result := dmPaperSize;
      end;
    finally
      GlobalUnlock(hDevicemode);
    end;
  end;
end;

procedure TfrmDruckenDlg.GetPaperInfo(var aPaperInfos: TPaperInfos; aDruckerIndex: Integer);
var
  PaperSizes: TPaperSizes;
  i: Integer;
begin
  GetPaperNames(cmbPapier.Items, aDruckerIndex);
  GetPaperSizes(PaperSizes, aDruckerIndex);
  Assert(cmbPapier.Items.Count = Length(PaperSizes));
  SetLength(aPaperInfos, cmbPapier.Items.Count);
  for i := 0 to cmbPapier.Items.Count - 1 do
  begin
    StrPLCopy(aPaperInfos[i].PaperName, cmbPapier.Items[i], Sizeof(TPapername) - 1);
    aPaperInfos[i].PaperID := LoWord(Longword(cmbPapier.Items.Objects[i]));
    aPaperInfos[i].PaperSize := PaperSizes[i];
  end;
end;

end.



