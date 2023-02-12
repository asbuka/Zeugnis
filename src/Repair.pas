unit Repair;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTPLb_CryptographicLibrary, uTPLb_BaseNonVisualComponent, uTPLb_Codec,
  Xml.XMLIntf, Xml.XMLDoc, Vcl.StdCtrls, System.IOUtils;

type
  TfrmRepair = class(TForm)
    OpenSchueler: TOpenDialog;
    Codec1: TCodec;
    CryptographicLibrary1: TCryptographicLibrary;
    mitOeffnen: TButton;
    mitRepair: TButton;
    chkBackup: TCheckBox;
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure mitOeffnenClick(Sender: TObject);
    procedure mitRepairClick(Sender: TObject);
  private
    { Private-Deklarationen }
    FileName: TFileName;
    procedure DoLoadSchueler(const SchuelerFile: TFileName);
    procedure Repair(const SchuelerFile: TFileName);
  public
    { Public-Deklarationen }
  end;

var
  frmRepair: TfrmRepair;

implementation

uses
  Schule;

{$R *.dfm}
{$WARN SYMBOL_PLATFORM OFF}

procedure TfrmRepair.DoLoadSchueler(const SchuelerFile: TFileName);
var
  XMLSchueler: IXMLDocument;
  Root: IXMLNode;
  Version: Integer;
  GesprGrdl: Boolean;
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
    FileName := SchuelerFile;

    XMLSchueler := NewXMLDocument;
    XMLSchueler.LoadFromFile(TempFileName);
    Root := XMLSchueler.DocumentElement;
    Version := 1;
    if Root.HasAttribute('Version') then
       Version := Root.Attributes['Version'];
    if Version > SchueleVersion then
    begin
      MessageDlg('Die Schülerdatei ist nicht lesbar. Sie wurde von einer neueren Version der Software erzeugt!'+#13#10+
                 'Bitte führen Sie ein Update durch!', mtError, [mbOK], 0);
      FileName := '';
      Abort;
    end;

    if FileExists(EncriptFileName) then
      DeleteFile(EncriptFileName);

    GesprGrdl := s2b(VarToStr(Root.Attributes['GesprGrdl']));
    if GesprGrdl then
      ListBox1.Items.Add(FileName);

//    for Idx := 0 to Root.ChildNodes.Count - 1 do
//    begin
//      XMLNode := Root.ChildNodes[Idx];
//      if UpperCase(XMLNode.NodeName) = 'PERSONALDATEN' then
//      begin
//        if Assigned(XMLNode.ChildNodes.FindNode('Nachname')) then
//          edNachname.Text := XMLNode.ChildValues['Nachname'];
//        if Assigned(XMLNode.ChildNodes.FindNode('Vorname')) then
//          edVorname.Text := XMLNode.ChildValues['Vorname'];
//        if Assigned(XMLNode.ChildNodes.FindNode('KlasseZiffer')) then
//          edKlasse.Text := XMLNode.ChildValues['KlasseZiffer'];
//        if Assigned(XMLNode.ChildNodes.FindNode('KlasseBuchstabe')) then
//          cmbKlasse.ItemIndex := cmbKlasse.Items.IndexOf(XMLNode.ChildValues['KlasseBuchstabe']);
//        if Assigned(XMLNode.ChildNodes.FindNode('Schuljahr')) then
//          if Length(XMLNode.ChildValues['Schuljahr']) > 2 then
//            cmbSchuljahr.ItemIndex := cmbSchuljahr.Items.IndexOf(XMLNode.ChildValues['Schuljahr'])
//          else
//            cmbSchuljahr.ItemIndex := XMLNode.ChildValues['Schuljahr'];
//        if Assigned(XMLNode.ChildNodes.FindNode('Halbjahr')) then
//          FHalbJahr := XMLNode.ChildValues['Halbjahr'];
//      end;
//      Application.ProcessMessages;
//    end;
  end;
end;

procedure TfrmRepair.FormCreate(Sender: TObject);
begin
  Codec1.Password := GSHoisbuettel;

  ListBox1.Clear;

  mitRepair.Enabled := ListBox1.Items.Count > 0;
end;

