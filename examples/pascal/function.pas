program ExampleFunction;

 function add (a, b: integer): Integer;
 begin
  add := a + b;
 end;

begin
 Writeln('5+6=', add(5, 6));
end.