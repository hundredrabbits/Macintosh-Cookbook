program ExampleShapes;

 procedure traceShape (cx, cy, r, sides: real);
  const
   PI = 3.141592654;
  var
   side: real;
   ax, ay, bx, by: real;
   center: Point;
 begin
  side := sides;
  setPt(center, 100, 100);
  repeat
   ax := center.h + r * cos(2 * PI * side / sides);
   ay := center.v + r * sin(2 * PI * side / sides);
   bx := center.h + r * cos(2 * PI * (side + 1) / sides);
   by := center.v + r * sin(2 * PI * (side + 1) / sides);
   moveTo(round(ax), round(ay));
   lineTo(round(bx), round(by));
   side := side - 1;
  until side < 1;
 end;

begin

 traceShape(100, 100, 60, 24);
 traceShape(100, 100, 60, 12);
 traceShape(100, 100, 60, 6);
 traceShape(100, 100, 60, 3);
 ShowDrawing;

end.