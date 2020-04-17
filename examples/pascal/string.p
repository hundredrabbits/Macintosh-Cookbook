program ExampleString;

 var
  foo: string;

begin

 foo := 'foo';
 writeln(foo);

 foo[1] := 'b';
 foo[2] := 'a';
 foo[3] := 'r';

 writeln(foo); { outputs: bar }

end.
