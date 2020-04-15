program ExampleFunction;

 function add (a, b: integer): integer;
 begin
  add := a + b;
 end;

begin
 writeln('5+6=', add(5, 6));
end.