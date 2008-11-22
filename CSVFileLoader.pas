unit CSVFileLoader;

interface
uses
  TableData;


type TCSVFileLoader=class
  public
    procedure Load(SrcFile:String; Dest:TTableData);
  private
    DataTable: TTableData;
    procedure LoadCSVFile (FileName: String; separator: char);
end;

implementation

procedure TCSVFileLoader.LoadCSVFile(FileName: String; separator: char);
var f: TextFile;
    s1, s2: string;
    i, j: integer;
begin
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
     DataTable.SetByXY(j-1, i-1, s2);
    end;

   if pos (separator, s1)=0 then
    begin
     j := j + 1;
     DataTable.SetByXY(j-1, i-1, s1);
    end;

   //StringGrid1.ColCount := j;
   //StringGRid1.RowCount := i+1;
  end;
 CloseFile(f);
end;

{ TCSVFileLoader }

procedure TCSVFileLoader.Load(SrcFile: String; Dest: TTableData);
begin
DataTable:=Dest;
LoadCSVFile(SrcFile, ';');
end;


end.
 