unit LensTableControl;

interface
uses
  CommonTypes,
  Dialogs,
  ExtCtrls,
  ComCtrls,
  TableData,
  Graphics, math;

type TLensTableControl=class
  public
    constructor Create(
      aPaintBox: TPaintBox;
      aHeader: THeaderControl;
      aTrack:TTrackBar;
      aTableData: TDataTable
      );
    procedure PrepareLensTable;
  private
    PaintBox: TPaintBox;
    Header: THeaderControl;
    TableData: TDataTable;
    ViewPercent: TTrackBar;
    VisibleColumnsCount: TColIndex;
    
    procedure OnPaintBox(Sender: TObject);
    procedure PaintColumn(Box: TPaintBox; ColNo: TColIndex);
    procedure OnHeaderResize(Sender: TObject);
    procedure OnHeaderClick(aHeader: THeaderControl; Section :THeaderSection);
    procedure OnHeaderSectionResize(aHeader: THeaderControl; Section :THeaderSection);
    procedure PaintGradientColumn(Box: TPaintBox; ColNo: TColIndex);
    procedure PaintBarsColumn(Box: TPaintBox; ColNo: TColIndex);
    procedure OnViewZoomBarChange(Sender: TObject);
end;

implementation

uses Classes, Controls, SysUtils;

{ TLensTableControl }

constructor TLensTableControl.Create;
begin
Header:=aHeader;
TableData:=aTableData;
PaintBox:=aPaintBox;
ViewPercent:=aTrack;

PaintBox.OnPaint:=Self.OnPaintBox;
Header.OnResize:=Self.OnHeaderResize;
Header.OnSectionResize:=Self.OnHeaderSectionResize;
Header.OnSectionClick:=Self.OnHeaderClick;
ViewPercent.OnChange:=OnViewZoomBarChange;

Header.Enabled:=false;
PaintBox.Enabled:=false;
ViewPercent.Enabled:=false;
end;

procedure TLensTableControl.OnHeaderClick;
var ColNo: TColIndex;
begin
// sort data
TableData.SortByColumnNo(Section.Index);

// change header state
for ColNo:=0 to TableData.getColCount-1 do
  if ColNo<>Section.Index then
    Header.Sections[ColNo].ImageIndex:=-1
  else
    If TableData.getColumnInfo(Section.Index).SortMode=csmAscending then
      Section.ImageIndex:=0
    else
      Section.ImageIndex:=1;

// repaint
PaintBox.Repaint;
end;

procedure TLensTableControl.OnHeaderResize(Sender: TObject);
var sectNo: TColIndex;
begin
if Header.Sections.Count<1 then
  exit;

for sectNo:=0 to Header.Sections.Count-1 do
  Header.Sections[sectNo].Width:=(Header.Width-ViewPercent.Width) div VisibleColumnsCount;

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

procedure TLensTableControl.OnViewZoomBarChange(Sender: TObject);
begin
PaintBox.repaint;
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

if TableData.getRowCount<1 then
  exit;

// draw bars
case TableData.getColumnInfo(ColNo).VisualType of
  cvtSkip: {skip col};
  cvtGradient: PaintGradientColumn(Box, ColNo);
  cvtBars: PaintBarsColumn(Box, ColNo);
end; // case

end;

procedure TLensTableControl.PaintGradientColumn;
var
  BarLeftX, BarRightX: word;
  BarTopY, BarBottomY: Double;
  RowNo: TRowIndex;
  Cell:PDataCell;
  BarHeight: Double;
  BarHeightCollected: Double;
  DataCollected: TFloat;
  DataCollectedCount: TRowIndex;
  AvgData: TFloat;
  RowsLimit: TRowIndex;
begin
RowsLimit:=Floor(TableData.getRowCount*(ViewPercent.Position/100));

Box.Canvas.Pen.Color:=TableData.getColumnInfo(ColNo).Palette.getColorForValue('');
Box.Canvas.Brush.Color:=Box.Canvas.Pen.Color;

BarLeftX:=Header.Sections[ColNo].Left;

BarHeight:=Box.Height/RowsLimit;
BarHeightCollected:=0;
DataCollected:=0;
DataCollectedCount:=0;

BarTopY:=0;

for RowNo:=0 to RowsLimit-1 do
  begin
  Cell:=TableData.getByRC(RowNo, ColNo);

  BarHeightCollected:=BarHeightCollected+BarHeight;
  DataCollected:=DataCollected+Cell.VisualValue;
  inc(DataCollectedCount);

  // decide whether we have data rows enough to paint it
  if BarHeightCollected>=1 then
    begin
    BarBottomY:=BarTopY+BarHeightCollected;

    AvgData:=DataCollected/DataCollectedCount;
    BarRightX:=BarLeftX+Round((Header.Sections[ColNo].Width-1) * AvgData);

    Box.Canvas.Rectangle(BarLeftX, Floor(BarTopY), BarRightX, Floor(BarBottomY));

    BarTopY:=BarBottomY;

    // reset counters
    DataCollected:=0;
    DataCollectedCount:=0;
    BarHeightCollected:=0;
    end; // if
  end; // for
end;

procedure TLensTableControl.PaintBarsColumn;
var
  BarTopY, BarBottomY: Double;
  RowNo: TRowIndex;
  Cell:PDataCell;
  BarLeftX, BarHeight, BarWidth: Double;
  BarHeightCollected: Double;
  RowsLimit: TRowIndex;
begin
RowsLimit:=Floor(TableData.getRowCount*(ViewPercent.Position/100));

BarHeight:=Box.Height/RowsLimit;
BarWidth:=Header.Sections[ColNo].Width/TableData.getColumnInfo(ColNo).Cardinality;
BarHeightCollected:=0;

BarTopY:=0;

for RowNo:=0 to RowsLimit-1 do
  begin
  Cell:=TableData.getByRC(RowNo, ColNo);

  BarHeightCollected:=BarHeightCollected+BarHeight;

  // decide whether we have data rows enough to paint it
  if BarHeightCollected>=1 then
    begin
    BarBottomY:=BarTopY+BarHeightCollected;

    BarLeftX:=Header.Sections[ColNo].Left+BarWidth*TableData.getColumnInfo(ColNo).Palette.getIndexForValue(Cell.OriginalValue);

    Box.Canvas.Pen.Color:=TableData.getColumnInfo(ColNo).Palette.getColorForValue(Cell.OriginalValue);
    Box.Canvas.Brush.Color:=Box.Canvas.Pen.Color;

    Box.Canvas.Rectangle(Round(BarLeftX), Floor(BarTopY), Round(BarLeftX+BarWidth), Floor(BarBottomY));

    BarTopY:=BarBottomY;

    // reset counters
    BarHeightCollected:=0;
    end; // if
  end; // for
end;

procedure TLensTableControl.PrepareLensTable;
var sectionIndex: TColIndex;
  newSection: THeaderSection;
begin
TableData.analyzeColumns;

Header.Sections.Clear;
VisibleColumnsCount:=0;

for sectionIndex:=0 to TableData.getColCount-1 do
  begin
  newSection:=THeaderSection.Create(Header.Sections);
  newSection.Text:=TableData.getColumnInfo(sectionIndex).Title;
  newSection.Alignment:=taCenter;
  if TableData.getColumnInfo(sectionIndex).VisualType=cvtSkip then
    newSection.MaxWidth:=0
  else
    inc(VisibleColumnsCount);
  end;

Header.OnResize(Header);

Header.Enabled:=true;
PaintBox.Enabled:=true;
ViewPercent.Enabled:=true;
end;

end.
