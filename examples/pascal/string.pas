program ExampleString;

 var
  foo: String;

begin

 ShowText;
 
 foo := 'foo';
 Writeln(foo);

 foo[1] := 'b';
 foo[2] := 'a';
 foo[3] := 'r';

 Writeln(foo); { outputs: bar }

end.
