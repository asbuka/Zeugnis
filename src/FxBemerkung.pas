unit FxBemerkung;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtActns, Vcl.StdActns, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan, Vcl.ToolWin, Vcl.ActnCtrls, Vcl.ActnMenus, Vcl.ImgList, Vcl.Menus,
  Vcl.ActnPopup, System.Actions, System.ImageList, Xml.XMLIntf,
  Schule, RichEditEx;

type
  TfrmBemerkung = class(TForm)
    pnlBemerungLabel: TPanel;
    pnlBemerkungText: TPanel;
    reBemerkung: TRichEditEx;
    lblBemerkung: TLabel;
    cmbSchriftgrad: TComboBox;
    lblSchriftgrad: TLabel;
    PopupActionBar: TPopupActionBar;
    mitCut: TMenuItem;
    mitCopy: TMenuItem;
    mitPaste: TMenuItem;
    mitSelectAll: TMenuItem;
    mitUndo: TMenuItem;
    N2: TMenuItem;
    mitRedo: TMenuItem;
    mitAlignLeft: TMenuItem;
    mitAlignCenter: TMenuItem;
    mitAlignRight: TMenuItem;
    mitAlignBlock: TMenuItem;
    Ruler: TPanel;
    FirstInd: TLabel;
    LeftInd: TLabel;
    RulerLine: TBevel;
    RightInd: TLabel;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure cmbSchriftgradChange(Sender: TObject);
    procedure reBemerkungChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pnlBemerkungTextResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure reBemerkungAfterPaste(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RulerResize(Sender: TObject);
    procedure RulerItemMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RulerItemMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FirstIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LeftIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RightIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SelectionChange(Sender: TObject);
  private
    { Private-Deklarationen }
    FBemerkungNode: IXMLNode;
    FBemerkungGGLNode: IXMLNode;
    FNurBemerkung: Boolean;
    FOnBemerkungChange: TNotifyEvent;
    FModus: TZeugnistModus;
    FFachID: string;
    FPageControlName: string;
    FUpdating: Boolean;
    FDragOfs: Integer;
    FDragging: Boolean;
    procedure SetNurBemerkung(const Value: Boolean);
    procedure SetRTFText(const Value: string);
    function GetRTFText: string;
    function GetSchriftgrad: Byte;
    procedure SetSchriftgrad(const Value: Byte);
    function GetPlanText: TCaption;
    procedure SetPlanText(const Value: TCaption);
    procedure SetSchriftgradVisible(const Value: Boolean);
    function CurrText: TTextAttributes;
    procedure SetupRuler;
    procedure UpdateCursorPos;
  public
    { Public-Deklarationen }
    procedure SaveBemerkungNode;
    property FachID: string read FFachID write FFachID;
    property Modus: TZeugnistModus read FModus write FModus;
    property RTFText: string read GetRTFText write SetRTFText;
    property PlanText: TCaption read GetPlanText write SetPlanText;
    property OnBemerkungChange: TNotifyEvent read FOnBemerkungChange write FOnBemerkungChange;
    property NurBemerkung: Boolean read FNurBemerkung write SetNurBemerkung;
    property Schriftgrad: Byte read GetSchriftgrad write SetSchriftgrad;
    property SchriftgradVisible: Boolean write SetSchriftgradVisible;
    property PageControlName: string read FPageControlName write FPageControlName;
    procedure InitFromXML(aXMLNode, aXMLGGLNode: IXMLNode; AlignBlocksatz: Boolean);
  end;

//var
//  frmBemerkung: TfrmBemerkung;

implementation

uses
  Math, RichEdit;

const
  RulerAdj = 4/3;
  GutterWid = 6;

{$R *.dfm}

procedure TfrmBemerkung.cmbSchriftgradChange(Sender: TObject);
//var
//  PosCursor: Integer;
begin
//  PosCursor := reBemerkung.SelStart;
//  reBemerkung.SelectAll;
//  reBemerkung.SelAttributes.Size := StrToInt(cmbSchriftgrad.Items.Strings[cmbSchriftgrad.ItemIndex]);
//  reBemerkung.SelStart := PosCursor;

  if not FUpdating then
  begin
    CurrText.Size := StrToInt(cmbSchriftgrad.Items.Strings[cmbSchriftgrad.ItemIndex]);

    if Assigned(FOnBemerkungChange) then
      OnBemerkungChange(Self);
  end;
end;

procedure TfrmBemerkung.RightIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  reBemerkung.Paragraph.RightIndent := Trunc((Ruler.ClientWidth-RightInd.Left+FDragOfs-2) / RulerAdj)-2*GutterWid;
  SelectionChange(Sender);
end;

procedure TfrmBemerkung.RulerItemMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragOfs := (TLabel(Sender).Width div 2);
  TLabel(Sender).Left := TLabel(Sender).Left+X-FDragOfs;
  FDragging := True;
end;

procedure TfrmBemerkung.RulerItemMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if FDragging then
    TLabel(Sender).Left :=  TLabel(Sender).Left+X-FDragOfs
end;

function TfrmBemerkung.CurrText: TTextAttributes;
begin
  if reBemerkung.SelLength > 0 then
    Result := reBemerkung.SelAttributes
  else
    Result := reBemerkung.DefAttributes;
end;

procedure TfrmBemerkung.FirstIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  reBemerkung.Paragraph.FirstIndent := Trunc((FirstInd.Left+FDragOfs-GutterWid) / RulerAdj);
  LeftIndMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TfrmBemerkung.FormCreate(Sender: TObject);
begin
  Parent := Owner as TWinControl;
  BorderStyle := bsNone;
  ParentBackground := False;

  reBemerkung.Font.Assign(GS_Hoisbuettel_FontEdit);

  cmbSchriftgrad.Items.Clear;
  cmbSchriftgrad.Items.Add('8');
  cmbSchriftgrad.Items.Add('9');
  cmbSchriftgrad.Items.Add('10');
  cmbSchriftgrad.Items.Add('11');
  cmbSchriftgrad.Items.Add('12');
  cmbSchriftgrad.Items.Add('14');
  cmbSchriftgrad.Items.Add('16');
  cmbSchriftgrad.Items.Add('18');

  cmbSchriftgrad.ItemIndex := 0;

  SendMessage(reBemerkung.Handle, EM_SETTEXTMODE, TM_MULTILEVELUNDO, 0);
  SendMessage(reBemerkung.Handle, EM_SETUNDOLIMIT, 15, 0);

  LeftInd.Visible := False;
  RightInd.Visible := False;
  SetupRuler;
  SelectionChange(Self);

  FModus := fpNormal;
end;

procedure TfrmBemerkung.FormDestroy(Sender: TObject);
begin
  if not FNurBemerkung then
    REG_Einstellungen.WriteInteger(PageControlName + '\Faecher\' + FachID, 'Height', Height);
end;

procedure TfrmBemerkung.FormResize(Sender: TObject);
begin
  reBemerkung.Invalidate;
end;

procedure TfrmBemerkung.FormShow(Sender: TObject);
begin
  Top := 1300;
end;

function TfrmBemerkung.GetSchriftgrad: Byte;
begin
  Result := StrToIntDef(cmbSchriftgrad.Items.Strings[cmbSchriftgrad.ItemIndex], MemoSGDef);
end;

procedure TfrmBemerkung.InitFromXML(aXMLNode, aXMLGGLNode: IXMLNode; AlignBlocksatz: Boolean);
begin
  FBemerkungNode := aXMLNode;
  FBemerkungGGLNode := aXMLGGLNode;

  if Assigned(FBemerkungNode) and FBemerkungNode.HasChildNodes then
  begin
    if not VarIsNull(FBemerkungNode.ChildValues['Text']) then
    begin
      if IsRTF(FBemerkungNode.ChildValues['Text']) then
        SetRTFText(VarToStr(FBemerkungNode.ChildValues['Text']))
      else
        SetPlanText(StringReplace(VarToStr(FBemerkungNode.ChildValues['Text']), '<br>', #13#10, [rfReplaceAll, rfIgnorecase]))
    end;

    if AlignBlocksatz then
      RichEditAlignBlocksatz(reBemerkung);

    if Assigned(FBemerkungNode.ChildNodes.FindNode('Schriftgrad')) then
      if not VarIsNull(FBemerkungNode.ChildValues['Schriftgrad']) then
        SetSchriftgrad(StrToIntDef(VarToStr(FBemerkungNode.ChildValues['Schriftgrad']), MemoSGDef));
  end;
end;

procedure TfrmBemerkung.LeftIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  reBemerkung.Paragraph.LeftIndent := Trunc((LeftInd.Left+FDragOfs-GutterWid) / RulerAdj)-reBemerkung.Paragraph.FirstIndent;
  SelectionChange(Sender);
end;

function TfrmBemerkung.GetPlanText: TCaption;
begin
  try
    reBemerkung.PlainText := True;
    Result := reBemerkung.Text;
  finally
    reBemerkung.PlainText := False;
  end;
end;

function TfrmBemerkung.GetRTFText: string;
var
  StrSteam: TStringStream;
begin
  StrSteam := TStringStream.Create('');
  try
    reBemerkung.PlainText := False;
    reBemerkung.Lines.SaveToStream(StrSteam);
    Result := StrSteam.DataString;
  finally
    StrSteam.Free;
  end;
end;

procedure TfrmBemerkung.pnlBemerkungTextResize(Sender: TObject);
begin
  reBemerkung.Invalidate;
end;

procedure TfrmBemerkung.reBemerkungAfterPaste(Sender: TObject);
begin
  reBemerkung.SelectAll;
  CurrText.Name := GS_Hoisbuettel_FontEdit.Name;
  CurrText.Size := StrToInt(cmbSchriftgrad.Items.Strings[cmbSchriftgrad.ItemIndex]);

//  reBemerkung.Invalidate;
end;

procedure TfrmBemerkung.reBemerkungChange(Sender: TObject);
begin
  if Assigned(FOnBemerkungChange) then
    OnBemerkungChange(Self);
end;

procedure TfrmBemerkung.SelectionChange(Sender: TObject);
begin
  with reBemerkung.Paragraph do
  try
    FUpdating := True;
    FirstInd.Left := Trunc(FirstIndent*RulerAdj)-4+GutterWid;
    LeftInd.Left := Trunc((LeftIndent+FirstIndent)*RulerAdj)-4+GutterWid;
    RightInd.Left := Ruler.ClientWidth-6-Trunc((RightIndent+GutterWid)*RulerAdj);
//    BoldButton.Down := fsBold in Editor.SelAttributes.Style;
//    ItalicButton.Down := fsItalic in Editor.SelAttributes.Style;
//    UnderlineButton.Down := fsUnderline in Editor.SelAttributes.Style;
//    BulletsButton.Down := Boolean(Numbering);
    cmbSchriftgrad.ItemIndex := cmbSchriftgrad.Items.IndexOf(IntToStr(reBemerkung.SelAttributes.Size));
//    FontName.Text := Editor.SelAttributes.Name;
//    case Ord(Alignment) of
//      0: mitAlignLeft.Down := True;
//      1: mitAlignRight.Down := True;
//      2: mitAlignCenter.Down := True;
//    end;
    UpdateCursorPos;
  finally
    FUpdating := False;
  end;
end;

procedure TfrmBemerkung.RulerResize(Sender: TObject);
begin
  RulerLine.Width := Ruler.ClientWidth - (RulerLine.Left*2);
end;

procedure TfrmBemerkung.SetSchriftgrad(const Value: Byte);
begin
  cmbSchriftgrad.ItemIndex := cmbSchriftgrad.Items.IndexOf(IntToStr(Value));
  cmbSchriftgradChange(nil);
end;

procedure TfrmBemerkung.SetSchriftgradVisible(const Value: Boolean);
begin
  lblSchriftgrad.Visible := Value;
  cmbSchriftgrad.Visible := Value;
end;

procedure TfrmBemerkung.SetupRuler;
var
  I: Integer;
  S: String;
begin
  SetLength(S, 201);
  I := 1;
  while I < 200 do
  begin
    S[I] := #9;
    S[I+1] := '|';
    Inc(I, 2);
  end;
  Ruler.Caption := S;
end;

procedure TfrmBemerkung.UpdateCursorPos;
var
  CharPos: TPoint;
begin
  CharPos.Y := SendMessage(reBemerkung.Handle, EM_EXLINEFROMCHAR, 0, reBemerkung.SelStart);
  CharPos.X := (reBemerkung.SelStart - SendMessage(reBemerkung.Handle, EM_LINEINDEX, CharPos.Y, 0));
  Inc(CharPos.Y);
  Inc(CharPos.X);
//  StatusBar.Panels[0].Text := Format(sColRowInfo, [CharPos.Y, CharPos.X]);
end;

procedure TfrmBemerkung.SetRTFText(const Value: String);
var
  StrSteam: TStringStream;
begin
  StrSteam := TStringStream.Create(Value);
  reBemerkung.Lines.BeginUpdate;
  try
    reBemerkung.PlainText := False;
    reBemerkung.Lines.LoadFromStream(StrSteam);
  finally
    reBemerkung.Lines.EndUpdate;
    StrSteam.Free;
  end;

  SendMessage(reBemerkung.Handle, EM_SETTYPOGRAPHYOPTIONS, TO_ADVANCEDTYPOGRAPHY, TO_ADVANCEDTYPOGRAPHY);
//  SendMessage(reBemerkung.Handle, EM_SETCHARFORMAT, TO_ADVANCEDTYPOGRAPHY, TO_ADVANCEDTYPOGRAPHY);
end;

procedure TfrmBemerkung.SaveBemerkungNode;
begin
  if Assigned(FBemerkungNode) then
  begin
    if reBemerkung.PlainText then
      FBemerkungNode.ChildValues['Text'] := GetPlanText
    else
      FBemerkungNode.ChildValues['Text'] := DeleteTrailingBlanks(GetRTFText);

    if Assigned(FBemerkungGGLNode) then
    begin
      FBemerkungGGLNode.ChildValues['Text'] := FBemerkungNode.ChildValues['Text'];
//      FBemerkungGGLNode.ChildValues['Schriftgrad'] := GetSchriftgrad;
    end;

    FBemerkungNode.ChildValues['Schriftgrad'] := GetSchriftgrad;
  end;
end;

procedure TfrmBemerkung.SetNurBemerkung(const Value: Boolean);
begin
  FNurBemerkung := Value;

  if FNurBemerkung then
    Align := alClient
  else
  begin
    Align := alBottom;
    Height := REG_Einstellungen.ReadInteger(PageControlName + '\Faecher\' + FachID, 'Height', 150);
  end;

  lblBemerkung.Visible := not FNurBemerkung;
end;

procedure TfrmBemerkung.SetPlanText(const Value: TCaption);
begin
  try
    reBemerkung.PlainText := True;
    reBemerkung.Text := Value;
  finally
    reBemerkung.PlainText := False;
  end;
end;

end.
