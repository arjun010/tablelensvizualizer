program TableLensVisualizer;

uses
  Forms,
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  CSVFileLoader in 'CSVFileLoader.pas',
  TableData in 'TableData.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
