object frmDruckenDlg: TfrmDruckenDlg
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Drucken'
  ClientHeight = 280
  ClientWidth = 545
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 460
    Top = 8
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 460
    Top = 38
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 1
  end
  object grbPrinter: TGroupBox
    Left = 7
    Top = 8
    Width = 434
    Height = 153
    Caption = ' Drucker '
    TabOrder = 2
    object lblPrinterName: TLabel
      Left = 12
      Top = 24
      Width = 31
      Height = 13
      Caption = 'Name:'
    end
    object lblStatus: TLabel
      Left = 12
      Top = 48
      Width = 35
      Height = 13
      Caption = 'Status:'
    end
    object lblTyp: TLabel
      Left = 12
      Top = 72
      Width = 22
      Height = 13
      Caption = 'Typ:'
    end
    object lblStatusValue: TLabel
      Left = 82
      Top = 48
      Width = 35
      Height = 13
      Caption = 'Status:'
    end
    object lblTypValue: TLabel
      Left = 82
      Top = 72
      Width = 35
      Height = 13
      Caption = 'Status:'
    end
    object cmbPrinter: TComboBox
      Left = 82
      Top = 21
      Width = 217
      Height = 21
      TabOrder = 0
      Text = 'cmbPrinter'
      OnChange = cmbPrinterChange
    end
    object btnEigenschaften: TButton
      Left = 312
      Top = 19
      Width = 113
      Height = 25
      Caption = 'Eigenschaften ...'
      TabOrder = 1
      OnClick = btnEigenschaftenClick
    end
  end
  object grbPapier: TGroupBox
    Left = 8
    Top = 165
    Width = 265
    Height = 105
    Caption = ' Papier '
    TabOrder = 3
    object lblGrosse: TLabel
      Left = 11
      Top = 21
      Width = 33
      Height = 13
      Caption = 'Gro'#223'e:'
    end
    object lblQuelle: TLabel
      Left = 11
      Top = 49
      Width = 34
      Height = 13
      Caption = 'Quelle:'
    end
    object lblDuplex: TLabel
      Left = 11
      Top = 78
      Width = 37
      Height = 13
      Caption = 'Duplex:'
    end
    object cmbPapier: TComboBox
      Left = 81
      Top = 18
      Width = 160
      Height = 21
      TabOrder = 0
      Text = 'cmbPrinter'
    end
    object cmbQuelle: TComboBox
      Left = 81
      Top = 46
      Width = 160
      Height = 21
      TabOrder = 1
      Text = 'cmbPrinter'
    end
    object cmbDuplex: TComboBox
      Left = 81
      Top = 75
      Width = 160
      Height = 21
      TabOrder = 2
      Text = 'cmbPrinter'
      OnChange = cmbDuplexChange
      Items.Strings = (
        'Einfach'
        'Vertikal'
        'Horizontal')
    end
  end
end
