unit ColorsPalette;

interface
uses CommonTypes, Graphics;

type TColorsPalette=class
  private
    Values: array of TString;
    Colors: array of TColor;
  public
    function getColorForValue(Value: TString): TColor;
    function getIndexForValue(Value: TString): TRowIndex;
end;

implementation

uses Math;

  CONST
    PredefinedColors:  ARRAY[0..17] OF TColor =
      (
        clBlue,
        clRed,
        clGreen,
        clMaroon,
        clOlive,
        clNavy,
        clPurple,
        clTeal,
        clGray,
        clSilver,
        clLime,
        clYellow,
        clFuchsia,
        clAqua,
        clMoneyGreen,
        clSkyBlue,
        clCream,
        clWhite
      );

{ TColorsPalette }

function TColorsPalette.getColorForValue(Value: TString): TColor;
var ValueIndex: TRowIndex;
begin
ValueIndex:=0;
while ValueIndex<TRowIndex(Length(Values)) do
  begin
  if Values[ValueIndex]=Value then
    begin
    Result:=Colors[ValueIndex];
    exit;
    end;
  inc(ValueIndex);
  end;

SetLength(Values, length(Values)+1);
SetLength(Colors, length(Colors)+1);

Values[length(Values)-1]:=Value;
if ValueIndex<Length(PredefinedColors)-1 then
  Colors[length(Colors)-1]:=PredefinedColors[ValueIndex]
else
  Colors[length(Colors)-1]:=Random(MaxLongint)-MaxInt;

Result:=Colors[length(Colors)-1];
end;

function TColorsPalette.getIndexForValue(Value: TString): TRowIndex;
var ValueIndex: TRowIndex;
begin
ValueIndex:=0;
while ValueIndex<TRowIndex(Length(Values)) do
  begin
  if Values[ValueIndex]=Value then
    begin
    Result:=ValueIndex;
    exit;
    end;
  inc(ValueIndex);
  end;

result:=Length(Values);
end;

end.
