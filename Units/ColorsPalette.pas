unit ColorsPalette;

interface
uses CommonTypes, Graphics;

type TColorsPalette=class
  private
  public
    function getColorForValue(Value: TString): TColor;
end;

implementation

{ TColorsPalette }

function TColorsPalette.getColorForValue(Value: TString): TColor;
begin
Result:=clBlue;
end;

end.
 