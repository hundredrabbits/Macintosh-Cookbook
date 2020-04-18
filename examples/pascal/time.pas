program ExampleTime;

 var
  date: DateTimeRec;
  seconds: Longint;

begin

 ShowText;
 GetTime(date);
 GetDateTime(seconds);
 Writeln('The current time is:');
 Writeln(date.hour : 2, ':', date.minute : 2, ':', date.second : 2);
 writeln;
 Writeln('Seconds since midnight, January 1, 1904:');
 Writeln(-seconds);

end.