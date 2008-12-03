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
    TableLensControl:TLensTableControl;
    OpenForm: TfrmOpenData;
    { Private declarations }
  public
    procedure StartLensTable;
    function getDataTable: TDataTable;
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TableData:=TDataTable.create;

  TableLensControl:=TLensTableControl.Create(GridImage, GridHeader, ViewZoomBar, TableData);
end;

procedure TMainForm.StartLensTable;
begin
TableLensControl.PrepareLensTable;
end;

procedure TMainForm.itmLoadDataClick(Sender: TObject);
begin
if OpenForm=nil then
  OpenForm:=TfrmOpenData.Create(Self);

OpenForm.Show;
end;

function TMainForm.getDataTable: TDataTable;
begin
Result:=TableData;
end;

end.
