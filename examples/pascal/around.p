program ExampleAround;
 var
  count, countup, countdown: integer;
begin
 ShowDrawing;
 for count := 0 to 20 do
  begin
   countup := count * 4;
   countdown := 200 - countup;
   moveto(countup, 0);
   lineto(200, countup);
   lineto(countdown, 200);
   lineto(0, countdown);
   lineto(countup, 0);
  end
end.