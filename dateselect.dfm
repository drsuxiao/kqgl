object FrmDateselect: TFrmDateselect
  Left = 619
  Top = 308
  BorderStyle = bsDialog
  Caption = #26085#26399#36873#25321
  ClientHeight = 212
  ClientWidth = 470
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 241
    Top = 68
    Width = 12
    Height = 13
    Caption = #33267
  end
  object Label1: TLabel
    Left = 80
    Top = 66
    Width = 60
    Height = 13
    Caption = #25490#29677#26085#26399#65306
  end
  object Label4: TLabel
    Left = 51
    Top = 96
    Width = 84
    Height = 13
    Caption = #39318#26085#25490#29677#20154#21592#65306
  end
  object Label3: TLabel
    Left = 104
    Top = 36
    Width = 36
    Height = 13
    Caption = #31185#23460#65306
  end
  object dtfrom: TDateTimePicker
    Left = 148
    Top = 60
    Width = 91
    Height = 21
    Date = 42835.928764282410000000
    Time = 42835.928764282410000000
    TabOrder = 0
  end
  object dtto: TDateTimePicker
    Left = 257
    Top = 60
    Width = 86
    Height = 21
    Date = 42835.928764282410000000
    Time = 42835.928764282410000000
    TabOrder = 1
  end
  object cbmfirst: TComboBox
    Left = 148
    Top = 91
    Width = 189
    Height = 21
    ItemHeight = 13
    TabOrder = 2
  end
  object Button1: TButton
    Left = 216
    Top = 136
    Width = 75
    Height = 25
    Caption = #30830#23450
    ModalResult = 1
    TabOrder = 3
  end
  object Button2: TButton
    Left = 312
    Top = 136
    Width = 75
    Height = 25
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 4
  end
  object cmbdept: TComboBox
    Left = 149
    Top = 28
    Width = 177
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 5
    Text = #65288#26032#38451#65289#35745#31639#26426#32593#32476#20013#24515
    OnChange = cmbdeptChange
    Items.Strings = (
      #65288#26032#38451#65289#35745#31639#26426#32593#32476#20013#24515
      #65288#21410#31481#65289#35745#31639#26426#32593#32476#20013#24515)
  end
  object ADODataSet1: TADODataSet
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=Sa123456;Persist Security Info=True' +
      ';User ID=sa;Initial Catalog=mydata;Data Source=127.0.0.1'
    Parameters = <>
    Left = 64
    Top = 136
  end
end
