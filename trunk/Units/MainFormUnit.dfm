object MainForm: TMainForm
  Left = 196
  Top = 347
  AutoScroll = False
  Caption = 'MainForm'
  ClientHeight = 305
  ClientWidth = 717
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 286
    Width = 717
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object PageControl: TPageControl
    Left = 85
    Top = 0
    Width = 632
    Height = 286
    ActivePage = TabLensTable
    Align = alClient
    HotTrack = True
    TabOrder = 1
    object TabLensTable: TTabSheet
      Caption = 'TabLensTable'
      object GridContainer: TPanel
        Left = 0
        Top = 0
        Width = 624
        Height = 258
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvNone
        TabOrder = 0
        object GridImage: TPaintBox
          Left = 1
          Top = 18
          Width = 622
          Height = 239
          Align = alClient
        end
        object GridHeader: THeaderControl
          Left = 1
          Top = 1
          Width = 622
          Height = 17
          FullDrag = False
          HotTrack = True
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
        Width = 624
        Height = 258
        Align = alClient
        ColCount = 1
        DefaultColWidth = 75
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goColMoving, goRowSelect]
        TabOrder = 0
      end
    end
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 85
    Height = 286
    Align = alLeft
    AutoSize = True
    TabOrder = 2
    object btnLoad: TBitBtn
      Left = 11
      Top = 2
      Width = 68
      Height = 22
      Caption = 'Load 20'
      TabOrder = 0
      OnClick = btnLoadClick
    end
    object btnFillGrid: TBitBtn
      Left = 11
      Top = 106
      Width = 68
      Height = 22
      Caption = 'btnFillGrid'
      TabOrder = 1
      OnClick = btnFillGridClick
    end
    object BitBtn1: TBitBtn
      Left = 11
      Top = 28
      Width = 68
      Height = 22
      Caption = 'Load 1000'
      TabOrder = 2
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 11
      Top = 54
      Width = 68
      Height = 22
      Caption = 'Load 10 000'
      TabOrder = 3
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 11
      Top = 80
      Width = 68
      Height = 22
      Caption = 'Load PerfData'
      TabOrder = 4
      OnClick = BitBtn3Click
    end
  end
  object MainMenu: TMainMenu
    Left = 150
    Top = 70
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
