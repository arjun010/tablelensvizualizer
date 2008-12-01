unit MainFormUnit;

interface

uses
  Logger,
  CSVFileLoader,
  TableData,
  LensTableControl,
  ComCtrls,
  ExtCtrls,
  Grids,
  Menus,
  SysUtils,
  Controls,
  Forms,
  Dialogs,
  Classes, StdCtrls, Buttons, ImgList;

type
  TMainForm = class(TForm)
    GridHeader: THeaderControl;
    GridImage: TPaintBox;
    GridContainer: TPanel;
    MainMenu: TMainMenu;
    itmFile: TMenuItem;
    itmLoadFromFile: TMenuItem;
    itmLoadFromDB: TMenuItem;
    StatusBar: TStatusBar;
    PageControl: TPageControl;
    TabLensTable: TTabSheet;
    TabStringGrid: TTabSheet;
    StringGrid1: TStringGrid;
    ControlBar1: TControlBar;
    btnLoad: TBitBtn;
    btnFillGrid: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    HeaderImages: TImageList;
    ViewZoomBar: TTrackBar;
    procedure FormCreate(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnFillGridClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ViewZoomBarChange(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    TableData:TDataTable;
    FileLoader:TCSVFileLoader;
    Logger:TLogger;
    TableLensControl:TLensTableControl;

    procedure FillStringGrid(Grid: TStringGrid; Data: TDataTable);
    procedure LoadFile(fname: string);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FillStringGrid(Grid: TStringGrid; Data: TDataTable);
const Precision=100000;
var Row, Col: Integer;
begin
StatusBar.SimpleText:='Строк данных: '+IntToStr(Data.getRowCount);

Grid.RowCount:=1+Data.getRowCount();
Grid.ColCount:=Data.getColCount();

for Col:=0 to Data.getColCount-1 do
  Grid.Cells[Col, 0]:=Data.getColumnInfo(Col).Title;

for Row:=0 to Data.getRowCount()-1 do
  for Col:=0 to Data.getColCount-1 do
    if data.getColumnInfo(Col).Cardinality<>1 then
    Grid.Cells[Col, Row+1]:=''
      +Data.getByRC(Row, Col).OriginalValue
      //+' '+FloatToStr(Data.getByRC(Row, Col).NumericValue)
      +' '+FloatToStr(Round(Precision*Data.getByRC(Row, Col).VisualValue)/Precision)
      ;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Logger:=TLogger.Create(Application.ExeName);

  FileLoader:=TCSVFileLoader.Create;

  TableData:=TDataTable.create(Logger);

  TableLensControl:=TLensTableControl.Create(GridImage, GridHeader, TableData);
end;

procedure TMainForm.btnFillGridClick(Sender: TObject);
begin
  FillStringGrid(StringGrid1, TableData);
end;

procedure TMainForm.LoadFile(fname: string);
begin
  fname:=ExtractFilePath(Application.ExeName)+'..\TestData\'+fname;
  if not FileExists(fname) then
    raise Exception.Create('File not found: '+fname);

  try
   FileLoader.Load(Fname, TableData);
  except
    on e:EOutOfMemory do ShowMessage('Файл слишком велик');
  end;

  TableData.analyzeColumnTypes;
  TableData.analyzeColumnsPass1;
  TableData.analyzeColumnsPass2;

  //btnFillGrid.Click;

  TableLensControl.PrepareLensTable;
end;

procedure TMainForm.btnLoadClick(Sender: TObject);
begin
  LoadFile('test 20.csv');
end;

procedure TMainForm.BitBtn1Click(Sender: TObject);
begin
  LoadFile('test 1000.csv');
end;

procedure TMainForm.BitBtn2Click(Sender: TObject);
begin
  LoadFile('test 10 000.csv');
end;

procedure TMainForm.BitBtn3Click(Sender: TObject);
begin
  LoadFile('test perfdata.csv');
end;

procedure TMainForm.ViewZoomBarChange(Sender: TObject);
begin
TableLensControl.setViewPercent(ViewZoomBar.Position);
//TrackBar1.SelStart:=(TrackBar1.Position);
//TrackBar1.SelEnd:=(TrackBar1.Max);
end;

procedure TMainForm.BitBtn4Click(Sender: TObject);
begin
  LoadFile('allcolumns.csv');
end;

end.
