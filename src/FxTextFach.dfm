object frmTextFach: TfrmTextFach
  Left = 480
  Top = 318
  BorderWidth = 3
  Caption = 'frmTextFach'
  ClientHeight = 372
  ClientWidth = 1133
  Color = clBtnFace
  Constraints.MinHeight = 100
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 13
  object pnlTextLabel: TPanel
    Left = 0
    Top = 0
    Width = 1133
    Height = 26
    Align = alTop
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    DesignSize = (
      1133
      26)
    object lblSchriftgrad: TLabel
      Left = 1017
      Top = 7
      Width = 53
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Schriftgrad'
      ExplicitLeft = 1021
    end
    object cmbSchriftgrad: TComboBox
      Left = 1078
      Top = 3
      Width = 51
      Height = 21
      HelpType = htKeyword
      HelpKeyword = 'name'
      Style = csDropDownList
      Anchors = [akTop, akRight]
      TabOrder = 0
      OnChange = cmbSchriftgradChange
      Items.Strings = (
        '8'
        '9'
        '10'
        '11'
        '12'
        '14'
        '16')
    end
  end
  object pnlTextFachEx: TPanel
    Left = 0
    Top = 26
    Width = 1133
    Height = 346
    Align = alClient
    BorderWidth = 3
    Caption = 'pnlTextFachEx'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    object pnlDebug: TPanel
      Left = 884
      Top = 4
      Width = 253
      Height = 340
      Align = alRight
      TabOrder = 0
      ExplicitLeft = 876
      ExplicitHeight = 338
      object Label1: TLabel
        Left = 9
        Top = 7
        Width = 31
        Height = 13
        Caption = 'Label1'
      end
      object Label2: TLabel
        Left = 9
        Top = 27
        Width = 31
        Height = 13
        Caption = 'Label2'
      end
      object Label3: TLabel
        Left = 9
        Top = 51
        Width = 31
        Height = 13
        Caption = 'Label3'
      end
    end
    object pnlTextFach: TPanel
      Left = 4
      Top = 4
      Width = 880
      Height = 340
      Align = alClient
      BorderWidth = 5
      Caption = 'pnlTextFach'
      TabOrder = 1
      ExplicitWidth = 872
      ExplicitHeight = 338
      object reTextFach: TRichEdit
        Left = 6
        Top = 6
        Width = 868
        Height = 328
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        HideSelection = False
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        WantReturns = False
        OnChange = reTextFachChange
        OnDblClick = reTextFachDblClick
        OnMouseDown = reTextFachMouseDown
      end
    end
  end
  object PHTortenMenu: TPopupMenu
    OnPopup = PHTortenMenuPopup
    Left = 696
    Top = 40
  end
end
