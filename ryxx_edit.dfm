object Frmedit_ryxx: TFrmedit_ryxx
  Left = 633
  Top = 251
  BorderStyle = bsDialog
  Caption = #32534#36753#31383
  ClientHeight = 264
  ClientWidth = 381
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 381
    Height = 264
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 59
      Top = 40
      Width = 60
      Height = 13
      Caption = #20154#21592#32534#21495#65306
    end
    object Label2: TLabel
      Left = 59
      Top = 64
      Width = 60
      Height = 13
      Caption = #20154#21592#22995#21517#65306
    end
    object label3: TLabel
      Left = 60
      Top = 118
      Width = 60
      Height = 13
      Caption = #31185#23460#21517#31216#65306
    end
    object Label4: TLabel
      Left = 88
      Top = 92
      Width = 37
      Height = 13
      Caption = #24615#21035':'
    end
    object Label5: TLabel
      Left = 60
      Top = 145
      Width = 61
      Height = 13
      Caption = #24037#20316#26085#26399':'
    end
    object Label6: TLabel
      Left = 59
      Top = 171
      Width = 60
      Height = 13
      Caption = #20986#29983#26085#26399#65306
    end
    object edtrybh: TEdit
      Left = 128
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object edtryxm: TEdit
      Left = 128
      Top = 56
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object cmbksmc: TComboBox
      Left = 128
      Top = 112
      Width = 185
      Height = 21
      ItemHeight = 13
      TabOrder = 2
    end
    object btnsave: TButton
      Left = 168
      Top = 224
      Width = 75
      Height = 25
      Caption = #20445#23384
      ModalResult = 1
      TabOrder = 3
      OnClick = btnsaveClick
    end
    object btncancel: TButton
      Left = 256
      Top = 224
      Width = 75
      Height = 25
      Caption = #21462#28040
      ModalResult = 2
      TabOrder = 4
      OnClick = btncancelClick
    end
    object rdbtn: TRadioButton
      Left = 296
      Top = 32
      Width = 73
      Height = 17
      Caption = #26032#22686#26631#35782
      TabOrder = 5
      Visible = False
    end
    object cbsex: TComboBox
      Left = 128
      Top = 88
      Width = 65
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 6
      Items.Strings = (
        ''
        #30007
        #22899)
    end
    object dtworkdate: TDateTimePicker
      Left = 128
      Top = 140
      Width = 113
      Height = 21
      Date = 43287.653948784730000000
      Time = 43287.653948784730000000
      TabOrder = 7
    end
    object dtbirthday: TDateTimePicker
      Left = 128
      Top = 168
      Width = 113
      Height = 21
      Date = 43287.653973923610000000
      Time = 43287.653973923610000000
      TabOrder = 8
    end
  end
  object cds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 64
    Top = 224
  end
  object dspro: TDataSetProvider
    Left = 104
    Top = 224
  end
end
