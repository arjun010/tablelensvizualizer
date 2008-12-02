unit OpenData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Grids, TableData;

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
    StringGrid1: TStringGrid;
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
    { Private declarations }
    procedure previewCSVInitialLoad;
    procedure previewCSVOptionsChangedLoad;
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

previewCSVOptionsChangedLoad;
end;

procedure TfrmOpenData.previewCSVOptionsChangedLoad;
begin
PreviewDataTable.Clear;

end;

procedure TfrmOpenData.btnLoadClick(Sender: TObject);
begin
(Parent as TMainForm).LoadCSVFile(edFileName.Text);
end;

procedure TfrmOpenData.FormCreate(Sender: TObject);
begin
PreviewDataTable:=TDataTable.Create;
end;

end.
