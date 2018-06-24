object FormBaseInfo: TFormBaseInfo
  Left = 930
  Top = 227
  Width = 577
  Height = 467
  Caption = #22522#30784#20449#24687#32500#25252#31383#20307
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
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 561
    Height = 428
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnlQuery: TPanel
      Left = 0
      Top = 0
      Width = 561
      Height = 49
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        561
        49)
      object btnquery: TButton
        Left = 449
        Top = 16
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #26597#35810
        TabOrder = 0
        OnClick = btnqueryClick
      end
    end
    object pnlData: TPanel
      Left = 0
      Top = 49
      Width = 561
      Height = 341
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 561
        Height = 341
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
    object pnlFunction: TPanel
      Left = 0
      Top = 390
      Width = 561
      Height = 38
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        561
        38)
      object btnnew: TButton
        Left = 188
        Top = 8
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #26032#22686
        TabOrder = 0
        OnClick = btnnewClick
      end
      object btnmodify: TButton
        Left = 276
        Top = 8
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #20462#25913
        TabOrder = 1
        OnClick = btnmodifyClick
      end
      object btndelete: TButton
        Left = 364
        Top = 8
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #21024#38500
        TabOrder = 2
        OnClick = btndeleteClick
      end
      object btnclose: TButton
        Left = 458
        Top = 8
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #36864#20986
        TabOrder = 3
        OnClick = btncloseClick
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = cds
    Left = 288
    Top = 192
  end
  object cds: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 320
    Top = 193
  end
  object dspro: TDataSetProvider
    Left = 352
    Top = 193
  end
end
