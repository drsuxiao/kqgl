object frmzbcstj: Tfrmzbcstj
  Left = 376
  Top = 212
  Width = 552
  Height = 368
  Caption = #20540#29677#27425#25968#32479#35745
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
  object Panel1: TPanel
    Left = 0
    Top = 41
    Width = 536
    Height = 288
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 536
      Height = 288
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
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 536
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label4: TLabel
      Left = 429
      Top = 16
      Width = 12
      Height = 13
      Caption = #26376
    end
    object Label1: TLabel
      Left = 14
      Top = 16
      Width = 36
      Height = 13
      Caption = #31185#23460#65306
    end
    object Label2: TLabel
      Left = 241
      Top = 16
      Width = 36
      Height = 13
      Caption = #26085#26399#65306
    end
    object Label3: TLabel
      Left = 343
      Top = 16
      Width = 12
      Height = 13
      Caption = #24180
    end
    object cmbdept: TComboBox
      Left = 54
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
    object cmbyear: TComboBox
      Left = 281
      Top = 12
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
      Left = 368
      Top = 12
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
      Left = 449
      Top = 10
      Width = 75
      Height = 25
      Caption = #26597#35810
      TabOrder = 3
      OnClick = btnqueryClick
    end
  end
  object DataSource1: TDataSource
    DataSet = cds
    Left = 320
    Top = 160
  end
  object cds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 352
    Top = 161
  end
  object dspro: TDataSetProvider
    Left = 384
    Top = 161
  end
end
