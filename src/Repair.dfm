object frmRepair: TfrmRepair
  Left = 0
  Top = 0
  Caption = 'frmRepair'
  ClientHeight = 523
  ClientWidth = 967
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    967
    523)
  PixelsPerInch = 96
  TextHeight = 13
  object mitOeffnen: TButton
    Left = 791
    Top = 8
    Width = 155
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #214'ffnen'
    TabOrder = 0
    OnClick = mitOeffnenClick
  end
  object mitRepair: TButton
    Left = 791
    Top = 48
    Width = 155
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Reparieren'
    TabOrder = 1
    OnClick = mitRepairClick
  end
  object chkBackup: TCheckBox
    Left = 791
    Top = 104
    Width = 155
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Sicherung erstellen'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object ListBox1: TListBox
    Left = 8
    Top = 8
    Width = 761
    Height = 507
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 3
  end
  object OpenSchueler: TOpenDialog
    DefaultExt = 'xschueler'
    Filter = 
      'Alle Sch'#252'ler-Dateien (*.schueler;*.xschueler)|*.schueler;*.xschu' +
      'eler|Alle Dateien (*.*)|*.*'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofFileMustExist, ofEnableSizing]
    Title = 'Bitte ein Dokument w'#228'hlen'
    Left = 792
    Top = 215
  end
  object Codec1: TCodec
    AsymetricKeySizeInBits = 1024
    AdvancedOptions2 = []
    CryptoLibrary = CryptographicLibrary1
    Left = 792
    Top = 264
    StreamCipherId = 'native.StreamToBlock'
    BlockCipherId = 'native.AES-192'
    ChainId = 'native.CFB'
  end
  object CryptographicLibrary1: TCryptographicLibrary
    Left = 840
    Top = 264
  end
end
