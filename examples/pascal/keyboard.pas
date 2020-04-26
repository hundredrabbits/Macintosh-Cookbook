program ExampleKeyboard;

 var
  Key: char;

begin

 ShowText;
 repeat
  Write('Press a key. ');
  Readln(Key);
  Writeln('The ordinal value of this key is ', ord(Key), '.');
 until ord(Key) = 22;

end.