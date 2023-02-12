unit WinVersion;

interface

uses
  Windows;

const
  VER_SUITE_PERSONAL  = $00000200;
  VER_NT_WORKSTATION  = $00000001;
  VER_SUITE_WH_SERVER = $00008000;
  SM_SERVERR2         = 89;

type
  //http://msdn2.microsoft.com/en-us/library/ms724833.aspx
  TOSVersionInfoEx = packed record
    dwOSVersionInfoSize : DWORD;
    dwMajorVersion      : DWORD;
    dwMinorVersion      : DWORD;
    dwBuildNumber       : DWORD;
    dwPlatformId        : DWORD;
    szCSDVersion        : array[0..127] of Char;
    wServicePackMajor   : WORD;
    wServicePackMinor   : WORD;
    wSuiteMask          : WORD;
    wProductType        : BYTE;
    wReserved           : BYTE;
  end;

function GetOSVersionInfoEx : TOSVersionInfoEx;

implementation

function GetOSVersionEx(var lpVersionInformation: TOSVersionInfoEx): BOOL; stdcall; external kernel32 name 'GetVersionExA';

function GetOSVersionInfoEx : TOSVersionInfoEx;
var
  OSVersionInfo   : TOSVersionInfo absolute Result;
  Done : Boolean;
begin
  FillChar(Result, SizeOf(Result), #0);
  Done := False;
  try
    Result.dwOSVersionInfoSize := SizeOf(TOSVersionInfoEx);
    Done := GetOSVersionEx(Result);
  except
  end;
  if not(Done) then
  begin
    try
      FillChar(Result, SizeOf(Result), #0);
      Result.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
      Done := GetVersionEx(OSVersionInfo);
    except
    end;
  end;
end;

end.
