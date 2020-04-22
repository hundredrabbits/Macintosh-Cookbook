program ExampleFile;

 var
  outfile: Text;

begin

 ShowText;

 ReWrite(outfile, 'data.txt');
 Writeln(outfile, 'hello world');
 Writeln(outfile, 'foo bar');

 Writeln('Writing data.txt complete.');

end.