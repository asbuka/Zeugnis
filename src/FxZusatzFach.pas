unit FxZusatzFach;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Xml.XMLIntf, Schule;

type
  TfrmZusatzFach = class(TForm)
    pnlFachZusatz: TPanel;
    lblFachZusatzText1: TLabel;
    lblFachZusatzText2: TLabel;
    ediFachZusatz: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ediFachZusatzChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
    FFachZusatzNode: IXMLNode;
    FOnZusatzFachChange: TNotifyEvent;
    FModus: TZeugnistModus;
    procedure SetLabel2Caption(const Value: TCaption);
  public
    { Public-Deklarationen }
    procedure SaveZusatzFachNode;
    property Modus: TZeugnistModus read FModus write FModus;
    property OnZusatzFachChange: TNotifyEvent read FOnZusatzFachChange write FOnZusatzFachChange;
    procedure InitFromXML(aXMLNode: IXMLNode);
  end;

//var
//  frmZusatzFach: TfrmZusatzFach;

implementation

{$R *.dfm}

procedure TfrmZusatzFach.ediFachZusatzChange(Sender: TObject);
begin
  if Assigned(FOnZusatzFachChange) then
    OnZusatzFachChange(Self);
end;

procedure TfrmZusatzFach.FormCreate(Sender: TObject);
begin
  Parent := Owner as TWinControl;
  BorderStyle := bsNone;
  pnlFachZusatz.BevelOuter := bvNone;
  ParentBackground := False;
  Height := pnlFachZusatz.Height;

  lblFachZusatzText1.Font.Assign(GS_Hoisbuettel_FontLabel);
  lblFachZusatzText2.Font.Assign(GS_Hoisbuettel_FontLabel);
//  ediFachZusatz.Font.Assign(GS_Hoisbuettel_FontEdit);

  lblFachZusatzText1.Caption := '';
  lblFachZusatzText2.Caption := '';
end;

procedure TfrmZusatzFach.FormDestroy(Sender: TObject);
begin
  REG_Einstellungen.WriteString('EINGABE', 'FachZusatzText', ediFachZusatz.Text);
end;

procedure TfrmZusatzFach.FormShow(Sender: TObject);
begin
  Top := 100;
  Align := alTop;
end;

procedure TfrmZusatzFach.InitFromXML(aXMLNode: IXMLNode);
begin
  if Assigned(aXMLNode) then
  begin
    FFachZusatzNode := aXMLNode;

    lblFachZusatzText1.Caption := VarToStr(FFachZusatzNode.ChildValues['LabelText1']);
    ediFachZusatz.Text         := VarToStr(FFachZusatzNode.ChildValues['Text']);

    lblFachZusatzText2.Visible := not VarIsNull(FFachZusatzNode.ChildValues['LabelText2']);
    if lblFachZusatzText2.Visible then
      SetLabel2Caption(VarToStr(FFachZusatzNode.ChildValues['LabelText2']));

    ediFachZusatz.Left := lblFachZusatzText1.Left + lblFachZusatzText1.Canvas.TextWidth(lblFachZusatzText1.Caption) + 10;
    if lblFachZusatzText2.Visible then
      ediFachZusatz.Width := pnlFachZusatz.Width - lblFachZusatzText1.Left - lblFachZusatzText1.Width - lblFachZusatzText2.Width - 30
    else
      ediFachZusatz.Width := pnlFachZusatz.Width - lblFachZusatzText1.Left - lblFachZusatzText1.Width - 30;

    if (ediFachZusatz.Text = '') and (Trunc(Now - REG_Einstellungen.ReadDate('EINGABE', 'LastEingabe', Now)) < 5 * 30) then  // nicht alter als 5 Monate
      ediFachZusatz.Text := REG_Einstellungen.ReadString('EINGABE', 'FachZusatzText', '');
  end;
end;

procedure TfrmZusatzFach.SaveZusatzFachNode;
begin
  if Assigned(FFachZusatzNode) then
    FFachZusatzNode.ChildValues['Text'] := Trim(ediFachZusatz.Text);
end;

procedure TfrmZusatzFach.SetLabel2Caption(const Value: TCaption);
begin
  lblFachZusatzText2.Caption := Value;

  lblFachZusatzText2.Width := lblFachZusatzText2.Canvas.TextWidth(lblFachZusatzText2.Caption) + 20;
  lblFachZusatzText2.Left := pnlFachZusatz.Width - lblFachZusatzText2.Width - 10;
end;

end.
