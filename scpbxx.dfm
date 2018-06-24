object Frmscpbxx: TFrmscpbxx
  Left = 385
  Top = 203
  Width = 966
  Height = 603
  Caption = #29983#25104#25490#29677#20449#24687
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  WindowState = wsMaximized
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 523
    Width = 950
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btncreate: TButton
      Left = 46
      Top = 8
      Width = 105
      Height = 25
      Caption = #29983#25104#25490#29677#20449#24687
      TabOrder = 0
      OnClick = btncreateClick
    end
    object btndelete: TButton
      Left = 176
      Top = 8
      Width = 105
      Height = 25
      Caption = #21024#38500#25490#29677#20449#24687
      TabOrder = 1
      OnClick = btndeleteClick
    end
    object btnmodify: TButton
      Left = 312
      Top = 8
      Width = 97
      Height = 25
      Caption = #20462#25913#25490#29677#20449#24687
      TabOrder = 2
      OnClick = btnmodifyClick
    end
    object Button1: TButton
      Left = 816
      Top = 8
      Width = 75
      Height = 25
      Caption = #36864#20986
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 950
    Height = 482
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 950
      Height = 482
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
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      OnDrawColumnCell = DBGrid1DrawColumnCell
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 950
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label3: TLabel
      Left = 16
      Top = 20
      Width = 36
      Height = 13
      Caption = #31185#23460#65306
    end
    object Label2: TLabel
      Left = 403
      Top = 8
      Width = 12
      Height = 13
      Caption = #33267
    end
    object Label1: TLabel
      Left = 264
      Top = 16
      Width = 36
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
      OnChange = cmbdeptChange
      Items.Strings = (
        #65288#26032#38451#65289#35745#31639#26426#32593#32476#20013#24515
        #65288#21410#31481#65289#35745#31639#26426#32593#32476#20013#24515)
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
  end
  object DataSource1: TDataSource
    DataSet = cds
    Left = 248
    Top = 345
  end
  object cds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 360
    Top = 233
  end
  object dspro: TDataSetProvider
    Left = 392
    Top = 233
  end
  object cds1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 368
    Top = 321
  end
  object dspro1: TDataSetProvider
    Left = 400
    Top = 321
  end
end
