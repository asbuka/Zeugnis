object frmLexicon: TfrmLexicon
  Left = 0
  Top = 0
  Caption = 'Lexicon'
  ClientHeight = 426
  ClientWidth = 823
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHaupt: TPanel
    Left = 0
    Top = 0
    Width = 823
    Height = 426
    Align = alClient
    TabOrder = 0
    object pnlTexten: TPanel
      Left = 1
      Top = 1
      Width = 821
      Height = 383
      Align = alClient
      BorderWidth = 1
      TabOrder = 0
      OnResize = pnlTextenResize
      object Splitter1: TSplitter
        Left = 401
        Top = 2
        Height = 379
        ExplicitLeft = 288
        ExplicitTop = 10
        ExplicitHeight = 373
      end
      object pnlBad: TPanel
        Left = 2
        Top = 2
        Width = 399
        Height = 379
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 4
        TabOrder = 0
        object memBad: TMemo
          Left = 4
          Top = 29
          Width = 391
          Height = 346
          Align = alClient
          ScrollBars = ssHorizontal
          TabOrder = 0
        end
        object pnlBadText: TPanel
          Left = 4
          Top = 4
          Width = 391
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Fehlerhafter Text'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
      end
      object pnlGood: TPanel
        Left = 404
        Top = 2
        Width = 415
        Height = 379
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 4
        TabOrder = 1
        object memGood: TMemo
          Left = 4
          Top = 29
          Width = 407
          Height = 346
          Align = alClient
          ScrollBars = ssHorizontal
          TabOrder = 0
        end
        object pnlGoodText: TPanel
          Left = 4
          Top = 4
          Width = 407
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Korrigierter Text'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
      end
    end
    object pnlButton: TPanel
      Left = 1
      Top = 384
      Width = 821
      Height = 41
      Align = alBottom
      TabOrder = 1
      object BitBtn1: TBitBtn
        Left = 5
        Top = 6
        Width = 130
        Height = 25
        Kind = bkOK
        NumGlyphs = 2
        TabOrder = 0
        OnClick = BitBtn1Click
      end
      object BitBtn2: TBitBtn
        Left = 152
        Top = 6
        Width = 130
        Height = 25
        Kind = bkCancel
        NumGlyphs = 2
        TabOrder = 1
        OnClick = BitBtn2Click
      end
    end
  end
end
