unit MainFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, ComCtrls, Menus, CSVFileLoader, TableData;

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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
var
  Fname:String;
  FileLoader:TCSVFileLoader;
begin
fname:=ExtractFilePath(Application.ExeName)+'\test1.csv';

FileLoader:=TCSVFileLoader.Create();
FileLoader.Load(Fname, TTableData.create());
FileLoader.Destroy;
end;

end.
