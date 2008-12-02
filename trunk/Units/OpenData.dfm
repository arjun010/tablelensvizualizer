object frmOpenData: TfrmOpenData
  Left = 240
  Top = 267
  Width = 768
  Height = 548
  BorderStyle = bsSizeToolWin
  Caption = 'frmOpenData'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 760
    Height = 480
    ActivePage = tabOpenCSV
    Align = alClient
    TabOrder = 0
    object tabOpenCSV: TTabSheet
      Caption = 'tabOpenCSV'
      object Panel1: TPanel
        Left = 160
        Top = 0
        Width = 592
        Height = 452
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          592
          452)
        object Label4: TLabel
          Left = 10
          Top = 18
          Width = 46
          Height = 13
          Caption = 'CSV File: '
        end
        object Edit1: TEdit
          Left = 60
          Top = 14
          Width = 437
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
        object Button1: TButton
          Left = 506
          Top = 12
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Browse...'
          TabOrder = 1
        end
        object GroupBox1: TGroupBox
          Left = 0
          Top = 170
          Width = 592
          Height = 282
          Align = alBottom
          Caption = ' Preview '
          TabOrder = 2
          object StringGrid1: TStringGrid
            Left = 2
            Top = 15
            Width = 588
            Height = 265
            Align = alClient
            ColCount = 10
            DefaultRowHeight = 18
            FixedCols = 0
            RowCount = 11
            TabOrder = 0
          end
        end
        object GroupBox2: TGroupBox
          Left = 0
          Top = 48
          Width = 592
          Height = 109
          Anchors = [akLeft, akTop, akRight]
          Caption = ' Parsing Options '
          TabOrder = 3
          object Label5: TLabel
            Left = 16
            Top = 22
            Width = 46
            Height = 13
            Caption = 'Separator'
          end
          object CheckBox1: TCheckBox
            Left = 146
            Top = 22
            Width = 183
            Height = 17
            Caption = 'First line contains column headers'
            Checked = True
            State = cbChecked
            TabOrder = 0
          end
          object RadioButton1: TRadioButton
            Left = 40
            Top = 38
            Width = 113
            Height = 17
            Caption = 'Tab'
            Checked = True
            TabOrder = 1
            TabStop = True
          end
          object RadioButton2: TRadioButton
            Left = 40
            Top = 78
            Width = 113
            Height = 17
            Caption = 'Comma'
            TabOrder = 2
          end
          object RadioButton3: TRadioButton
            Left = 40
            Top = 58
            Width = 113
            Height = 17
            Caption = 'Dot-Comma'
            TabOrder = 3
          end
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 160
        Height = 452
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object Label1: TLabel
          Left = 8
          Top = 174
          Width = 90
          Height = 13
          Caption = '3. Preview data'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 8
          Top = 18
          Width = 79
          Height = 13
          Caption = '1. Choose file'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 8
          Top = 52
          Width = 141
          Height = 13
          Caption = '2. Adjust parsing options'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    object tabOpenExcel: TTabSheet
      Caption = 'tabOpenExcel'
      ImageIndex = 1
    end
    object tabSQLServer: TTabSheet
      Caption = 'tabSQLServer'
      ImageIndex = 2
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 480
    Width = 760
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Button2: TButton
      Left = 594
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Load'
      Default = True
      TabOrder = 0
    end
    object Button3: TButton
      Left = 680
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 1
    end
  end
end
