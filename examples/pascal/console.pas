program ExampleConsole;

 const
  message = ' Welcome to the world of Pascal ';

 type
  name = String;

 var
  firstname, surname: name;

begin

 Writeln('Please enter your first name: ');
 Readln(firstname);

 Writeln('Please enter your surname: ');
 Readln(surname);

 writeln;
 Writeln(message, ' ', firstname, ' ', surname);

end.