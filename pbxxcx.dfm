object frmpbxxquery: Tfrmpbxxquery
  Left = 456
  Top = 188
  Width = 677
  Height = 572
  Caption = #25490#29677#20449#24687
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 661
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 28
      Width = 36
      Height = 13
      Caption = #31185#23460#65306
    end
    object Label2: TLabel
      Left = 232
      Top = 28
      Width = 36
      Height = 13
      Caption = #26085#26399#65306
    end
    object Label5: TLabel
      Left = 356
      Top = 28
      Width = 12
      Height = 13
      Caption = #33267
    end
    object cmbdept: TComboBox
      Left = 50
      Top = 24
      Width = 177
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
    object dtfrom: TDateTimePicker
      Left = 274
      Top = 24
      Width = 81
      Height = 21
      Date = 42835.928764282410000000
      Format = 'yyyy-MM-dd'
      Time = 42835.928764282410000000
      TabOrder = 1
    end
    object dtto: TDateTimePicker
      Left = 370
      Top = 24
      Width = 81
      Height = 21
      Date = 42835.928764282410000000
      Format = 'yyyy-MM-dd'
      Time = 42835.928764282410000000
      TabOrder = 2
    end
    object btnquery: TButton
      Left = 469
      Top = 22
      Width = 75
      Height = 25
      Caption = #26597#35810
      TabOrder = 3
      OnClick = btnqueryClick
    end
    object Button1: TButton
      Left = 557
      Top = 22
      Width = 75
      Height = 25
      Caption = #23548#20986'Excel'
      TabOrder = 4
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 57
    Width = 661
    Height = 476
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 661
      Height = 476
      Align = alClient
      DataSource = DataSource1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = DBGrid1DrawColumnCell
    end
  end
  object ADODataSet1: TADODataSet
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=Sa123456;Persist Security Info=True' +
      ';User ID=sa;Initial Catalog=mydata;Data Source=127.0.0.1'
    Parameters = <>
    Left = 768
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = cds
    Left = 200
    Top = 241
  end
  object cds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 424
    Top = 185
  end
  object dspro: TDataSetProvider
    Left = 464
    Top = 185
  end
  object cds1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 432
    Top = 257
  end
  object dspro1: TDataSetProvider
    Left = 472
    Top = 257
  end
end
