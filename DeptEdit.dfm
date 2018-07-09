object FormDeptedit: TFormDeptedit
  Left = 500
  Top = 244
  Width = 293
  Height = 244
  Caption = 'FormDeptedit'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 277
    Height = 166
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 40
      Top = 35
      Width = 70
      Height = 13
      Caption = #31185#23460#32534#30721#65306
    end
    object Label2: TLabel
      Left = 40
      Top = 75
      Width = 70
      Height = 13
      Caption = #31185#23460#21517#31216#65306
    end
    object Label3: TLabel
      Left = 40
      Top = 115
      Width = 70
      Height = 13
      Caption = #31185#23460#31867#22411#65306
    end
    object deptcode: TEdit
      Left = 104
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object deptname: TEdit
      Left = 104
      Top = 72
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object depttype: TEdit
      Left = 104
      Top = 112
      Width = 121
      Height = 21
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 166
    Width = 277
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btsave: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Caption = #20445#23384
      ModalResult = 1
      TabOrder = 0
    end
    object btcancle: TButton
      Left = 176
      Top = 8
      Width = 75
      Height = 25
      Caption = #21462#28040
      ModalResult = 2
      TabOrder = 1
    end
  end
end
