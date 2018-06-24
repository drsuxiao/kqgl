object FrmMain: TFrmMain
  Left = 523
  Top = 293
  Width = 1305
  Height = 730
  Caption = #32771#21220#31649#29702#31995#32479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 1048
    Top = 56
    Width = 209
    Height = 129
    TabOrder = 0
    Visible = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1289
    Height = 671
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
  end
  object MainMenu1: TMainMenu
    Left = 128
    Top = 112
    object N1: TMenuItem
      Caption = #22522#30784#35774#32622
      object N2: TMenuItem
        Action = actryxxwh
      end
      object N3: TMenuItem
        Action = actpbsxsz
      end
    end
    object N4: TMenuItem
      Caption = #25490#29677#31649#29702
      object N5: TMenuItem
        Action = actscpbxx
      end
      object N6: TMenuItem
        Action = actckpbxx
      end
    end
    object N8: TMenuItem
      Caption = #32771#21220#31649#29702
      object N7: TMenuItem
        Action = actkqdj
      end
    end
    object N9: TMenuItem
      Caption = #32479#35745#26597#35810
      object N10: TMenuItem
        Action = actqjflhz
      end
      object N11: TMenuItem
        Action = actzbcstj
      end
    end
    object N12: TMenuItem
      Caption = #25968#25454#24211#32500#25252
      object N13: TMenuItem
        Caption = #22791#20221
      end
      object N14: TMenuItem
        Caption = #36824#21407
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 168
    Top = 112
  end
  object DataSetCol: TADODataSet
    Parameters = <>
    Left = 248
    Top = 112
  end
  object DataSetTable: TADODataSet
    Parameters = <>
    Left = 208
    Top = 112
  end
  object DataSetValues: TADODataSet
    Parameters = <>
    Left = 280
    Top = 112
  end
  object ActionList1: TActionList
    Left = 128
    Top = 152
    object actryxxwh: TAction
      Caption = #20154#21592#20449#24687#32500#25252
      OnExecute = actryxxwhExecute
    end
    object actpbsxsz: TAction
      Caption = #25490#29677#39034#24207#35774#32622
      OnExecute = actpbsxszExecute
    end
    object actscpbxx: TAction
      Caption = #29983#25104#25490#29677#20449#24687
      OnExecute = actscpbxxExecute
    end
    object actckpbxx: TAction
      Caption = #26597#30475#25490#29677#20449#24687
      OnExecute = actckpbxxExecute
    end
    object actkqdj: TAction
      Caption = #32771#21220#30331#35760
      OnExecute = actkqdjExecute
    end
    object actqjflhz: TAction
      Caption = #35831#20551#20998#31867#27719#24635
      OnExecute = actqjflhzExecute
    end
    object actzbcstj: TAction
      Caption = #20540#29677#27425#25968#32479#35745
      OnExecute = actzbcstjExecute
    end
    object actbackup: TAction
      Caption = #22791#20221
      OnExecute = actbackupExecute
    end
    object actrestore: TAction
      Caption = #36824#21407
      OnExecute = actrestoreExecute
    end
  end
end
