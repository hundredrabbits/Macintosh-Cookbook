program ExampleTime;

 var
  date: DateTimeRec;
  seconds: longint;

begin

 ShowText;
 GetTime(date);
 GetDateTime(seconds);
 writeln('The current time is:');
 writeln(date.hour : 2, ':', date.minute : 2, ':', date.second : 2);
 writeln;
 writeln('Seconds since midnight, January 1, 1904:');
 writeln(-seconds);

end.