object frmFachPunkt: TfrmFachPunkt
  Left = 542
  Top = 476
  Caption = 'frmFachPunkt'
  ClientHeight = 34
  ClientWidth = 996
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object pnlFachPunkt: TPanel
    Left = 0
    Top = 0
    Width = 996
    Height = 28
    Align = alTop
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    OnExit = pnlFachPunktExit
    ExplicitWidth = 1000
    DesignSize = (
      996
      28)
    object lblFachPunkt: TLabel
      Left = 6
      Top = 5
      Width = 760
      Height = 18
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'lblFachPunkt'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentFont = False
      OnDblClick = lblFachPunktDblClick
      ExplicitWidth = 764
    end
    object Torte_100: TRadioButton
      Left = 798
      Top = 6
      Width = 16
      Height = 17
      Anchors = [akTop, akRight]
      TabOrder = 0
      OnClick = Torte_100Click
      OnEnter = TorteEnter
      ExplicitLeft = 802
    end
    object Torte_080: TRadioButton
      Left = 838
      Top = 6
      Width = 16
      Height = 17
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnClick = Torte_080Click
      OnEnter = TorteEnter
      ExplicitLeft = 842
    end
    object Torte_060: TRadioButton
      Left = 878
      Top = 6
      Width = 16
      Height = 17
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnClick = Torte_060Click
      OnEnter = TorteEnter
      ExplicitLeft = 882
    end
    object Torte_040: TRadioButton
      Left = 918
      Top = 6
      Width = 16
      Height = 17
      Anchors = [akTop, akRight]
      TabOrder = 3
      OnClick = Torte_040Click
      OnEnter = TorteEnter
      ExplicitLeft = 922
    end
    object Torte_020: TRadioButton
      Left = 958
      Top = 6
      Width = 16
      Height = 17
      Anchors = [akTop, akRight]
      TabOrder = 4
      OnClick = Torte_020Click
      OnEnter = TorteEnter
      ExplicitLeft = 962
    end
    object ediFachPunkt: TEdit
      Left = 592
      Top = 3
      Width = 117
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = 'ediFachPunkt'
      OnExit = ediFachPunktExit
      ExplicitWidth = 121
    end
    object pnlCancel: TPanel
      Left = 763
      Top = 1
      Width = 26
      Height = 26
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      TabOrder = 6
      ExplicitLeft = 767
      object cbAbrechen: TSpeedButton
        Left = 4
        Top = 4
        Width = 18
        Height = 18
        Glyph.Data = {
          76010000424D760100000000000036000000280000000A0000000A0000000100
          18000000000040010000120B0000120B00000000000000000000FFFFFF6060AB
          8080B1FFFFFFFFFFFFFFFFFFFFFFFF9999B95959ADFFFFFFFFFF6A6ACE0E0EFF
          0D0EF4999ADAFFFFFFFFFFFFB5B5E00D0EEB0C0DFF4B4CCEFFFF7676D91718DC
          1618E81415DFB6B6E3CACAE91415DA1516E91819E35859CEFFFFFFFFFF8686CC
          1F21E22022EA1B1CD21A1BD01F21E82123E46E6ECEFFFFFFFFFFFFFFFFFFFFFF
          9F9FD72628D8282BE7282AE62628DB8888D3FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          CDCDE83133D72F32E82E31E73134DDAFAFDDFFFFFFFFFFFFFFFFFFFFFFB7B7DE
          383BDD3A3EF04144E34346E33A3EEF3A3EE29E9ED7FFFFFFFFFFA7A7DE4145DE
          464BF75155EF9292D4A1A1D65054EB474CF84447E69191D5FFFF5F61CF6168FF
          5D62F57F80CFFFFFFFFFFFFF9292D15A5FF2656BFF474ACEFFFFF0F0F96264D2
          7475D1FFFFFFFFFFFFFFFFFFFFFFFF8787CD6062E0E4E4FBFFFF}
        OnClick = cbAbrechenClick
      end
    end
  end
end
