unit Logger;

interface

type TLogger=class
  public
    constructor Create(LogFile: String);
    procedure LogStr(S:String);
    destructor Destroy; override;
  private
    outf: textfile;
end;

implementation
uses SysUtils;

{ TLogger }

constructor TLogger.Create(LogFile: String);
begin
  assignfile(outf, changefileext(paramstr(0), '.log'));
  if fileexists(changefileext(paramstr(0), '.log')) then
    append(outf)
  else
    rewrite(outf);
end;

destructor TLogger.Destroy;
begin
  closefile(outf);
  inherited Destroy;
end;

procedure TLogger.LogStr(S: String);
begin
  {writing in the log file}
  writeln(outf, datetimetostr(now) + chr(9) + S);
  sleep(100);
end;

end.
 