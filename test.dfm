object Form1: TForm1
  Left = 776
  Top = 351
  Width = 721
  Height = 455
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 160
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'select * from ryxx')
    Left = 160
    Top = 136
  end
end
