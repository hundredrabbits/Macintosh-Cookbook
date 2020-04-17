program ExampleDate;

 var
  date: DateTimeRec;

begin

 ShowText;
 GetTime(date);
 writeln('The current date is:');
 writeln(date.year : 4, '-', date.month : 2, '-', date.day : 2);

end.