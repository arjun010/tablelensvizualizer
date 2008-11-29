unit TableData;

interface
uses Logger, SysUtils;

type
  TColumnSortMode=(csmNone, csmAscending, csmDescending);
  TColIndex=byte;
  TRowIndex=LongWord;
  TFloat=Currency;
  TColumnDataType=(ctString, ctNumeric);
  TString=ShortString;
  TDataCell=record
    OriginalValue: TString;
    NumericValue: TFloat;
    VisualValue: TFloat;
  end;
  PDataCell=^TDataCell;
  TStringArray=array of TString;

  TColumnInfo=record
    Title: string;
    ColType: TColumnDataType;
    Cardinality: LongWord;
    UniqueSet: TStringArray;
    MaxVal: TFloat;
    SortMode: TColumnSortMode;
  end;

  TDataRow=array of TDataCell;
  TDataTable=class
  public
    constructor Create(aLogger:TLogger);
    procedure Clear;
    procedure SetCellByRC(RowIndex: TRowIndex;  ColumnIndex:TColIndex; Value:TDataCell);
    procedure SetOriginalValueByRC(RowIndex: TRowIndex;  ColumnIndex:TColIndex; Value:String);
    procedure setColumnTitle(ColNo: TColIndex; Title: String);
    function  getByRC(RowIndex: TRowIndex; ColumnIndex: TColIndex): PDataCell;
    function  getRowCount(): TRowIndex;
    function  getColCount(): TColIndex;
    function  getColumnInfo(ColNo: TColIndex):TColumnInfo;
    procedure analyzeColumnTypes;
    procedure analyzeColumnsPass1;
    procedure analyzeColumnsPass2;
    procedure SortByColumnNo(ColToSort: TColIndex);
  private
    Rows: array of TDataRow;
    ColumnInfo: array of TColumnInfo;
    Logger:TLogger;
    function IsNumeric(S: string): boolean;
    procedure PutUniqueValueInArray(Value: string; var StrArray: TStringArray);
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
if RowIndex>TRowIndex(Length(Rows))-1 then
  raise Exception.Create('������ ������ ������ ��� ���������� �����')
else
  Row:=Rows[RowIndex];

if ColumnIndex>Length(ColumnInfo)-1 then
  raise Exception.Create('������ ������� ������ ��� ���������� ��������')
else
  Result:=addr(Row[ColumnIndex]);

if (Row[ColumnIndex].VisualValue<0) or (Row[ColumnIndex].VisualValue>1) then
  raise Exception.Create('���-�� �� ��� � �������, 1');

if (Result.VisualValue<0) or (Result.VisualValue>1) then
  raise Exception.Create('���-�� �� ��� � �������, 2');
end;

function TDataTable.getColCount: TColIndex;
begin
Result:=Length(ColumnInfo);
end;

function TDataTable.getColumnInfo(ColNo: TColIndex): TColumnInfo;
begin
if ColNo>Length(ColumnInfo)-1 then
  raise Exception.Create('������ ������� ������ ��� ���������� ��������');
Result:=ColumnInfo[ColNo];
end;

function TDataTable.getRowCount: TRowIndex;
begin
Result:=Length(Rows);
end;

procedure TDataTable.SetCellByRC;
begin
// ���������� ����-���������� �����
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
// ���������� ����-���������� �����
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

    // ���������� �������� ��������
    Cell.NumericValue:=0;
    DecimalSeparator:='.';
    case ColumnInfo[ColNo].ColType of
      ctNumeric:
        Cell.NumericValue:=StrToFloatDef(Cell.OriginalValue, 0);
      ctString:
        Cell.NumericValue:=Length(Cell.OriginalValue);
    end; //case

    // ������������ ������������ ��������
    if ColumnInfo[ColNo].MaxVal<Cell.NumericValue then
      ColumnInfo[ColNo].MaxVal:=Cell.NumericValue;
    end;
    Logger.LogStr('Maxval: '+floatToStr(ColumnInfo[ColNo].MaxVal));
  end;
end;

procedure TDataTable.analyzeColumnsPass2;
var
    ColNo: TColIndex;
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
      raise Exception.Create('������������ �������� ��� �������� VisualValue');
    end;
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
if ColumnInfo[ColToSort].SortMode=csmAscending then
  ColumnInfo[ColToSort].SortMode:=csmDescending
else
  ColumnInfo[ColToSort].SortMode:=csmAscending;

// do sort
TQuickSorter.SortRows(Rows, ColToSort, ColumnInfo[ColToSort].SortMode);
end;

end.
