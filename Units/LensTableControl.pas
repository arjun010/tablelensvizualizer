unit LensTableControl;

interface
uses
  ExtCtrls,
  ComCtrls,
  TableData,
  Graphics;

type TLensTableControl=class
  public
    constructor Create(aPaintBox: TPaintBox; aHeader: THeaderControl; aTableData: TDataTable);
    procedure PrepareLensTable;
  private
    PaintBox: TPaintBox;
    Header: THeaderControl;
    TableData: TDataTable;
    procedure OnPaintBox(Sender: TObject);
    procedure PaintColumn(Box: TPaintBox; ColNo: TColIndex);
    procedure OnHeaderResize(Sender: TObject);
    procedure OnHeaderSectionResize(Header: THeaderControl; Section :THeaderSection);
    procedure PaintGradientColumn(Box: TPaintBox; ColNo: TColIndex);
end;

implementation

uses Classes;

{ TLensTableControl }

constructor TLensTableControl.Create;
begin
Header:=aHeader;
TableData:=aTableData;
PaintBox:=aPaintBox;

PaintBox.OnPaint:=Self.OnPaintBox;
Header.OnResize:=Self.OnHeaderResize;
Header.OnSectionResize:=Self.OnHeaderSectionResize;
end;

procedure TLensTableControl.OnHeaderResize(Sender: TObject);
var sectNo: TColIndex;
begin
if Header.Sections.Count<1 then
  exit;

for sectNo:=0 to Header.Sections.Count-1 do
  Header.Sections[sectNo].Width:=Header.Width div Header.Sections.Count;

PaintBox.Repaint;
end;

procedure TLensTableControl.OnHeaderSectionResize;
begin
PaintBox.Repaint;
end;

procedure TLensTableControl.OnPaintBox;
var Box: TPaintBox;
  ColNo: TColIndex;
begin
Box:=Sender as TPaintBox;

if Header.Sections.Count>0 then
  for ColNo:=0 to Header.Sections.Count-1 do
    PaintColumn(Box, ColNo);
end;

procedure TLensTableControl.PaintColumn;
begin
// restore BG
Box.Canvas.Pen.Color:=(Box.Parent as TPanel).Color;
Box.Canvas.Brush.Color:=Box.Canvas.Pen.Color;
Box.Canvas.Rectangle(Header.Sections[ColNo].Left, 0, Header.Sections[ColNo].Left+Header.Sections[ColNo].Width, Box.Height);

// draw separator line
Box.Canvas.Pen.Color:=clInactiveCaption;
Box.Canvas.Brush.Color:=Box.Canvas.Pen.Color;
Box.Canvas.MoveTo(Header.Sections[ColNo].Left+Header.Sections[ColNo].Width-1, 0);
Box.Canvas.LineTo(Header.Sections[ColNo].Left+Header.Sections[ColNo].Width-1, Box.Height);

// draw bars
PaintGradientColumn(Box, ColNo);
end;

procedure TLensTableControl.PaintGradientColumn;
var
  BarLeftX, BarRightX: word;
  BarTopY, BarBottomY: word;
  RowNo: TRowIndex;
  Cell:PDataCell;
  BarHeight: Double;
begin
Box.Canvas.Pen.Color:=clBlue;
Box.Canvas.Brush.Color:=clBlue;

BarLeftX:=Header.Sections[ColNo].Left;

for RowNo:=0 to TableData.getRowCount-1 do
  begin
  Cell:=TableData.getByRC(RowNo, ColNo);

  BarTopY:=Round(RowNo*(PaintBox.Height/TableData.getRowCount));
  BarBottomY:=Round((RowNo+1)*(PaintBox.Height/TableData.getRowCount));

  BarRightX:=BarLeftX+Round((Header.Sections[ColNo].Width-1) * Cell.VisualValue);

  Box.Canvas.Rectangle(BarLeftX, BarTopY, BarRightX, BarBottomY);
  end;
end;

procedure TLensTableControl.PrepareLensTable;
var sectionIndex: TColIndex;
  newSection: THeaderSection;
begin
Header.Sections.Clear;

for sectionIndex:=0 to TableData.getColCount-1 do
  begin
  newSection:=THeaderSection.Create(Header.Sections);
  newSection.Text:=TableData.getColumnInfo(sectionIndex).Title;
  end;

Header.OnResize(Header);
end;

end.
