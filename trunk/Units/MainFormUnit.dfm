object MainForm: TMainForm
  Left = 277
  Top = 257
  AutoScroll = False
  Caption = 'MainForm'
  ClientHeight = 470
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
    Top = 451
    Width = 717
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object GridContainer: TPanel
    Left = 0
    Top = 0
    Width = 717
    Height = 451
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 1
    object GridImage: TPaintBox
      Left = 1
      Top = 20
      Width = 685
      Height = 430
      Align = alClient
    end
    object GridHeader: THeaderControl
      Left = 1
      Top = 1
      Width = 715
      Height = 19
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Images = HeaderImages
      Sections = <>
      ParentFont = False
    end
    object ViewZoomBar: TTrackBar
      Left = 686
      Top = 20
      Width = 30
      Height = 430
      Align = alRight
      Max = 100
      Min = 1
      Orientation = trVertical
      PageSize = 10
      Frequency = 10
      Position = 100
      TabOrder = 1
      ThumbLength = 10
      TickMarks = tmBoth
    end
  end
  object MainMenu: TMainMenu
    Left = 102
    Top = 30
    object itmFile: TMenuItem
      Caption = 'File'
      object itmLoadData: TMenuItem
        Caption = 'Load data...'
        ShortCut = 16463
        OnClick = itmLoadDataClick
      end
      object itmExit: TMenuItem
        Caption = 'Exit'
        ShortCut = 32883
      end
    end
    object itmHelp: TMenuItem
      Caption = 'Help'
      Visible = False
      object Onlinehelp1: TMenuItem
        Caption = 'Online help'
        Visible = False
      end
      object About1: TMenuItem
        Caption = 'About...'
        Visible = False
      end
    end
  end
  object HeaderImages: TImageList
    Left = 139
    Top = 30
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001670100016701000187
      01000199010009A112001AB2340000000000A9480F00A94C0F00AC4D0B00B252
      0C00B2510D000000000000000000000000000000000001800100019901000000
      00000000000000000000000000000000000000000000FFF1D300EE911700FFEF
      CF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001800100019001000199
      010011A9230027BF4D0034CC670000000000AA4E0300D4740F00D7781400DE8B
      3200C76B1A0000000000000000000000000000000000019901001AB234000000
      000000000000000000000000000000000000FFF1D100EE8C0D00FABD7900F595
      0B00FFF0CD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B0560700D7781400D57A1E00E093
      4700CA6F1C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFEDCD00E9870C00E8AE7400FAC49500FAC3
      8900F5940B00FFF1C90000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001670100018701000199
      01000DA51A0027BF4D000000000000000000B35A0900D57A1E00D9822800E29B
      5100D07721000000000000000000000000000000000001670100018701000190
      01000000000000000000FFEBCB00E7840D00D69C6300F6B87D00F4B87A00F6C0
      8C00F9C28D00F4900D00FFEEC600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001900100019901001AB2
      340027BF4D0034CC67000000000000000000B8610D00D9822800DD8A3400E6A1
      5F00D57E24000000000000000000000000000000000001870100019901000DA5
      1A000000000000000000E47F0B00D67F1800C8813000E2A56A00F1AF6E00F5C6
      9800EF9D3E00EF901E00F18B0800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C16C1300DD8A3400E1924100E9AA
      6C00DB8328000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D3770E00DF9F6000EDA86300F3C0
      8F00EA8F1E000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001670100018701000199
      01000DA51A00000000000000000000000000C7731700E1924100E5994C00EDB1
      7800E08A2A000000000000000000000000000000000001670100018701000199
      01000DA51A00000000000000000000000000CA700E00DC985500E9A05600EFBA
      8600E58A22000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001900100019901001AB2
      340027BF4D00000000000000000000000000C7731700E59F5700EAA15700EFB7
      8300E6902D000000000000000000000000000000000001900100019901001AB2
      340027BF4D00000000000000000000000000C16C1300DD8A3400E4984B00EDB3
      7B00DF831E000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CD781800E9A56400ECA96300F3C1
      8F00EC952C000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B8610D00D9822800E2913E00EAAC
      7100D97D1E000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001670100018701000190
      01000000000000000000E3821100D9852800CD812C00ECAC6E00F0B07100F3BA
      8100F6A64200F5A33C00F9981300000000000000000001670100018701000199
      01000DA51A0027BF4D000000000000000000B35A0900D57A1E00DD883300E6A5
      6400D3781B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001870100019901000DA5
      1A000000000000000000FFECCE00F4951700F3B47500F3B77D00F4B87C00F7C1
      8D00FBD3AE00FEA21F00FFF1D200000000000000000001900100019901001AB2
      340027BF4D0034CC67000000000000000000B0560700D7781400D9822800E49E
      5800CE7017000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFF0D500FA9B1500F6BC8000F9CA9D00FDD2
      A600FEA61D00FFF4D90000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AA4E0300D4740F00D5781B00E097
      4A00C86A15000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001800100019901000000
      000000000000000000000000000000000000FFF5DC00FDA21700FDC88800FEAA
      2200FFF7E0000000000000000000000000000000000001670100016701000180
      0100018D01000194010009A1120000000000AC4C0200D37B1900DC893000E6A3
      5B00C36311000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000019901001AB234000000
      00000000000000000000000000000000000000000000FFF5E100FDAE3B00FFF5
      E40000000000000000000000000000000000000000000167010001860100018D
      01000199010011A923001AB2340000000000A7460900AB480900AC460600AE48
      0600AF4D08000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF0000000081079F8F00000000
      81079F0700000000FF07FE030000000083078C010000000083078C0100000000
      FF07FF070000000087078707000000008707870700000000FF07FF0700000000
      8C018307000000008C01830700000000FE03FF07000000009F07810700000000
      9F8F810700000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
