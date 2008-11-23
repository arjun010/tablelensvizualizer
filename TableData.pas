unit TableData;

interface
uses DataRow, Dialogs;

type
  TTableData=class
  public
    constructor Create;
    procedure SetByRC(RowIndex, ColumnIndex:Integer; Value:String);
    function  getByRC(RowIndex, ColumnIndex: integer): String;
    function  getRowCount(): word;
    function  getColCount(): word;
  private
    Rows: Array of Array of String;
end;
implementation

{ TTableData }
constructor TTableData.Create;
begin
SetLength(Rows, 0, 0);
end;

function TTableData.getByRC(RowIndex, ColumnIndex: integer): String;
begin
Result:=Rows[RowIndex, ColumnIndex];
end;

function TTableData.getColCount: word;
begin
Result:=Length(Rows[0]);
end;

function TTableData.getRowCount: word;
begin
Result:=Length(Rows);
end;

procedure TTableData.SetByRC(RowIndex, ColumnIndex: Integer; Value: String);
begin
// отработаем авто-увеличение длины
if Length(Rows)<(RowIndex+1) then
  begin
  SetLength(Rows, RowIndex+1);
  end;

if Length(Rows[RowIndex])<(ColumnIndex+1) then
  begin
  SetLength(Rows[RowIndex], ColumnIndex+1);
  end;

Rows[RowIndex, ColumnIndex]:=Value;
end;

end.
 