unit PrinterSetup;

interface

uses
  printers,
  windows,
  SysUtils,
  Classes,
  WinSpool;

type
  TPrinterSetup = class

  private
    Device, Driver, Port: array [0 .. CCHDEVICENAME] of char;
    DeviceMode: THandle;
    procedure Refresh;
  protected
  public
    procedure SaveSetup(FileName: TFilename);
    procedure LoadSetup(FileName: TFilename);
  end;

  TPrinterConfig = record
    ADevice, ADriver, APort: array [0 .. CCHDEVICENAME] of char;
    SizeOfDeviceMode: DWORD;
  end;

implementation

procedure TPrinterSetup.Refresh;
begin
  Printer.GetPrinter(Device, Driver, Port, DeviceMode);
end;

procedure TPrinterSetup.SaveSetup(FileName: TFilename);
var
  StubDevMode: TDeviceMode;
  SetupPrinter: TPrinterConfig;
  FPrinterHandle: THandle;
  fFileConfig: file of TPrinterConfig;
  fFileDevMode: file of char;
  pDevMode: PChar;
  Contador: Integer;
begin
  Refresh;
  with SetupPrinter do
  begin
    StrLCopy(ADevice, Device, SizeOf(ADevice));
    StrLCopy(ADriver, Driver, SizeOf(ADriver));
    StrLCopy(APort, Port, SizeOf(APort));
    OpenPrinter(Device, FPrinterHandle, nil);
    SizeOfDeviceMode := DocumentProperties(0, FPrinterHandle, Device,
      StubDevMode, StubDevMode, 0);
  end;
  AssignFile(fFileConfig, FileName);
  ReWrite(fFileConfig);
  Write(fFileConfig, SetupPrinter);
  CloseFile(fFileConfig);
  AssignFile(fFileDevMode, FileName);
  Reset(fFileDevMode);
  Seek(fFileDevMode, FileSize(fFileDevMode));
  pDevMode := GlobalLock(DeviceMode);
  for Contador := 0 to SetupPrinter.SizeOfDeviceMode - 1 do
  begin
    Write(fFileDevMode, pDevMode[Contador]);
  end;
  CloseFile(fFileDevMode);
  GlobalUnLock(DeviceMode);
end;

procedure TPrinterSetup.LoadSetup(FileName: TFilename);
var
  SetupPrinter: TPrinterConfig;
  fFileConfig: file of TPrinterConfig;
  fFileDevMode: file of char;
  ADeviceMode: THandle;
  pDevMode: PChar;
  Contador: Integer;
begin
  if FileExists(FileName) then
  begin
    AssignFile(fFileConfig, FileName);
    Reset(fFileConfig);
    read(fFileConfig, SetupPrinter);
    CloseFile(fFileConfig);
    AssignFile(fFileDevMode, FileName);
    Reset(fFileDevMode);
    Seek(fFileDevMode, SizeOf(SetupPrinter));
    ADeviceMode := GlobalAlloc(GHND, SetupPrinter.SizeOfDeviceMode);
    pDevMode := GlobalLock(ADeviceMode);
    for Contador := 0 to SetupPrinter.SizeOfDeviceMode - 1 do
    begin
      read(fFileDevMode, char(pDevMode[Contador]));
    end;
    CloseFile(fFileDevMode);
    GlobalUnLock(ADeviceMode);
    Printer.SetPrinter(SetupPrinter.ADevice, SetupPrinter.ADriver,
      SetupPrinter.APort, ADeviceMode);
  end;
end;

end.
