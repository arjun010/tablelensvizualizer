unit CSVFileLoader;

interface
uses
  sysutils,
  CommonTypes,
  TableData;

type
  TCSVSeparator=(sepTab, sepComma, sepDotComma);
  TCSVFileLoader=class
  public
    procedure Load(SrcFile:String; var Dest:TDataTable);
    procedure LoadWithLimit(SrcFile:String; var Dest:TDataTable; Limit: TRowIndex);
    procedure setSeparator(aSeparator: TCSVSeparator);
    procedure setHeaderLine(aIsHeader: boolean);
  private
    Separator: TCSVSeparator;
    FirstLineHeader: boolean;
    FileName: string;
    ColSeparator: char;
    LoadLimit: TRowIndex;
    procedure LoadCSVFile (var DataTable: TDataTable);
    procedure SetCell(var DataTable: TDataTable; Row, Col: Integer; Value: String);
end;

implementation

procedure TCSVFileLoader.LoadCSVFile;
var f: TextFile;
    s1, s2: string;
    i, j: integer;
begin
 DataTable.Clear;

 i := 0;
 AssignFile (f, FileName);
 Reset(f);

 while not eof(f) do
  begin
    if LoadLimit>0 then
      if DataTable.getRowCount>=LoadLimit then
        break;

   readln (f, s1);
   i := i + 1;
   j := 0;
   while pos(ColSeparator, s1)<>0 do
    begin
     s2 := copy(s1,1,pos(ColSeparator, s1)-1);
     j := j + 1;
     delete (s1, 1, pos(ColSeparator, S1));
     SetCell(DataTable, i-1, j-1, s2);
    end;

   if pos (ColSeparator, s1)=0 then
    begin
     j := j + 1;
     SetCell(DataTable, i-1, j-1, s1);
    end;
  end;
 CloseFile(f);
end;

procedure TCSVFileLoader.LoadWithLimit;
begin
FileName:=SrcFile;
case Separator of
  sepTab: ColSeparator:=chr(9);
  sepComma: ColSeparator:=',';
  sepDotComma: ColSeparator:=';';
end;

LoadLimit:=Limit;

LoadCSVFile(Dest);
end;

procedure TCSVFileLoader.Load;
begin
LoadWithLimit(SrcFile, Dest, 0);
end;

procedure TCSVFileLoader.SetCell;
begin
// отработаем заголовок
if (Row=0) then
  begin
  IF FirstLineHeader then
    DataTable.setColumnTitle(Col, Value)
  else
    DataTable.setColumnTitle(Col, 'Column'+Inttostr(Col+1));
  end
else
  begin
  // заголовочную строку не считаем
  if FirstLineHeader then
    Row:=Row-1;

  DataTable.SetOriginalValueByRC(Row, Col, Value);
  end;
end;

procedure TCSVFileLoader.setSeparator(aSeparator: TCSVSeparator);
begin
Separator:=aSeparator;
end;

procedure TCSVFileLoader.setHeaderLine(aIsHeader: boolean);
begin
FirstLineHeader:=aIsHeader;
end;

end.
 