object FormBaseInfo: TFormBaseInfo
  Left = 721
  Top = 265
  Width = 473
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
    Width = 457
    Height = 428
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnlQuery: TPanel
      Left = 0
      Top = 0
      Width = 457
      Height = 40
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        457
        40)
      object btnquery: TButton
        Left = 345
        Top = 8
        Width = 50
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #26597#35810
        TabOrder = 0
        OnClick = btnqueryClick
      end
    end
    object pnlData: TPanel
      Left = 0
      Top = 40
      Width = 457
      Height = 348
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 457
        Height = 348
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
      Top = 388
      Width = 457
      Height = 40
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        457
        40)
      object btnnew: TButton
        Left = 20
        Top = 8
        Width = 50
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #26032#22686
        TabOrder = 0
        OnClick = btnnewClick
      end
      object btnmodify: TButton
        Left = 80
        Top = 8
        Width = 50
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #20462#25913
        TabOrder = 1
        OnClick = btnmodifyClick
      end
      object btndelete: TButton
        Left = 140
        Top = 8
        Width = 50
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #21024#38500
        TabOrder = 2
        OnClick = btndeleteClick
      end
      object btnclose: TButton
        Left = 200
        Top = 8
        Width = 50
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
