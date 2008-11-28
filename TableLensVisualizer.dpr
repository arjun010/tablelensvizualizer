program TableLensVisualizer;



uses
  Forms,
  CSVFileLoader in 'Units\CSVFileLoader.pas',
  LensTableControl in 'Units\LensTableControl.pas',
  Logger in 'Units\Logger.pas',
  MainFormUnit in 'Units\MainFormUnit.pas' {MainForm},
  TableData in 'Units\TableData.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Table Lens Data Vizualizer';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
