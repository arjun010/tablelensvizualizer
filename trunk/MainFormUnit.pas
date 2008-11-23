unit MainFormUnit;

interface

uses
  CSVFileLoader,
  TableData,
  ComCtrls,
  ExtCtrls,
  Grids,
  Menus,
  SysUtils,
  Controls,
  Forms,
  Classes;

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
    procedure FormCreate(Sender: TObject);
  private
    procedure FillStringGrid(Grid: TStringGrid; Data: TTableData);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  TableData:TTableData;
  FileLoader:TCSVFileLoader;

implementation

{$R *.dfm}

procedure TMainForm.FillStringGrid(Grid: TStringGrid; Data: TTableData);
var Row, Col: word;
begin
StatusBar.SimpleText:='Строк данных: '+IntToStr(1+Data.getRowCount);
Grid.RowCount:=1+Data.getRowCount();
Grid.ColCount:=1+Data.getColCount();
for Row:=0 to Data.getRowCount()-1 do
  for Col:=0 to Data.getColCount-1 do
    Grid.Cells[Col, Row]:=Data.getByRC(Row, Col);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  Fname:String;
begin
TableData:=TTableData.create();
FileLoader:=TCSVFileLoader.Create();


fname:=ExtractFilePath(Application.ExeName)+'\test1.csv';
FileLoader.Load(Fname, TableData);

FillStringGrid(StringGrid1, TableData);
end;

end.
