unit OpenData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Grids;

type
  TfrmOpenData = class(TForm)
    PageControl1: TPageControl;
    tabOpenCSV: TTabSheet;
    tabOpenExcel: TTabSheet;
    tabSQLServer: TTabSheet;
    Edit1: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Panel3: TPanel;
    Button2: TButton;
    Button3: TButton;
    StringGrid1: TStringGrid;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Label5: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
