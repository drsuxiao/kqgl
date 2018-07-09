object FrmModifypb: TFrmModifypb
  Left = 871
  Top = 186
  BorderStyle = bsDialog
  Caption = #20462#25913#25490#29677#20449#24687
  ClientHeight = 187
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 88
    Width = 84
    Height = 13
    Caption = #21407#25490#29677#20154#21592#65306
  end
  object Label2: TLabel
    Left = 176
    Top = 88
    Width = 84
    Height = 13
    Caption = #29616#25490#29677#20154#21592#65306
  end
  object Label3: TLabel
    Left = 40
    Top = 32
    Width = 42
    Height = 13
    Caption = #26085#26399#65306
  end
  object Label4: TLabel
    Left = 144
    Top = 104
    Width = 21
    Height = 13
    Caption = '----->'
  end
  object Label5: TLabel
    Left = 40
    Top = 56
    Width = 42
    Height = 13
    Caption = #31185#23460#65306
  end
  object cmbnew: TComboBox
    Left = 176
    Top = 104
    Width = 97
    Height = 21
    ItemHeight = 13
    TabOrder = 0
  end
  object edtold: TEdit
    Left = 40
    Top = 104
    Width = 89
    Height = 21
    TabOrder = 1
  end
  object dtrq: TDateTimePicker
    Left = 88
    Top = 24
    Width = 105
    Height = 21
    Date = 42839.610935150460000000
    Time = 42839.610935150460000000
    TabOrder = 2
    OnChange = dtrqChange
  end
  object btnOk: TButton
    Left = 152
    Top = 144
    Width = 57
    Height = 25
    Caption = #30830#23450
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 224
    Top = 144
    Width = 57
    Height = 25
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 4
  end
  object cmbdept: TComboBox
    Left = 88
    Top = 52
    Width = 177
    Height = 21
    ItemHeight = 13
    TabOrder = 5
    OnChange = cmbdeptChange
  end
  object cds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 216
    Top = 8
  end
  object dspro: TDataSetProvider
    Left = 248
    Top = 8
  end
end
