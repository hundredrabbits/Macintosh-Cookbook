program ExampleKeyboard;

 var
  Key: char;

begin

 ShowText;

 repeat
  write('Press a key. ');
  readln(Key);
  writeln('The ordinal value of this key is ', ord(Key), '.');
 until ord(Key) = 22;

end.