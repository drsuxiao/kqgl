object frmkqdjjm: Tfrmkqdjjm
  Left = 534
  Top = 207
  Width = 710
  Height = 467
  Caption = #32771#21220#30331#35760
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
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 694
    Height = 346
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 694
      Height = 346
      Align = alClient
      DataSource = DataSource1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = DBGrid1DrawColumnCell
      OnTitleClick = DBGrid1TitleClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 387
    Width = 694
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
      Left = 272
      Top = 8
      Width = 57
      Height = 25
      Caption = #36864#20986
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 694
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label3: TLabel
      Left = 7
      Top = 17
      Width = 42
      Height = 13
      Caption = #31185#23460#65306
    end
    object Label2: TLabel
      Left = 342
      Top = 17
      Width = 14
      Height = 13
      Caption = #33267
    end
    object Label1: TLabel
      Left = 227
      Top = 17
      Width = 42
      Height = 13
      Caption = #26085#26399#65306
    end
    object cmbdept: TComboBox
      Left = 47
      Top = 13
      Width = 170
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        '')
    end
    object dtfrom: TDateTimePicker
      Left = 257
      Top = 13
      Width = 81
      Height = 21
      Date = 42835.928764282410000000
      Time = 42835.928764282410000000
      TabOrder = 1
    end
    object dtto: TDateTimePicker
      Left = 355
      Top = 13
      Width = 81
      Height = 21
      Date = 42835.928764282410000000
      Time = 42835.928764282410000000
      TabOrder = 2
    end
    object btnquery: TButton
      Left = 443
      Top = 11
      Width = 50
      Height = 25
      Caption = #26597#35810
      TabOrder = 3
      OnClick = btnqueryClick
    end
    object Button2: TButton
      Left = 499
      Top = 11
      Width = 66
      Height = 25
      Caption = #23548#20986'Excel'
      TabOrder = 4
      OnClick = Button2Click
    end
  end
  object DataSource1: TDataSource
    DataSet = cds
    Left = 296
    Top = 153
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
