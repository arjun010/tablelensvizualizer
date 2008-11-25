unit MainFormUnit;

interface

uses
  Logger,
  CSVFileLoader,
  TableData,
  ComCtrls,
  ExtCtrls,
  Grids,
  Menus,
  SysUtils,
  Controls,
  Forms,
  Dialogs,
  Classes, StdCtrls, Buttons;

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
    procedure FormCreate(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnFillGridClick(Sender: TObject);
  private
    TableData:TDataTable;
    FileLoader:TCSVFileLoader;
    Logger:TLogger;

    procedure FillStringGrid(Grid: TStringGrid; Data: TDataTable);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FillStringGrid(Grid: TStringGrid; Data: TDataTable);
var Row, Col: Integer;
begin
StatusBar.SimpleText:='����� ������: '+IntToStr(Data.getRowCount);

Grid.RowCount:=1+Data.getRowCount();
Grid.ColCount:=Data.getColCount();

for Col:=0 to Data.getColCount-1 do
  Grid.Cells[Col, 0]:=Data.getColumnInfo(Col).Title;

for Row:=0 to Data.getRowCount()-1 do
  for Col:=0 to Data.getColCount-1 do
    Grid.Cells[Col, Row+1]:=Data.getByRC(Row, Col).OriginalValue
      +' / '+FloatToStr(Data.getByRC(Row, Col).NumericValue)
      //+' / '+FloatToStr(Data.getByRC(Row, Col).VisualValue)
      ;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Logger:=TLogger.Create(Application.ExeName);

  TableData:=TDataTable.create(Logger);
  FileLoader:=TCSVFileLoader.Create;
end;

procedure TMainForm.btnLoadClick(Sender: TObject);
var
  Fname:String;
begin
  fname:=ExtractFilePath(Application.ExeName)+'\test perfdata.csv';

  try
   FileLoader.Load(Fname, TableData);
  except
    on e:EOutOfMemory do ShowMessage('���� ������� �����');
  end;

  TableData.analyzeColumnTypes;
  TableData.analyzeColumnsPass1;
  TableData.analyzeColumnsPass2;
end;

procedure TMainForm.btnFillGridClick(Sender: TObject);
begin
  FillStringGrid(StringGrid1, TableData);
end;

end.