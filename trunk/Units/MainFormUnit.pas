unit MainFormUnit;

interface

uses
  OpenData,
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
    MainMenu: TMainMenu;
    itmFile: TMenuItem;
    itmLoadData: TMenuItem;
    StatusBar: TStatusBar;
    HeaderImages: TImageList;
    itmExit: TMenuItem;
    itmHelp: TMenuItem;
    Onlinehelp1: TMenuItem;
    About1: TMenuItem;
    GridContainer: TPanel;
    GridImage: TPaintBox;
    GridHeader: THeaderControl;
    ViewZoomBar: TTrackBar;
    procedure FormCreate(Sender: TObject);
    procedure itmLoadDataClick(Sender: TObject);
  private
    TableData:TDataTable;
    FileLoader:TCSVFileLoader;
    Logger:TLogger;
    TableLensControl:TLensTableControl;
    OpenForm: TfrmOpenData;

    procedure LoadCSVFile(fname: string);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Logger:=TLogger.Create(Application.ExeName);

  FileLoader:=TCSVFileLoader.Create;

  TableData:=TDataTable.create(Logger);

  TableLensControl:=TLensTableControl.Create(GridImage, GridHeader, ViewZoomBar, TableData);
end;

procedure TMainForm.LoadCSVFile(fname: string);
begin
  fname:=ExtractFilePath(Application.ExeName)+'..\TestData\'+fname;
  if not FileExists(fname) then
    raise Exception.Create('File not found: '+fname);

  try
   FileLoader.Load(Fname, TableData);
  except
    on e:EOutOfMemory do ShowMessage('Файл слишком велик');
  end;

  TableData.analyzeColumns;
  TableLensControl.PrepareLensTable;
end;

procedure TMainForm.itmLoadDataClick(Sender: TObject);
begin
if OpenForm=nil then
 OpenForm:=TfrmOpenData.Create(Self);
OpenForm.Show;
end;

end.
