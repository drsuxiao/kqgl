object frmkqflhz: Tfrmkqflhz
  Left = 313
  Top = 173
  Width = 726
  Height = 467
  Caption = #32771#21220#20998#31867#27719#24635
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
    Width = 710
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 208
      Top = 16
      Width = 42
      Height = 13
      Caption = #26085#26399#65306
    end
    object Label2: TLabel
      Left = 331
      Top = 16
      Width = 14
      Height = 13
      Caption = #33267
    end
    object Label3: TLabel
      Left = 8
      Top = 16
      Width = 42
      Height = 13
      Caption = #31185#23460#65306
    end
    object Label4: TLabel
      Left = 432
      Top = 16
      Width = 42
      Height = 13
      Caption = #31867#22411#65306
    end
    object dtfrom: TDateTimePicker
      Left = 246
      Top = 12
      Width = 81
      Height = 21
      Date = 42835.928764282410000000
      Time = 42835.928764282410000000
      TabOrder = 0
    end
    object dtto: TDateTimePicker
      Left = 344
      Top = 12
      Width = 81
      Height = 21
      Date = 42835.928764282410000000
      Time = 42835.928764282410000000
      TabOrder = 1
    end
    object Button1: TButton
      Left = 528
      Top = 10
      Width = 75
      Height = 25
      Caption = #26597#35810
      TabOrder = 2
      OnClick = Button1Click
    end
    object cmbdept: TComboBox
      Left = 48
      Top = 12
      Width = 153
      Height = 21
      ItemHeight = 13
      TabOrder = 3
    end
    object Button2: TButton
      Left = 616
      Top = 10
      Width = 75
      Height = 25
      Caption = #23548#20986'Excel'
      TabOrder = 4
      OnClick = Button2Click
    end
    object Cmbtype: TComboBox
      Left = 464
      Top = 12
      Width = 57
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 5
      Text = #20840#37096
      Items.Strings = (
        #20840#37096
        '01,'#20844#20241
        '02,'#34917#20241
        '03,'#20986#24046
        '04,'#23398#20064
        '05,'#24320#20250
        '06,'#20107#20551
        '07,'#20135#20551
        '08,'#38506#20135#20551
        '09,'#30149#20551
        '10,'#20854#23427)
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 710
    Height = 387
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 710
      Height = 387
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
  object DataSource1: TDataSource
    DataSet = cds
    Left = 128
    Top = 217
  end
  object cds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 312
    Top = 193
  end
  object dspro: TDataSetProvider
    Left = 344
    Top = 193
  end
end
