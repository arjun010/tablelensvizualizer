unit CSVFileLoader;

interface
uses
  sysutils,
  CommonTypes,
  TableData;

type
  TCSVSeparator=(sepUnknown, sepTab, sepComma, sepSemicolon);
  TCSVSeparators=set of TCSVSeparator;
  TCSVFileLoader=class
  public
    procedure Load(SrcFile:String; Dest:TDataTable);
    procedure LoadWithLimit(SrcFile:String; Dest:TDataTable; Limit: TRowIndex);
    function GuessSeparator(SrcFile:String; RowLimit: TRowIndex):TCSVSeparator;
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

function StrCountChar(Line: String; Character: Char): Word;
  var n: word;
begin
Result:=0;
For n:=0 to length(Line)-1 do
  if Line[n]=Character then
    inc(Result);
end;

procedure GuessSeparatorSingle(
  StringLine: string;
  Separator:TCSVSeparator;
  SeparatorChar:char;
  RowsRead: word;
  var PrevCount: word;
  var PossibleSeparators:TCSVSeparators
  );
var CurCount: word;
begin
if not (sepTab in PossibleSeparators) then
  exit;

CurCount:=StrCountChar(StringLine, SeparatorChar);
if (RowsRead>1) and (PrevCount<>CurCount) then
  PossibleSeparators:=PossibleSeparators-[Separator];
PrevCount:=CurCount;
end;

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
  sepSemicolon: ColSeparator:=';';
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

function TCSVFileLoader.GuessSeparator(SrcFile: String;
  RowLimit: TRowIndex): TCSVSeparator;
var FileHandle: TextFile;
    StringLine: string;
    RowsRead: TRowIndex;
    PossibleSeparators: TCSVSeparators;

    PrevSemicolonCount, PrevCommaCount, PrevTabCount: Word;
begin
PossibleSeparators:=[sepTab, sepComma, sepSemicolon];
RowsRead:=0;
PrevTabCount:=0;

AssignFile (FileHandle, SrcFile);
Reset(FileHandle);

while not eof(FileHandle) do
  begin
  if (LoadLimit>0) and (RowsRead>=LoadLimit) then
    break;

  readln(FileHandle, StringLine);
  GuessSeparatorSingle(StringLine, sepTab, chr(9), RowsRead, PrevTabCount, PossibleSeparators);
  GuessSeparatorSingle(StringLine, sepComma, ',', RowsRead, PrevCommaCount, PossibleSeparators);
  GuessSeparatorSingle(StringLine, sepSemicolon, ';', RowsRead, PrevSemicolonCount, PossibleSeparators);
  end; // while

CloseFile(FileHandle);

// decide what to return
Result:=sepUnknown;

if sepTab in PossibleSeparators then
  Result:=sepTab;
if sepComma in PossibleSeparators then
  Result:=sepComma;
if sepSemicolon in PossibleSeparators then
  Result:=sepSemicolon;
end;

end.
