program ExampleAround;

 var
  count, countup, countdown: Integer;
  box: rect;

begin

{ Create the window rect }
 SetRect(box, 100, 100, 320, 320);
 SetDrawingRect(box);
 ShowDrawing;

{ Draw lines }
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