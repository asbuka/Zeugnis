unit Lexicon;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmLexicon = class(TForm)
    pnlHaupt: TPanel;
    pnlTexten: TPanel;
    pnlButton: TPanel;
    Splitter1: TSplitter;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    pnlBad: TPanel;
    pnlGood: TPanel;
    memBad: TMemo;
    memGood: TMemo;
    pnlBadText: TPanel;
    pnlGoodText: TPanel;
    procedure pnlTextenResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    FLexicon: TStringList;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmLexicon: TfrmLexicon;

implementation

{$R *.dfm}

uses
  Schule, System.Math, System.UITypes;

procedure TfrmLexicon.BitBtn1Click(Sender: TObject);
var
  Idx: Integer;
begin
  if memBad.Lines.Count <> memGood.Lines.Count then
  begin
    MessageDlg('Anzahl "Fehlerhafter Texte" und "Korrigierte Texte" ist unterschidlisch!', mtError, [mbOK], 0);
    Abort;
  end;

  INI_Einstellungen.EraseSection('LEXICON');
  for Idx := 0 to memBad.Lines.Count - 1 do
    if Trim(memBad.Lines.Strings[Idx]) <> '' then
      INI_Einstellungen.WriteString('LEXICON', Trim(memBad.Lines.Strings[Idx]), Trim(memGood.Lines.Strings[Idx]));
  Close;
end;

procedure TfrmLexicon.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmLexicon.FormCreate(Sender: TObject);
var
  Idx: Integer;
  AWidth, AHeight: Integer;
begin
  FLexicon := TStringList.Create;
  if INI_Einstellungen.SectionExists('LEXICON') then
    INI_Einstellungen.ReadSectionValues('LEXICON', FLexicon);

  Top     := REG_Einstellungen.ReadInteger('FORM.LEXICON', 'Top', 50);
  Left    := REG_Einstellungen.ReadInteger('FORM.LEXICON', 'Left', 50);
  AWidth  := REG_Einstellungen.ReadInteger('FORM.LEXICON', 'Width', IfThen(Screen.WorkAreaWidth > 400, 400, Screen.WorkAreaWidth - 10));
  AHeight := REG_Einstellungen.ReadInteger('FORM.LEXICON', 'Height', IfThen(Screen.WorkAreaHeight > 350, 350, Screen.WorkAreaHeight - 10));

  Width := IfThen(Screen.WorkAreaWidth < AWidth, Screen.WorkAreaWidth - 10, AWidth);
  Height := IfThen(Screen.WorkAreaHeight < AHeight, Screen.WorkAreaHeight - 10, AHeight);

  memBad.Clear;
  memGood.Clear;
  for Idx := 0 to FLexicon.Count - 1 do
  begin
    memBad.Lines.Add(FLexicon.Names[Idx]);
    memGood.Lines.Add(FLexicon.ValueFromIndex[Idx]);
  end;
end;

procedure TfrmLexicon.FormDestroy(Sender: TObject);
begin
  FLexicon.Free;

  REG_Einstellungen.WriteInteger('FORM.LEXICON', 'Top', Self.Top);
  REG_Einstellungen.WriteInteger('FORM.LEXICON', 'Left', Self.Left);
  REG_Einstellungen.WriteInteger('FORM.LEXICON', 'Width', Self.Width);
  REG_Einstellungen.WriteInteger('FORM.LEXICON', 'Height', Self.Height);
end;

procedure TfrmLexicon.pnlTextenResize(Sender: TObject);
begin
  pnlBad.Width := pnlTexten.Width div 2;
end;

end.
