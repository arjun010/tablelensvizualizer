unit OpenData;

interface

uses
  CommonTypes,
  CSVFileLoader,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Grids, TableData;

const
  PREVIEW_LIMIT=10;

type
  TfrmOpenData = class(TForm)
    pcLoadMethods: TPageControl;
    tabOpenCSV: TTabSheet;
    edFileName: TEdit;
    pnlCSVControls: TPanel;
    pnlCSVSteps: TPanel;
    btnBrowse: TButton;
    pnlConfirm: TPanel;
    btnLoad: TButton;
    btnCancel: TButton;
    PreviewGrid: TStringGrid;
    grpPreview: TGroupBox;
    lblPreview: TLabel;
    lblFile: TLabel;
    grpParseOptions: TGroupBox;
    lblOptions: TLabel;
    lblFilePath: TLabel;
    cbHeaders: TCheckBox;
    rbTab: TRadioButton;
    rbComma: TRadioButton;
    rbSemicolon: TRadioButton;
    lblSeparator: TLabel;
    dlgOpenCSV: TOpenDialog;
    procedure btnBrowseClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edFileNameChange(Sender: TObject);
    procedure rbTabClick(Sender: TObject);
    procedure cbHeadersClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    PreviewDataTable: TDataTable;
    CSVFileLoader:TCSVFileLoader;
    { Private declarations }
    procedure previewCSVInitialLoad;
    procedure previewCSVOptionsChangedLoad;
    procedure refreshPreviewTable;
    procedure GuessCSVSeparator;
  public
    { Public declarations }
  end;

implementation
uses MainFormUnit;
{$R *.dfm}

procedure TfrmOpenData.btnBrowseClick(Sender: TObject);
begin
if dlgOpenCSV.Execute then
  begin
  edFileName.Text:=dlgOpenCSV.FileName;
  end;
end;

procedure TfrmOpenData.btnCancelClick(Sender: TObject);
begin
Close;
end;

procedure TfrmOpenData.edFileNameChange(Sender: TObject);
begin
previewCSVInitialLoad;
end;

procedure TfrmOpenData.rbTabClick(Sender: TObject);
begin
previewCSVOptionsChangedLoad;
end;

procedure TfrmOpenData.cbHeadersClick(Sender: TObject);
begin
previewCSVOptionsChangedLoad;
end;

procedure TfrmOpenData.previewCSVInitialLoad;
begin
GuessCSVSeparator;
previewCSVOptionsChangedLoad;
end;

procedure TfrmOpenData.previewCSVOptionsChangedLoad;
begin
PreviewDataTable.Clear;

if rbTab.Checked then CSVFileLoader.setSeparator(sepTab);
if rbComma.Checked then CSVFileLoader.setSeparator(sepComma);
if rbSemicolon.Checked then CSVFileLoader.setSeparator(sepSemicolon);

CSVFileLoader.setHeaderLine(cbHeaders.Checked);

if FileExists(edFileName.Text) then
  CSVFileLoader.LoadWithLimit(edFileName.Text, PreviewDataTable, PREVIEW_LIMIT);

RefreshPreviewTable;
end;

procedure TfrmOpenData.btnLoadClick(Sender: TObject);
begin
  if not FileExists(edFileName.Text) then
    raise Exception.Create('File not found: '+edFileName.Text);

CSVFileLoader.Load(edFileName.Text, MainForm.getDataTable);

close;

MainForm.StartLensTable;
end;

procedure TfrmOpenData.FormCreate(Sender: TObject);
begin
PreviewDataTable:=TDataTable.Create;
CSVFileLoader:=TCSVFileLoader.Create;
end;

procedure TfrmOpenData.refreshPreviewTable;
var RowIndex: TRowIndex;
  ColIndex: TColIndex;
  Cell: PDataCell;
begin
btnLoad.Enabled:=false;
PreviewGrid.ColCount:=1;
PreviewGrid.RowCount:=2;
PreviewGrid.Rows[0].Clear;
PreviewGrid.Rows[1].Clear;

// fill header line
if PreviewDataTable.getColCount<1 then
  exit;
PreviewGrid.ColCount:=PreviewDataTable.getColCount;
PreviewGrid.DefaultColWidth:=(PreviewGrid.Width-30) div PreviewGrid.ColCount;
for ColIndex:=0 to PreviewDataTable.getColCount-1 do
  PreviewGrid.Cells[ColIndex, 0]:=PreviewDataTable.getColumnInfo(ColIndex).Title;

// fill rows
if PreviewDataTable.getRowCount<1 then
  exit;
PreviewGrid.RowCount:=PreviewDataTable.getRowCount+1;
for RowIndex:=0 to PreviewDataTable.getRowCount-1 do
  for ColIndex:=0 to PreviewGrid.ColCount-1 do
    begin
    Cell:=PreviewDataTable.getByRC(RowIndex, ColIndex);
    PreviewGrid.Cells[ColIndex, RowIndex+1]:=Cell.OriginalValue;
    end;

btnLoad.Enabled:=true;
end;

procedure TfrmOpenData.GuessCSVSeparator;
var GuessedSeparator: TCSVSeparator;
begin
GuessedSeparator:=CSVFileLoader.GuessSeparator(edFileName.Text, PREVIEW_LIMIT);

case GuessedSeparator of
  sepTab: rbTab.Checked:=true;
  sepComma: rbComma.Checked:=true;
  sepSemicolon: rbSemicolon.Checked:=true;
end; // case

end;

end.
