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
   Moveto(countup, 0);
   Lineto(200, countup);
   Lineto(countdown, 200);
   Lineto(0, countdown);
   Lineto(countup, 0);
  end

end.