program ExampleTime;

 var
  dtr: DateTimeRec;
  seconds, res: LongInt;
  ratio: extended;

begin

 ShowText;
 GetTime(dtr);

 seconds := 3600;
 seconds := seconds * dtr.hour;
 seconds := seconds + dtr.minute * 60;
 seconds := seconds + dtr.second;
 
 ratio := seconds / 86400;
 res := round(ratio * 1000000);

 writeln('Decimal time:');
 writeln(res);

end.