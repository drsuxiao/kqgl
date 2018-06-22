object Frmpbsx: TFrmpbsx
  Left = 499
  Top = 118
  Width = 596
  Height = 568
  Caption = #25490#29677#39034#24207#35774#32622
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
    Left = 96
    Top = 72
    Width = 84
    Height = 13
    Caption = #20154#21592#20449#24687#21015#34920#65306
  end
  object Label2: TLabel
    Left = 32
    Top = 24
    Width = 36
    Height = 13
    Caption = #31185#23460#65306
  end
  object Label3: TLabel
    Left = 296
    Top = 72
    Width = 84
    Height = 13
    Caption = #25490#29677#20154#21592#21015#34920#65306
  end
  object ListBox1: TListBox
    Left = 96
    Top = 88
    Width = 137
    Height = 353
    ItemHeight = 13
    TabOrder = 0
  end
  object ListBox2: TListBox
    Left = 296
    Top = 88
    Width = 145
    Height = 353
    ItemHeight = 13
    TabOrder = 1
  end
  object btnadd: TButton
    Left = 248
    Top = 160
    Width = 33
    Height = 25
    Caption = '>'
    TabOrder = 2
    OnClick = btnaddClick
  end
  object btndelete: TButton
    Left = 248
    Top = 208
    Width = 33
    Height = 25
    Caption = '<'
    TabOrder = 3
    OnClick = btndeleteClick
  end
  object btnaddall: TButton
    Left = 248
    Top = 272
    Width = 33
    Height = 25
    Caption = '>>'
    TabOrder = 4
    OnClick = btnaddallClick
  end
  object btndelall: TButton
    Left = 248
    Top = 312
    Width = 33
    Height = 25
    Caption = '<<'
    TabOrder = 5
    OnClick = btndelallClick
  end
  object cmbdept: TComboBox
    Left = 80
    Top = 24
    Width = 177
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 6
    Text = #65288#26032#38451#65289#35745#31639#26426#32593#32476#20013#24515
    OnChange = cmbdeptChange
    Items.Strings = (
      #65288#26032#38451#65289#35745#31639#26426#32593#32476#20013#24515
      #65288#21410#31481#65289#35745#31639#26426#32593#32476#20013#24515)
  end
  object btnmoveup: TButton
    Left = 464
    Top = 176
    Width = 75
    Height = 25
    Caption = #19978#31227
    TabOrder = 7
    OnClick = btnmoveupClick
  end
  object btnmovedown: TButton
    Left = 464
    Top = 224
    Width = 75
    Height = 25
    Caption = #19979#31227
    TabOrder = 8
    OnClick = btnmovedownClick
  end
  object btnsave: TButton
    Left = 312
    Top = 480
    Width = 75
    Height = 25
    Caption = #20445#23384
    TabOrder = 9
    OnClick = btnsaveClick
  end
  object btnclose: TButton
    Left = 448
    Top = 480
    Width = 75
    Height = 25
    Caption = #36864#20986
    ModalResult = 2
    TabOrder = 10
  end
  object cds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 176
  end
  object dspro: TDataSetProvider
    Left = 64
    Top = 176
  end
end
