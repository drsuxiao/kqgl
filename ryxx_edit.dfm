object Frmedit_ryxx: TFrmedit_ryxx
  Left = 926
  Top = 259
  BorderStyle = bsDialog
  Caption = #32534#36753#31383
  ClientHeight = 268
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 417
    Height = 268
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 56
      Top = 40
      Width = 60
      Height = 13
      Caption = #20154#21592#32534#21495#65306
    end
    object Label2: TLabel
      Left = 56
      Top = 96
      Width = 60
      Height = 13
      Caption = #20154#21592#22995#21517#65306
    end
    object label3: TLabel
      Left = 56
      Top = 144
      Width = 60
      Height = 13
      Caption = #31185#23460#21517#31216#65306
    end
    object edtrybh: TEdit
      Left = 136
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object edtryxm: TEdit
      Left = 136
      Top = 88
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object cmbksmc: TComboBox
      Left = 136
      Top = 136
      Width = 169
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = #65288#26032#38451#65289#35745#31639#26426#32593#32476#20013#24515
      Items.Strings = (
        #65288#26032#38451#65289#35745#31639#26426#32593#32476#20013#24515
        #65288#21410#31481#65289#35745#31639#26426#32593#32476#20013#24515)
    end
    object btnsave: TButton
      Left = 168
      Top = 208
      Width = 75
      Height = 25
      Caption = #20445#23384
      ModalResult = 1
      TabOrder = 3
      OnClick = btnsaveClick
    end
    object btncancel: TButton
      Left = 272
      Top = 208
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
