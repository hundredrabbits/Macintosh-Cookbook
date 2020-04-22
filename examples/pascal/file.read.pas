program ExampleFileRead;

 procedure ReadFile;
  var
   i: Integer;
   data: string;
   infile: Text;
 begin
  i := 0;
  Open(infile, OldFileName('Open txt file?'));
  repeat
   i := i + 1;
   Readln(infile, data);
   Writeln(data);
  until eof(infile);
  Reset(infile);
 end;

begin

 ShowText;
 ReadFile;

end.