program ExamplePen;

 var
  x, y: Integer;
  Pt: Point;

begin

 ShowDrawing;
 PenSize(10, 1);

 while true do
  begin
   repeat
   until Button;
   GetMouse(Pt);
   MoveTo(Pt.h, Pt.v);
   while Button do
    begin
     GetMouse(Pt);
     LineTo(Pt.h, Pt.v);
    end
  end

end.