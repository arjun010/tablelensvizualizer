program TableLensVisualizer;



uses
  Forms,
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  CSVFileLoader in 'CSVFileLoader.pas',
  TableData in 'TableData.pas',
  Logger in 'Logger.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Table Lens Data Vizualizer';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
