object frmpbxxquery: Tfrmpbxxquery
  Left = 456
  Top = 188
  Width = 886
  Height = 568
  Caption = #25490#29677#20449#24687
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 870
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 48
      Top = 20
      Width = 36
      Height = 13
      Caption = #31185#23460#65306
    end
    object Label2: TLabel
      Left = 304
      Top = 20
      Width = 36
      Height = 13
      Caption = #26085#26399#65306
    end
    object Label5: TLabel
      Left = 435
      Top = 20
      Width = 12
      Height = 13
      Caption = #33267
    end
    object cmbdept: TComboBox
      Left = 88
      Top = 12
      Width = 177
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = #65288#26032#38451#65289#35745#31639#26426#32593#32476#20013#24515
      Items.Strings = (
        #65288#26032#38451#65289#35745#31639#26426#32593#32476#20013#24515
        #65288#21410#31481#65289#35745#31639#26426#32593#32476#20013#24515)
    end
    object dtfrom: TDateTimePicker
      Left = 342
      Top = 12
      Width = 81
      Height = 21
      Date = 42835.928764282410000000
      Time = 42835.928764282410000000
      TabOrder = 1
    end
    object dtto: TDateTimePicker
      Left = 456
      Top = 12
      Width = 81
      Height = 21
      Date = 42835.928764282410000000
      Time = 42835.928764282410000000
      TabOrder = 2
    end
    object btnquery: TButton
      Left = 568
      Top = 16
      Width = 75
      Height = 25
      Caption = #26597#35810
      TabOrder = 3
      OnClick = btnqueryClick
    end
    object Button1: TButton
      Left = 664
      Top = 16
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
    Width = 870
    Height = 473
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 870
      Height = 473
      Align = alClient
      DataSource = DataSource1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -21
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
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
