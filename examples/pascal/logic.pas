program ExampleLogic;

  {Comment}

 var
  name: String;

begin

 ShowText;
 name := 'alice';
 if (name = 'alice') then
  Writeln('The name is alice.')
 else if (name = 'bob') then
  Writeln('The name is bob.')
 else
  Writeln('The name is not alice nor bob.');

end.