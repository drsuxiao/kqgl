object Frmkqqktj: TFrmkqqktj
  Left = 485
  Top = 229
  Width = 798
  Height = 577
  Caption = #32771#21220#24773#20917#32479#35745
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
    Width = 782
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label4: TLabel
      Left = 476
      Top = 28
      Width = 14
      Height = 13
      Caption = #26376
    end
    object Label1: TLabel
      Left = 40
      Top = 28
      Width = 42
      Height = 13
      Caption = #31185#23460#65306
    end
    object Label2: TLabel
      Left = 288
      Top = 28
      Width = 42
      Height = 13
      Caption = #26085#26399#65306
    end
    object Label3: TLabel
      Left = 390
      Top = 24
      Width = 14
      Height = 13
      Caption = #24180
    end
    object cmbdept: TComboBox
      Left = 80
      Top = 20
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
    object cmbyear: TComboBox
      Left = 328
      Top = 20
      Width = 57
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        '2016'
        '2017'
        '2018'
        '2019')
    end
    object cmbmonth: TComboBox
      Left = 415
      Top = 20
      Width = 57
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        '01'
        '02'
        '03'
        '04'
        '05'
        '06'
        '07'
        '08'
        '09'
        '10'
        '11'
        '12')
    end
    object btnquery: TButton
      Left = 544
      Top = 16
      Width = 75
      Height = 25
      Caption = #26597#35810
      TabOrder = 3
      OnClick = btnqueryClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 782
    Height = 489
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 782
      Height = 489
      Align = alClient
      DataSource = DataSource1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -16
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
    end
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 248
    Top = 193
  end
  object ADODataSet1: TADODataSet
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=Sa123456;Persist Security Info=True' +
      ';User ID=sa;Initial Catalog=mydata;Data Source=127.0.0.1'
    Parameters = <>
    Left = 280
    Top = 193
  end
  object ADODataSet2: TADODataSet
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=Sa123456;Persist Security Info=True' +
      ';User ID=sa;Initial Catalog=mydata;Data Source=127.0.0.1'
    Parameters = <>
    Left = 456
    Top = 153
  end
  object ADODataSet3: TADODataSet
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=Sa123456;Persist Security Info=True' +
      ';User ID=sa;Initial Catalog=mydata;Data Source=127.0.0.1'
    Parameters = <>
    Left = 552
    Top = 161
  end
end
