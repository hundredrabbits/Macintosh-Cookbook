program ExampleShapes;

 procedure TraceShape (cx, cy, r, sides: real);
  const
   PI = 3.141592654;
  var
   side: Real;
   ax, ay, bx, by: Real;
   center: Point;
 begin
  side := sides;
  setPt(center, 100, 100);
  repeat
   ax := center.h + r * cos(2 * PI * side / sides);
   ay := center.v + r * sin(2 * PI * side / sides);
   bx := center.h + r * cos(2 * PI * (side + 1) / sides);
   by := center.v + r * sin(2 * PI * (side + 1) / sides);
   MoveTo(round(ax), round(ay));
   LineTo(round(bx), round(by));
   side := side - 1;
  until side < 1;
 end;

begin

 ShowDrawing;
 TraceShape(100, 100, 60, 24);
 TraceShape(100, 100, 60, 12);
 TraceShape(100, 100, 60, 6);
 TraceShape(100, 100, 60, 3);

end.