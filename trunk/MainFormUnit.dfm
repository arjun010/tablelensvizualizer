object MainForm: TMainForm
  Left = 192
  Top = 107
  Width = 870
  Height = 500
  Caption = 'MainForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 435
    Width = 862
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 862
    Height = 435
    ActivePage = TabStringGrid
    Align = alClient
    HotTrack = True
    TabOrder = 1
    object TabLensTable: TTabSheet
      Caption = 'TabLensTable'
      object GridContainer: TPanel
        Left = 0
        Top = 0
        Width = 854
        Height = 407
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvNone
        TabOrder = 0
        object GridImage: TPaintBox
          Left = 1
          Top = 18
          Width = 852
          Height = 388
          Align = alClient
        end
        object GridHeader: THeaderControl
          Left = 1
          Top = 1
          Width = 852
          Height = 17
          Sections = <>
        end
      end
    end
    object TabStringGrid: TTabSheet
      Caption = 'TabStringGrid'
      ImageIndex = 1
      object StringGrid1: TStringGrid
        Left = 0
        Top = 0
        Width = 854
        Height = 407
        Align = alClient
        ColCount = 1
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goColMoving, goRowSelect]
        TabOrder = 0
      end
    end
  end
  object MainMenu: TMainMenu
    Left = 40
    Top = 72
    object itmFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object itmLoadFromFile: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1090#1077#1082#1089#1090#1086#1074#1086#1075#1086' '#1092#1072#1081#1083#1072'...'
      end
      object itmLoadFromDB: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093'...'
      end
    end
  end
end