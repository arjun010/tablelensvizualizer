unit TableData;

interface
uses SysUtils, CommonTypes, ColorsPalette;

type
  TColumnInfo=record
    Title: string;
    ColType: TColumnDataType;
    Cardinality: LongWord;
    UniqueSet: TStringArray;
    MaxVal: TFloat;
    SortMode: TColumnSortMode;
    VisualType: TColumnVisualType;
    Palette: TColorsPalette;
  end;

  TDataTable=class
  public
    constructor Create;
    procedure Clear;
    procedure SetCellByRC(RowIndex: TRowIndex;  ColumnIndex:TColIndex; Value:TDataCell);
    procedure SetOriginalValueByRC(RowIndex: TRowIndex;  ColumnIndex:TColIndex; Value:String);
    procedure setColumnTitle(ColNo: TColIndex; Title: String);
    function  getByRC(RowIndex: TRowIndex; ColumnIndex: TColIndex): PDataCell;
    function  getRowCount(): TRowIndex;
    function  getColCount(): TColIndex;
    function  getColumnInfo(ColNo: TColIndex):TColumnInfo;
    procedure SortByColumnNo(ColToSort: TColIndex);
    procedure analyzeColumns;
    procedure setCardinalityLimit(Limit: TRowIndex);
  private
    Rows: array of TDataRow;
    ColumnInfo: array of TColumnInfo;
    GradientCardinalityLimit: TRowIndex;
    function IsNumeric(S: string): boolean;
    procedure PutUniqueValueInArray(Value: string; var StrArray: TStringArray);
    procedure CalculateNumerics(ColNo: TColIndex; Cell: PDataCell);
    procedure CalculateMaxVal(ColNo: TColIndex; NumValue: TFloat);
    procedure analyzeColumnTypes;
    procedure analyzeColumnsPass1;
    procedure analyzeColumnsPass2;
  end;
implementation

uses QuickSorter;
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
    Row: TDataRow;
begin
for ColNo:=0 to Length(ColumnInfo)-1 do
  begin
  ColType:=ctNumeric;
  for RowNo:=0 to Length(Rows)-1 do
    begin
    Row:=Rows[RowNo];
    StrValue:=Row[ColNo].OriginalValue;
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
GradientCardinalityLimit:=20;
end;

function TDataTable.getByRC;
var Row:TDataRow;
begin
if RowIndex>TRowIndex(Length(Rows))-1 then
  raise Exception.Create('Row index exceeds rows count')
else
  Row:=Rows[RowIndex];

if ColumnIndex>Length(ColumnInfo)-1 then
  raise Exception.Create('Column index exceeds column count')
else
  Result:=addr(Row[ColumnIndex]);
end;

function TDataTable.getColCount: TColIndex;
begin
Result:=Length(ColumnInfo);
end;

function TDataTable.getColumnInfo(ColNo: TColIndex): TColumnInfo;
begin
if ColNo>Length(ColumnInfo)-1 then
  raise Exception.Create('Column index exceeds column count');
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
  ColumnInfo[ColNo].Palette:=TColorsPalette.Create;
  end;

ColumnInfo[ColNo].Title:=Title;
end;

procedure TDataTable.SetOriginalValueByRC;
var Cell: TDataCell;
begin
Cell.OriginalValue:=Value;
SetCellByRC(RowIndex, ColumnIndex, Cell);
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

procedure TDataTable.CalculateNumerics;
begin
    // рассчитаем числовые значения
    Cell.NumericValue:=0;
    DecimalSeparator:='.';
    case ColumnInfo[ColNo].ColType of
      ctNumeric:
        Cell.NumericValue:=StrToFloatDef(Cell.OriginalValue, 0);
      ctString:
        Cell.NumericValue:=Length(Cell.OriginalValue);
    end; //case
end;

procedure TDataTable.analyzeColumnsPass1;
var
    ColNo: TColIndex;
    RowNo: TRowIndex;
    Cell: PDataCell;
begin
for ColNo:=0 to Length(ColumnInfo)-1 do
  begin
  for RowNo:=0 to Length(Rows)-1 do
    begin
    Cell:=addr(Rows[RowNo][ColNo]);
    PutUniqueValueInArray(Cell.OriginalValue, ColumnInfo[ColNo].UniqueSet);

    CalculateNumerics(ColNo, Cell);

    CalculateMaxVal(ColNo, Cell.NumericValue);
    end; //rows

    ColumnInfo[ColNo].Cardinality:=length(ColumnInfo[ColNo].UniqueSet);

    if ColumnInfo[ColNo].Cardinality<1 then
      raise Exception.Create('Unique values count must be more than 1');

    if ColumnInfo[ColNo].Cardinality=1 then
      ColumnInfo[ColNo].VisualType:=cvtSkip
    else
      if ColumnInfo[ColNo].Cardinality<GradientCardinalityLimit then
        ColumnInfo[ColNo].VisualType:=cvtBars
      else
        ColumnInfo[ColNo].VisualType:=cvtGradient;
  end; // cols
end;

procedure TDataTable.Clear;
begin
SetLength(Rows, 0);
SetLength(ColumnInfo, 0);
end;

procedure TDataTable.SortByColumnNo;
var ColIndex: TColIndex;
begin
// reset old sorted columns
for ColIndex:=0 to Length(ColumnInfo)-1 do
  if ColIndex<>ColToSort then
    ColumnInfo[ColIndex].SortMode:=csmNone;

// choose sort mode
if ColumnInfo[ColToSort].SortMode=csmDescending then
  ColumnInfo[ColToSort].SortMode:=csmAscending
else
  ColumnInfo[ColToSort].SortMode:=csmDescending;

// do sort
TQuickSorter.SortRows(Rows, ColToSort, ColumnInfo[ColToSort].SortMode);
end;

procedure TDataTable.CalculateMaxVal;
begin
// рассчитываем максимальное значение
if ColumnInfo[ColNo].MaxVal<NumValue then
  ColumnInfo[ColNo].MaxVal:=NumValue;
end;

procedure TDataTable.analyzeColumns;
begin
analyzeColumnTypes;
analyzeColumnsPass1;
analyzeColumnsPass2;
end;

procedure TDataTable.analyzeColumnsPass2;
var ColNo: TColIndex;
  RowNo: TRowIndex;
  Cell: PDataCell;
begin
for ColNo:=0 to Length(ColumnInfo)-1 do
  for RowNo:=0 to Length(Rows)-1 do
    begin
    Cell:=addr(Rows[RowNo][ColNo]);

    if ColumnInfo[ColNo].MaxVal<>0 then
      Cell.VisualValue:=Cell.NumericValue/ColumnInfo[ColNo].MaxVal
    else
      Cell.VisualValue:=0;

    if (Cell.VisualValue<0) or (Cell.VisualValue>1) then
      raise Exception.Create('Illegal VisualValue range');
    end;
end;

procedure TDataTable.setCardinalityLimit(Limit: TRowIndex);
begin
GradientCardinalityLimit:=Limit;
end;

end.
