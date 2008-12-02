unit CommonTypes;

interface
type
  TColumnSortMode=(csmNone, csmAscending, csmDescending);
  TColIndex=byte;
  TRowIndex=LongWord;
  TFloat=Currency;
  TColumnDataType=(ctString, ctNumeric);
  TColumnVisualType=(cvtSkip, cvtGradient, cvtBars);
  TString=ShortString;
  TDataCell=record
    OriginalValue: TString;
    NumericValue: TFloat;
    VisualValue: TFloat;
  end;
  PDataCell=^TDataCell;
  TStringArray=array of TString;

  TDataRow=array of TDataCell;

implementation

end.
 