object Frmryxx: TFrmryxx
  Left = 751
  Top = 200
  Width = 393
  Height = 493
  Caption = #20154#21592#20449#24687#32500#25252
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
    Top = 0
    Width = 377
    Height = 454
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 377
      Height = 49
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 60
        Height = 13
        Caption = #24037#36164#32534#21495#65306
      end
      object btnquery: TButton
        Left = 224
        Top = 16
        Width = 57
        Height = 25
        Caption = #26597#35810
        TabOrder = 0
        OnClick = btnqueryClick
      end
      object Edit1: TEdit
        Left = 72
        Top = 16
        Width = 121
        Height = 21
        TabOrder = 1
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 49
      Width = 377
      Height = 367
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 377
        Height = 367
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
    object Panel4: TPanel
      Left = 0
      Top = 416
      Width = 377
      Height = 38
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object btnnew: TButton
        Left = 16
        Top = 8
        Width = 49
        Height = 25
        Caption = #26032#22686
        TabOrder = 0
        OnClick = btnnewClick
      end
      object btnmodify: TButton
        Left = 72
        Top = 8
        Width = 49
        Height = 25
        Caption = #20462#25913
        TabOrder = 1
        OnClick = btnmodifyClick
      end
      object btndelete: TButton
        Left = 128
        Top = 8
        Width = 49
        Height = 25
        Caption = #21024#38500
        TabOrder = 2
        OnClick = btndeleteClick
      end
      object btnclose: TButton
        Left = 221
        Top = 8
        Width = 52
        Height = 25
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
