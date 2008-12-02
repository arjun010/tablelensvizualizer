unit OpenData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Grids;

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
    Label4: TLabel;
    cbHeaders: TCheckBox;
    rbTab: TRadioButton;
    rbComma: TRadioButton;
    rbDotComma: TRadioButton;
    lblSeparator: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
