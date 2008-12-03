unit MainFormUnit;

interface

uses
  OpenData,
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
    TableData: TDataTable;
    FileLoader:TCSVFileLoader;
    TableLensControl:TLensTableControl;
    OpenForm: TfrmOpenData;
    { Private declarations }
  public
    procedure LoadCSVFile(fname: string);
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FileLoader:=TCSVFileLoader.Create;

  TableData:=TDataTable.create;

  TableLensControl:=TLensTableControl.Create(GridImage, GridHeader, ViewZoomBar, TableData);
end;

procedure TMainForm.LoadCSVFile(fname: string);
begin
  if not FileExists(fname) then
    raise Exception.Create('File not found: '+fname);

  FileLoader.Load(Fname, TableData);

  TableData.analyzeColumns;
  TableLensControl.PrepareLensTable;
end;

procedure TMainForm.itmLoadDataClick(Sender: TObject);
begin
if OpenForm=nil then
  begin
  OpenForm:=TfrmOpenData.Create(Self);
  OpenForm.setDataTable(TableData);
  end;

OpenForm.ShowModal;
end;

end.
