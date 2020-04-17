program ExampleTime;

 var
  val: LongInt;

begin

 ShowText;
 GetDateTime(val);
 writeln(val);

end.

{ note: The GetDateTime procedure sets the current date and time }
{ The longint is the number of seconds since midnight, January 1, 1904 }