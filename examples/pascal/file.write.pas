program ExampleFile;

 const
  FILENAME = 'data.txt';

 var
  outfile: Text;

begin

 ShowText;

 ReWrite(outfile, FILENAME);
 Writeln(outfile, 'hello world');
 Writeln(outfile, 'foo bar');

 Writeln('Writing ', FILENAME, ' complete.');

end.