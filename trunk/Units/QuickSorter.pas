unit QuickSorter;

interface
uses TableData, CommonTypes;

type
  TQuickSorter=class
  class procedure SortRows(var Rows: array of TDataRow; ColToSort: TColIndex; SortMode:TColumnSortMode);
  class procedure SortRowsImpl(var Rows: array of TDataRow; ColToSort: TColIndex; SortMode:TColumnSortMode; LeftIndex, RightIndex: TRowIndex);
end;

implementation

{ TQuickSorter }

class procedure TQuickSorter.SortRows(var Rows: array of TDataRow;
  ColToSort: TColIndex; SortMode: TColumnSortMode);
begin
TQuickSorter.SortRowsImpl(Rows, ColToSort, SortMode, 0, Length(Rows)-1);
end;

class procedure TQuickSorter.SortRowsImpl;
  var
    NewLeftIndex, NewRightIndex: TRowIndex;
    MiddleValue: TDataCell;
    SwapRow: TDataRow;

  begin
    NewLeftIndex:=LeftIndex;
    NewRightIndex:=RightIndex;
    MiddleValue := Rows[(RightIndex+LeftIndex) div 2][ColToSort];
    repeat
      if SortMode=csmAscending then
        begin
        while Rows[NewLeftIndex][ColToSort].NumericValue<MiddleValue.NumericValue do
          inc(NewLeftIndex);
        while MiddleValue.NumericValue<Rows[NewRightIndex][ColToSort].NumericValue do
          dec(NewRightIndex);
        end
      else
        begin
        while Rows[NewLeftIndex][ColToSort].NumericValue>MiddleValue.NumericValue do
          inc(NewLeftIndex);
        while MiddleValue.NumericValue>Rows[NewRightIndex][ColToSort].NumericValue do
          begin
          dec(NewRightIndex);
          end;
        end;

      if NewLeftIndex<=NewRightIndex then
        begin
        SwapRow:=Rows[NewLeftIndex];
        Rows[NewLeftIndex]:=Rows[NewRightIndex];
        Rows[NewRightIndex]:=SwapRow;

        if NewLeftIndex<TRowIndex(Length(Rows)-1) then
         inc(NewLeftIndex);
        if NewRightIndex>0 then
          dec(NewRightIndex);
      end;
    until NewLeftIndex>NewRightIndex;
    
    if LeftIndex<NewRightIndex then
      SortRowsImpl(Rows, ColToSort, SortMode, LeftIndex, NewRightIndex);
    if NewLeftIndex<RightIndex then
      SortRowsImpl(Rows, ColToSort, SortMode, NewLeftIndex, RightIndex);
end;

end.
 