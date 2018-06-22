object frmkqdjjm: Tfrmkqdjjm
  Left = 544
  Top = 295
  Width = 798
  Height = 568
  Caption = #32771#21220#30331#35760
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
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 782
    Height = 447
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 782
      Height = 447
      Align = alClient
      DataSource = DataSource1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 488
    Width = 782
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btncreate: TButton
      Left = 64
      Top = 8
      Width = 49
      Height = 25
      Caption = #26032#22686
      TabOrder = 0
      OnClick = btncreateClick
    end
    object btndelete: TButton
      Left = 208
      Top = 8
      Width = 49
      Height = 25
      Caption = #21024#38500
      TabOrder = 1
      OnClick = btndeleteClick
    end
    object btnmodify: TButton
      Left = 136
      Top = 8
      Width = 49
      Height = 25
      Caption = #20462#25913
      TabOrder = 2
      OnClick = btnmodifyClick
    end
    object Button1: TButton
      Left = 776
      Top = 8
      Width = 75
      Height = 25
      Caption = #36864#20986
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 782
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label3: TLabel
      Left = 16
      Top = 20
      Width = 42
      Height = 13
      Caption = #31185#23460#65306
    end
    object Label2: TLabel
      Left = 403
      Top = 8
      Width = 14
      Height = 13
      Caption = #33267
    end
    object Label1: TLabel
      Left = 264
      Top = 16
      Width = 42
      Height = 13
      Caption = #26085#26399#65306
    end
    object cmbdept: TComboBox
      Left = 56
      Top = 12
      Width = 177
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = #65288#26032#38451#65289#35745#31639#26426#32593#32476#20013#24515
      Items.Strings = (
        #65288#26032#38451#65289#35745#31639#26426#32593#32476#20013#24515
        #65288#21410#31481#65289#35745#31639#26426#32593#32476#20013#24515
        #20840#37096)
    end
    object dtfrom: TDateTimePicker
      Left = 310
      Top = 8
      Width = 81
      Height = 21
      Date = 42835.928764282410000000
      Time = 42835.928764282410000000
      TabOrder = 1
    end
    object dtto: TDateTimePicker
      Left = 424
      Top = 8
      Width = 81
      Height = 21
      Date = 42835.928764282410000000
      Time = 42835.928764282410000000
      TabOrder = 2
    end
    object btnquery: TButton
      Left = 528
      Top = 8
      Width = 75
      Height = 25
      Caption = #26597#35810
      TabOrder = 3
      OnClick = btnqueryClick
    end
    object Button2: TButton
      Left = 624
      Top = 8
      Width = 75
      Height = 25
      Caption = #23548#20986'Excel'
      TabOrder = 4
      OnClick = Button2Click
    end
  end
  object DataSource1: TDataSource
    DataSet = cds
    Left = 216
    Top = 121
  end
  object cds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 328
    Top = 153
  end
  object dspro: TDataSetProvider
    Left = 368
    Top = 153
  end
end
