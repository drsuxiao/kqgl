object Frmkqdjnew: TFrmkqdjnew
  Left = 789
  Top = 335
  BorderStyle = bsDialog
  Caption = #32771#21220#30331#35760
  ClientHeight = 335
  ClientWidth = 497
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
  object Label1: TLabel
    Left = 48
    Top = 104
    Width = 60
    Height = 13
    Caption = #32771#21220#31867#22411#65306
  end
  object Label2: TLabel
    Left = 72
    Top = 24
    Width = 36
    Height = 13
    Caption = #31185#23460#65306
  end
  object Label3: TLabel
    Left = 72
    Top = 144
    Width = 36
    Height = 13
    Caption = #26085#26399#65306
  end
  object Label4: TLabel
    Left = 72
    Top = 64
    Width = 36
    Height = 13
    Caption = #22995#21517#65306
  end
  object Label5: TLabel
    Left = 211
    Top = 136
    Width = 12
    Height = 13
    Caption = #33267
  end
  object Label6: TLabel
    Left = 72
    Top = 184
    Width = 36
    Height = 13
    Caption = #26102#38388#65306
  end
  object Label7: TLabel
    Left = 179
    Top = 184
    Width = 12
    Height = 13
    Caption = #33267
  end
  object Label8: TLabel
    Left = 72
    Top = 224
    Width = 36
    Height = 13
    Caption = #22791#27880#65306
  end
  object cmbtype: TComboBox
    Left = 120
    Top = 96
    Width = 129
    Height = 21
    ItemHeight = 13
    TabOrder = 0
  end
  object cmbname: TComboBox
    Left = 120
    Top = 56
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 1
  end
  object cmbdept: TComboBox
    Left = 120
    Top = 20
    Width = 177
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    OnChange = cmbdeptChange
  end
  object dtfrom: TDateTimePicker
    Left = 118
    Top = 136
    Width = 81
    Height = 21
    Date = 42835.928764282410000000
    Format = 'yyyy-MM-dd'
    Time = 42835.928764282410000000
    TabOrder = 3
  end
  object dtto: TDateTimePicker
    Left = 232
    Top = 136
    Width = 81
    Height = 21
    Date = 42835.928764282410000000
    Format = 'yyyy-MM-dd'
    Time = 42835.928764282410000000
    TabOrder = 4
  end
  object medt1: TMaskEdit
    Left = 120
    Top = 184
    Width = 46
    Height = 21
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 5
    Text = '00:00'
  end
  object medt2: TMaskEdit
    Left = 200
    Top = 184
    Width = 44
    Height = 21
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 6
    Text = '00:00'
  end
  object btnOk: TButton
    Left = 224
    Top = 288
    Width = 75
    Height = 25
    Caption = #30830#23450
    ModalResult = 1
    TabOrder = 7
  end
  object btncancel: TButton
    Left = 336
    Top = 288
    Width = 75
    Height = 25
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 8
  end
  object Memo1: TMemo
    Left = 120
    Top = 216
    Width = 193
    Height = 65
    TabOrder = 9
  end
  object ADODataSet1: TADODataSet
    Parameters = <>
    Left = 80
    Top = 296
  end
end
