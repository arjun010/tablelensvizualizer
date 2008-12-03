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
    rbDotComma: TRadioButton;
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
  public
    procedure setDataTable(DataTable: TDataTable);
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

previewCSVOptionsChangedLoad;
end;

procedure TfrmOpenData.previewCSVOptionsChangedLoad;
begin
PreviewDataTable.Clear;

if rbTab.Checked then CSVFileLoader.setSeparator(sepTab);
if rbComma.Checked then CSVFileLoader.setSeparator(sepComma);
if rbDotComma.Checked then CSVFileLoader.setSeparator(sepDotComma);

CSVFileLoader.setHeaderLine(cbHeaders.Checked);

CSVFileLoader.LoadWithLimit(edFileName.Text, PreviewDataTable, PREVIEW_LIMIT);

RefreshPreviewTable;
end;

procedure TfrmOpenData.btnLoadClick(Sender: TObject);
begin
close;
(Parent as TMainForm).LoadCSVFile(edFileName.Text);
end;

procedure TfrmOpenData.FormCreate(Sender: TObject);
begin
//PreviewDataTable:=TDataTable.Create;
CSVFileLoader:=TCSVFileLoader.Create;
end;

procedure TfrmOpenData.refreshPreviewTable;
var RowIndex: TRowIndex;
  ColIndex: TColIndex;
begin
btnLoad.Enabled:=false;
PreviewGrid.ColCount:=1;
PreviewGrid.RowCount:=2;
PreviewGrid.Rows[1].Clear;
PreviewGrid.Rows[2].Clear;

// fill header line
if PreviewDataTable.getColCount<1 then
  exit;
PreviewGrid.ColCount:=PreviewDataTable.getColCount;

// fill rows
if PreviewDataTable.getRowCount<1 then
  exit;
PreviewGrid.RowCount:=PreviewDataTable.getRowCount+1;
for RowIndex:=0 to PreviewDataTable.getRowCount-1 do
  for ColIndex:=0 to PreviewGrid.ColCount-1 do
    begin
    PreviewGrid.Cells[ColIndex, RowIndex+1]:=PreviewDataTable.getByRC(RowIndex, ColIndex).OriginalValue;
    end;

btnLoad.Enabled:=true;
end;

procedure TfrmOpenData.setDataTable(DataTable: TDataTable);
begin
PreviewDataTable:=DataTable;
end;

end.
