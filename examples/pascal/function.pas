program ExampleFunction;

 function Add (a, b: integer): Integer;
 begin
  Add := a + b;
 end;

begin

 ShowText;
 Writeln('5+6=', Add(5, 6));

end.