procedure TfrmRepair.mitOeffnenClick(Sender: TObject);
var
  LastPath: string;
  Idx: Integer;
begin
  LastPath := REG_Einstellungen.ReadString('OPEN', 'Lastpath', HomeVerzeichnis(Self));
  if DirectoryExists(LastPath) then
    OpenSchueler.InitialDir := LastPath
  else
    OpenSchueler.InitialDir := HomeVerzeichnis(Self);
  OpenSchueler.FileName := '';
  if OpenSchueler.Execute then
  begin
    ListBox1.Items.Clear;
    for Idx := 0 to OpenSchueler.Files.Count - 1 do
      DoLoadSchueler(OpenSchueler.Files.Strings[Idx]);
    mitRepair.Enabled := ListBox1.Items.Count > 0;
  end;
end;

procedure TfrmRepair.mitRepairClick(Sender: TObject);
var
  Idx: Integer;
begin
  for Idx := ListBox1.Items.Count - 1 downto 0 do
    Repair(ListBox1.Items.Strings[Idx]);
end;

procedure TfrmRepair.Repair(const SchuelerFile: TFileName);
var
  Idx: Integer;
  XMLSchueler: IXMLDocument;
  Change: Boolean;
  Root, ZeugnisInhalt: IXMLNode;
  EncriptFileName, DecriptFileName, TempFileName: TFileName;
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
    Change := False;
    XMLSchueler := NewXMLDocument;
    XMLSchueler.LoadFromFile(TempFileName);
    Root := XMLSchueler.DocumentElement;
    ZeugnisInhalt := Root.ChildNodes.FindNode('ZeugnisInhalt');
    if Assigned(ZeugnisInhalt) then
    begin
      for Idx := 0 to ZeugnisInhalt.ChildNodes.Count - 1 do
      begin
        if SameText(ZeugnisInhalt.ChildNodes[Idx].Attributes['Name'], 'Deutsch') and s2b(ZeugnisInhalt.ChildNodes[Idx].Attributes['Torten']) then
        begin
          ZeugnisInhalt.ChildNodes[Idx].Attributes['Torten'] := 'F';
          Change := True;
        end;
        if SameText(ZeugnisInhalt.ChildNodes[Idx].Attributes['Name'], 'Sachunterricht') and not s2b(ZeugnisInhalt.ChildNodes[Idx].Attributes['Torten']) then
        begin
          ZeugnisInhalt.ChildNodes[Idx].Attributes['Torten'] := 'T';
          Change := True;
        end;
        if SameText(ZeugnisInhalt.ChildNodes[Idx].Attributes['Name'], 'Religion') and s2b(ZeugnisInhalt.ChildNodes[Idx].Attributes['Torten']) then
        begin
          ZeugnisInhalt.ChildNodes[Idx].Attributes['Torten'] := 'F';
          Change := True;
        end;
        if SameText(ZeugnisInhalt.ChildNodes[Idx].Attributes['Name'], 'Philosophie') and s2b(ZeugnisInhalt.ChildNodes[Idx].Attributes['Torten']) then
        begin
          ZeugnisInhalt.ChildNodes[Idx].Attributes['Torten'] := 'F';
          Change := True;
        end;
      end;
    end;
    if Change then
    begin
      if chkBackup.Checked then
        if ForceDirectories(SchuelerFile + '\Backup') then
          TFile.Copy(SchuelerFile, ExtractFilePath(SchuelerFile) + '\Backup\' + ExtractFileName(SchuelerFile), False);
      if ExtractFileExt(SchuelerFile) = '.xschueler' then
      begin
        DecriptFileName := GetTempFile;
        XMLSchueler.SaveToFile(DecriptFileName);
        Codec1.EncryptFile(DecriptFileName, SchuelerFile);
        DeleteFile(DecriptFileName);
      end else
        XMLSchueler.SaveToFile(SchuelerFile);
      ListBox1.Items.Delete(ListBox1.Items.IndexOf(SchuelerFile));
    end else
      ShowMessage('Die Date "' + FileName + '" ist in Ordnung!');
  end;

  mitRepair.Enabled := ListBox1.Items.Count > 0;
end;

end.
