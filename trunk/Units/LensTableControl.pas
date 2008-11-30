unit LensTableControl;

interface
uses
  Dialogs,
  ExtCtrls,
  ComCtrls,
  TableData,
  Graphics, math;

type TLensTableControl=class
  public
    constructor Create(aPaintBox: TPaintBox; aHeader: THeaderControl; aTableData: TDataTable);
    procedure PrepareLensTable;
    procedure setViewPercent(Percent: Integer);
  private
    PaintBox: TPaintBox;
    Header: THeaderControl;
    TableData: TDataTable;
    ViewPercent: Integer;
    procedure OnPaintBox(Sender: TObject);
    procedure PaintColumn(Box: TPaintBox; ColNo: TColIndex);
    procedure OnHeaderResize(Sender: TObject);
    procedure OnHeaderClick(aHeader: THeaderControl; Section :THeaderSection);
    procedure OnHeaderSectionResize(aHeader: THeaderControl; Section :THeaderSection);
    procedure PaintGradientColumn(Box: TPaintBox; ColNo: TColIndex);
end;

implementation

uses Classes, Controls, SysUtils;

{ TLensTableControl }

constructor TLensTableControl.Create;
begin
Header:=aHeader;
TableData:=aTableData;
PaintBox:=aPaintBox;

PaintBox.OnPaint:=Self.OnPaintBox;
Header.OnResize:=Self.OnHeaderResize;
Header.OnSectionResize:=Self.OnHeaderSectionResize;
Header.OnSectionClick:=Self.OnHeaderClick;

ViewPercent:=100;
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
if TableData.getRowCount<1 then
  exit;

RowsLimit:=Floor(TableData.getRowCount*(ViewPercent/100));

Box.Canvas.Pen.Color:=clBlue;
Box.Canvas.Brush.Color:=clBlue;

BarLeftX:=Header.Sections[ColNo].Left;

BarHeight:=Box.Height/RowsLimit;
BarHeightCollected:=0;
DataCollected:=0;
DataCollectedCount:=0;

BarTopY:=0;

for RowNo:=0 to RowsLimit-1 do
  begin
  Cell:=TableData.getByRC(RowNo, ColNo);
  if Cell.VisualValue>1 then
    raise Exception.Create('Что-то не так с данными');

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

procedure TLensTableControl.PrepareLensTable;
var sectionIndex: TColIndex;
  newSection: THeaderSection;
begin
Header.Sections.Clear;

for sectionIndex:=0 to TableData.getColCount-1 do
  begin
  newSection:=THeaderSection.Create(Header.Sections);
  newSection.Text:=TableData.getColumnInfo(sectionIndex).Title;
  newSection.Alignment:=taCenter;
  end;

Header.OnResize(Header);
end;

procedure TLensTableControl.setViewPercent(Percent: Integer);
begin
ViewPercent:=Percent;
PaintBox.Repaint;
end;

end.
