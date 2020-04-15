program ExamplePen;

 var
  x, y: integer;
  Pt: Point;

begin

 PenSize(10, 10);
 
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