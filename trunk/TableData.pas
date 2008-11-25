unit TableData;

interface
uses Logger, SysUtils;

type
  TColIndex=byte;
  TRowIndex=LongWord;
  TColumnDataType=(ctString, ctNumeric);
  TDataCell=record
    OriginalValue: string;
    CalculatedValue: Variant;
  end;
  TStringArray=array of string;

  TColumnInfo=record
    Title: string;
    ColType: TColumnDataType;
    Cardinality: LongWord;
    UniqueSet: TStringArray;
    MaxVal: Double; 
  end;

  TDataRow=array of TDataCell;
  TDataTable=class
  public
    constructor Create(aLogger:TLogger);
    procedure SetCellByRC(RowIndex: TRowIndex;  ColumnIndex:TColIndex; Value:TDataCell);
    procedure SetOriginalValueByRC(RowIndex: TRowIndex;  ColumnIndex:TColIndex; Value:String);
    procedure setColumnTitle(ColNo: TColIndex; Title: String);
    function  getByRC(RowIndex: TRowIndex; ColumnIndex: TColIndex): TDataCell;
    function  getRowCount(): TRowIndex;
    function  getColCount(): TColIndex;
    function  getColumnInfo(ColNo: TColIndex):TColumnInfo;
    procedure analyzeColumnTypes;
    procedure analyzeColumnsCardinalityAndContent;
  private
    Rows: array of TDataRow;
    ColumnInfo: array of TColumnInfo;
    Logger:TLogger;
    function IsNumeric(S: string): boolean;
    procedure PutUniqueValueInArray(Value: string; var StrArray: TStringArray);

  end;
implementation

{ TTableData }

function TDataTable.IsNumeric(S: string): boolean;
var i: integer;
begin
  // http://www.experts-exchange.com/Programming/Languages/Pascal/Delphi/Q_21911343.html
  result := false;
  for i := 1 to Length(s) do begin
    if not (s[i] in ['0'..'9', '.']) then exit;
  end;
  result := true;
end;

procedure TDataTable.analyzeColumnTypes;
var
    ColNo: TColIndex;
    RowNo: TRowIndex;
    ColType: TColumnDataType;
    StrValue: String;
begin
for ColNo:=0 to Length(ColumnInfo)-1 do
  begin
  ColType:=ctNumeric;
  for RowNo:=0 to Length(Rows)-1 do
    begin
    StrValue:=Rows[RowNo][ColNo].OriginalValue;
    if not IsNumeric(StrValue) then
      begin
      ColType:=ctString;
      break;
      end;
    end;
    ColumnInfo[ColNo].ColType:=ColType;
  end;
end;

constructor TDataTable.Create;
begin
Logger:=aLogger;
end;

function TDataTable.getByRC;
var Row:TDataRow;
begin
Row:=Rows[RowIndex];
Result:=Row[ColumnIndex];
end;

function TDataTable.getColCount: TColIndex;
begin
Result:=Length(ColumnInfo);
end;

function TDataTable.getColumnInfo(ColNo: TColIndex): TColumnInfo;
begin
Result:=ColumnInfo[ColNo];
end;

function TDataTable.getRowCount: TRowIndex;
begin
Result:=Length(Rows);
end;

procedure TDataTable.SetCellByRC;
begin
// отработаем авто-увеличение длины
if (TRowIndex(Length(Rows)))<(RowIndex+1) then
  begin
  SetLength(Rows, RowIndex+1);
  end;

if Length(Rows[RowIndex])<(ColumnIndex+1) then
  begin
  SetLength(Rows[RowIndex], ColumnIndex+1);
  end;

Rows[RowIndex, ColumnIndex]:=Value;
end;

procedure TDataTable.setColumnTitle;
begin
// отработаем авто-увеличение длины
if Length(ColumnInfo)<(ColNo+1) then
  begin
  SetLength(ColumnInfo, ColNo+1);
  end;

ColumnInfo[ColNo].Title:=Title;
end;

procedure TDataTable.SetOriginalValueByRC;
var Cell: TDataCell;
begin
Cell.OriginalValue:=Value;
SetCellByRC(RowIndex, ColumnIndex, Cell);
end;

procedure TDataTable.analyzeColumnsCardinalityAndContent;
var
    ColNo: TColIndex;
    RowNo: TRowIndex;
begin
for ColNo:=0 to Length(ColumnInfo)-1 do
  for RowNo:=0 to Length(Rows)-1 do
    PutUniqueValueInArray(Rows[RowNo][ColNo].OriginalValue, ColumnInfo[ColNo].UniqueSet);
end;

procedure TDataTable.PutUniqueValueInArray(Value: string;
  var StrArray: TStringArray);
var n: LongWord;
begin
n:=0;
while (n<LongWord(Length(StrArray))) do
  begin
  if StrArray[n]=Value then exit;
  inc(n);
  end;

SetLength(StrArray, length(StrArray)+1);
StrArray[length(StrArray)-1]:=Value;
end;

end.
