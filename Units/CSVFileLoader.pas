unit CSVFileLoader;

interface
uses
  sysutils,
  CommonTypes,
  TableData;

type
  TCSVSeparator=(sepTab, sepComma, sepDotComma);
  TCSVFileLoader=class
  public
    procedure Load(SrcFile:String; Dest:TDataTable);
    procedure LoadWithLimit(SrcFile:String; Dest:TDataTable; Limit: TRowIndex);
    procedure setSeparator(aSeparator: TCSVSeparator);
    procedure setHeaderLine(aIsHeader: boolean);
  private
    Separator: TCSVSeparator;
    FirstLineHeader: boolean;
    FileName: string;
    ColSeparator: char;
    LoadLimit: TRowIndex;
    RowIndex: TRowIndex;
    procedure LoadCSVFile (DataTable: TDataTable);
    procedure ParseLine (Line: string; DataTable: TDataTable);
    procedure SetCell(DataTable: TDataTable; Row, Col: Integer; Value: String);
end;

implementation

procedure TCSVFileLoader.LoadCSVFile;
var FileHandle: TextFile;
    StringLine: string;
begin
DataTable.Clear;
RowIndex:=0;

AssignFile (FileHandle, FileName);
Reset(FileHandle);

while not eof(FileHandle) do
  begin
  if (LoadLimit>0) and (DataTable.getRowCount>=LoadLimit) then
    break;

  readln (FileHandle, StringLine);
  ParseLine(StringLine, DataTable);
  end;
  
CloseFile(FileHandle);
end;

procedure TCSVFileLoader.parseLine;
var ColIndex: TColIndex;
  StringCell: TString;
begin
ColIndex := 0;
while pos(ColSeparator, Line)<>0 do
  begin
  StringCell := copy(Line, 1, pos(ColSeparator, Line)-1);
  delete (Line, 1, pos(ColSeparator, Line));
  SetCell(DataTable, RowIndex, ColIndex, StringCell);
  inc(ColIndex);
  end;

if pos (ColSeparator, Line)=0 then
  SetCell(DataTable, RowIndex, ColIndex, Line);

inc(RowIndex);
end;

procedure TCSVFileLoader.LoadWithLimit;
begin
FileName:=SrcFile;
case Separator of
  sepTab: ColSeparator:=chr(9);
  sepComma: ColSeparator:=',';
  sepDotComma: ColSeparator:=';';
end;

LoadLimit:=Limit;

LoadCSVFile(Dest);
end;

procedure TCSVFileLoader.Load;
begin
LoadWithLimit(SrcFile, Dest, 0);
end;

procedure TCSVFileLoader.SetCell;
begin
// отработаем заголовок
if (Row=0) then
  begin
  IF FirstLineHeader then
    DataTable.setColumnTitle(Col, Value)
  else
    DataTable.setColumnTitle(Col, 'Column'+Inttostr(Col+1));
  end;

if (Row<>0) or not(FirstLineHeader) then
  begin
  // заголовочную строку не считаем
  if FirstLineHeader then
    Row:=Row-1;

  DataTable.SetOriginalValueByRC(Row, Col, Value);
  end;
end;

procedure TCSVFileLoader.setSeparator(aSeparator: TCSVSeparator);
begin
Separator:=aSeparator;
end;

procedure TCSVFileLoader.setHeaderLine(aIsHeader: boolean);
begin
FirstLineHeader:=aIsHeader;
end;

end.
 