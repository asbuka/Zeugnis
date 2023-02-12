object frmBemerkung: TfrmBemerkung
  Left = 480
  Top = 315
  BorderWidth = 3
  Caption = 'frmBemerkung'
  ClientHeight = 373
  ClientWidth = 1137
  Color = clBtnFace
  Constraints.MinHeight = 100
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 13
  object pnlBemerungLabel: TPanel
    Left = 0
    Top = 0
    Width = 1137
    Height = 26
    Align = alTop
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    DesignSize = (
      1137
      26)
    object lblBemerkung: TLabel
      Left = 8
      Top = 7
      Width = 132
      Height = 13
      Caption = 'Erg'#228'nzungen zum Fach:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSchriftgrad: TLabel
      Left = 1021
      Top = 7
      Width = 53
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Schriftgrad'
    end
    object cmbSchriftgrad: TComboBox
      Left = 1082
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
  object pnlBemerkungText: TPanel
    Left = 0
    Top = 26
    Width = 1137
    Height = 347
    Align = alClient
    BorderWidth = 5
    Caption = 'pnlBemerkungText'
    TabOrder = 1
    OnResize = pnlBemerkungTextResize
    object reBemerkung: TRichEditEx
      Left = 6
      Top = 32
      Width = 1125
      Height = 309
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PopupMenu = PopupActionBar
      ScrollBars = ssVertical
      TabOrder = 0
      OnChange = reBemerkungChange
      OnSelectionChange = SelectionChange
      OnAfterPaste = reBemerkungAfterPaste
    end
    object Ruler: TPanel
      Left = 6
      Top = 6
      Width = 1125
      Height = 26
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'asdf'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnResize = RulerResize
      object FirstInd: TLabel
        Left = 2
        Top = 2
        Width = 10
        Height = 9
        AutoSize = False
        Caption = #234
        DragCursor = crArrow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        OnMouseDown = RulerItemMouseDown
        OnMouseMove = RulerItemMouseMove
        OnMouseUp = FirstIndMouseUp
      end
      object LeftInd: TLabel
        Left = 2
        Top = 12
        Width = 10
        Height = 11
        AutoSize = False
        Caption = #233
        DragCursor = crArrow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        OnMouseDown = RulerItemMouseDown
        OnMouseMove = RulerItemMouseMove
        OnMouseUp = LeftIndMouseUp
      end
      object RulerLine: TBevel
        Left = 4
        Top = 12
        Width = 579
        Height = 2
        Shape = bsTopLine
      end
      object RightInd: TLabel
        Left = 575
        Top = 14
        Width = 9
        Height = 12
        Caption = #241
        DragCursor = crArrow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        OnMouseDown = RulerItemMouseDown
        OnMouseMove = RulerItemMouseMove
        OnMouseUp = RightIndMouseUp
      end
      object Bevel1: TBevel
        Left = 0
        Top = 0
        Width = 1125
        Height = 2
        Align = alTop
        Shape = bsTopLine
        ExplicitWidth = 617
      end
    end
  end
  object PopupActionBar: TPopupActionBar
    Left = 816
    Top = 162
    object mitUndo: TMenuItem
      Caption = '&R'#252'ckg'#228'ngig'
      Hint = 'R'#252'ckg'#228'ngig|Letzte Aktion r'#252'ckg'#228'ngig machen'
      ImageIndex = 4
      ShortCut = 16474
    end
    object mitRedo: TMenuItem
      Caption = 'Wiederholen'
      Hint = 'Wiederholen'
      ShortCut = 16473
    end
    object mitCut: TMenuItem
      Caption = '&Ausschneiden'
      Hint = 'Ausschneiden|Auswahl in die Zwischenablage verschieben'
      ImageIndex = 1
      ShortCut = 16472
    end
    object mitCopy: TMenuItem
      Caption = '&Kopieren'
      Hint = 'Kopieren|Auswahl in die Zwischenablage kopieren'
      ImageIndex = 2
      ShortCut = 16451
    end
    object mitPaste: TMenuItem
      Caption = '&Einf'#252'gen'
      Hint = 'Einf'#252'gen|Inhalt der Zwischenablage einf'#252'gen'
      ImageIndex = 3
      ShortCut = 16470
    end
    object mitSelectAll: TMenuItem
      Caption = 'Alles &markieren'
      Hint = 'Alles markieren|Gesamtes Dokument ausw'#228'hlen'
      ShortCut = 16449
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mitAlignLeft: TMenuItem
      AutoCheck = True
      Caption = '&Links ausrichten'
      Hint = 'Links ausrichten|Text linksb'#252'ndig ausrichten'
      ImageIndex = 16
    end
    object mitAlignCenter: TMenuItem
      AutoCheck = True
      Caption = '&Zentrieren'
      Hint = 'Zentrieren|Text zentriert ausrichten'
      ImageIndex = 17
    end
    object mitAlignRight: TMenuItem
      AutoCheck = True
      Caption = '&Rechts ausrichten'
      Hint = 'Rechts ausrichten|Text rechtsb'#252'ndig ausrichten'
      ImageIndex = 18
    end
    object mitAlignBlock: TMenuItem
      Caption = 'Blocksatz'
      ImageIndex = 19
    end
  end
end
