program ExampleDate;

 type
  Date = record
    Month: string[8];
    Dayname: string[9];
    Day: 1..31;
    Year: Integer;
    Time: longint
   end;

 var
  Access_Date: Date;
  Temp_Date: DateTimeRec;

 function Present_Month (Number: integer): string;
 begin
  case Number of
   1: 
    Present_Month := 'Jan';
   2: 
    Present_Month := 'Feb';
   3: 
    Present_Month := 'Mar';
   4: 
    Present_Month := 'Apr';
   5: 
    Present_Month := 'May';
   6: 
    Present_Month := 'Jun';
   7: 
    Present_Month := 'Jul';
   8: 
    Present_Month := 'Aug';
   9: 
    Present_Month := 'Sep';
   10: 
    Present_Month := 'Oct';
   11: 
    Present_Month := 'Nov';
   12: 
    Present_Month := 'Dec';
  end;
 end;

 function Present_Dayname (Number: integer): string;
 begin
  case Number of
   1: 
    Present_Dayname := 'Sun';
   2: 
    Present_Dayname := 'Mon';
   3: 
    Present_Dayname := 'Tue';
   4: 
    Present_Dayname := 'Wed';
   5: 
    Present_Dayname := 'Thu';
   6: 
    Present_Dayname := 'Fri';
   7: 
    Present_Dayname := 'Sat';
  end;
 end;

 procedure Convert_Date (var Out_Date: Date; In_Date: DateTimeRec);
 begin
  Out_Date.Month := Present_Month(In_Date.Month);
  Out_date.Dayname := Present_Dayname(In_Date.DayOfWeek);
  Out_date.Day := In_date.Day;
  Out_Date.Year := In_Date.Year;
  Out_Date.Time := In_Date.Hour * 10000 + In_Date.Minute * 100 + In_Date.Second;
 end;

 procedure Report_Date_Time (In_Date: Date);
  var
   Hour, Minute, Second: Integer;
 begin
{ date }
  Write(In_Date.dayname, ', ', In_Date.Month);
  Writeln(In_Date.Day : 3, ', ', In_Date.Year : 4);
{ time }
  Hour := 12 + In_Date.Time div 10000;
  Minute := (In_Date.Time - Hour * 10000) div 100;
  Second := In_Date.Time - (Hour * 10000 + Minute * 100);
  Writeln(hour : 2, ':', Minute : 2, ':', Second : 2);
 end;

begin

 showText;
 GetTime(Temp_Date);
 Convert_Date(Access_Date, Temp_Date);
 Report_Date_Time(Access_Date);

end.