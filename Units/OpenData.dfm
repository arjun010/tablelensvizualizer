object frmOpenData: TfrmOpenData
  Left = 276
  Top = 262
  Width = 663
  Height = 440
  BorderStyle = bsSizeToolWin
  Caption = 'Open table data from...'
  Color = clBtnFace
  Constraints.MaxHeight = 440
  Constraints.MinHeight = 440
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pcLoadMethods: TPageControl
    Left = 0
    Top = 0
    Width = 655
    Height = 372
    ActivePage = tabOpenCSV
    Align = alClient
    MultiLine = True
    TabOrder = 0
    object tabOpenCSV: TTabSheet
      Caption = 'Text File'
      object pnlCSVControls: TPanel
        Left = 160
        Top = 0
        Width = 487
        Height = 344
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          487
          344)
        object lblFilePath: TLabel
          Left = 10
          Top = 18
          Width = 47
          Height = 13
          Caption = 'File Path: '
        end
        object edFileName: TEdit
          Left = 60
          Top = 14
          Width = 332
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnChange = edFileNameChange
        end
        object btnBrowse: TButton
          Left = 401
          Top = 12
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Browse...'
          TabOrder = 1
          OnClick = btnBrowseClick
        end
        object grpPreview: TGroupBox
          Left = 0
          Top = 172
          Width = 487
          Height = 172
          Align = alBottom
          Caption = ' Preview '
          TabOrder = 2
          object PreviewGrid: TStringGrid
            Left = 2
            Top = 15
            Width = 483
            Height = 155
            Align = alClient
            ColCount = 1
            DefaultRowHeight = 18
            FixedCols = 0
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
            TabOrder = 0
          end
        end
        object grpParseOptions: TGroupBox
          Left = 0
          Top = 48
          Width = 487
          Height = 109
          Anchors = [akLeft, akTop, akRight]
          Caption = ' Parsing Options '
          TabOrder = 3
          object lblSeparator: TLabel
            Left = 16
            Top = 22
            Width = 46
            Height = 13
            Caption = 'Separator'
          end
          object cbHeaders: TCheckBox
            Left = 146
            Top = 22
            Width = 183
            Height = 17
            Caption = 'First line contains column headers'
            TabOrder = 0
            OnClick = cbHeadersClick
          end
          object rbTab: TRadioButton
            Left = 38
            Top = 78
            Width = 113
            Height = 17
            Caption = 'Tab'
            TabOrder = 1
            OnClick = rbTabClick
          end
          object rbComma: TRadioButton
            Left = 38
            Top = 38
            Width = 113
            Height = 17
            Caption = 'Comma'
            Checked = True
            TabOrder = 2
            TabStop = True
            OnClick = rbTabClick
          end
          object rbDotComma: TRadioButton
            Left = 38
            Top = 58
            Width = 113
            Height = 17
            Caption = 'Dot-Comma'
            TabOrder = 3
            OnClick = rbTabClick
          end
        end
      end
      object pnlCSVSteps: TPanel
        Left = 0
        Top = 0
        Width = 160
        Height = 344
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object lblPreview: TLabel
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
        object lblFile: TLabel
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
        object lblOptions: TLabel
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
  end
  object pnlConfirm: TPanel
    Left = 0
    Top = 372
    Width = 655
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      655
      41)
    object btnLoad: TButton
      Left = 482
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Load'
      Default = True
      Enabled = False
      TabOrder = 0
      OnClick = btnLoadClick
    end
    object btnCancel: TButton
      Left = 572
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object dlgOpenCSV: TOpenDialog
    Filter = '*.tsv, *.csv, *.txt|*.tsv; *.csv; *.txt|All|*.*'
    Left = 294
    Top = 34
  end
end
