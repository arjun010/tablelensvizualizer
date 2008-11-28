unit CSVFileLoader;

interface
uses
  TableData;


type TCSVFileLoader=class
  public
    procedure Load(SrcFile:String; Dest:TDataTable);
  private
    DataTable: TDataTable;
    procedure LoadCSVFile (FileName: String; separator: char);
    procedure SetCell(Row, Col: Integer; Value: String);
end;

implementation

procedure TCSVFileLoader.LoadCSVFile(FileName: String; separator: char);
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
   readln (f, s1);
   i := i + 1;
   j := 0;
   while pos(separator, s1)<>0 do
    begin
     s2 := copy(s1,1,pos(separator, s1)-1);
     j := j + 1;
     delete (s1, 1, pos(separator, S1));
     SetCell(i-1, j-1, s2);
    end;

   if pos (separator, s1)=0 then
    begin
     j := j + 1;
     SetCell(i-1, j-1, s1);
    end;
  end;
 CloseFile(f);
end;

{ TCSVFileLoader }

procedure TCSVFileLoader.Load(SrcFile: String; Dest: TDataTable);
begin
DataTable:=Dest;
LoadCSVFile(SrcFile, ';');
end;


procedure TCSVFileLoader.SetCell(Row, Col: Integer; Value: String);
begin
// отработаем заголовок
if (Row=0) then
  begin
  DataTable.setColumnTitle(Col, Value);
  end
else
  begin
  // заголовочную строку не считаем
  Row:=Row-1;

  DataTable.SetOriginalValueByRC(Row, Col, Value);
  end;
end;

end.
 