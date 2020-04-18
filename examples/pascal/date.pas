program ExampleDate;

 var
  date: DateTimeRec;

begin

 ShowText;
 GetTime(date);
 Writeln('The current date is:');
 Writeln(date.year : 4, '-', date.month : 2, '-', date.day : 2);

end.