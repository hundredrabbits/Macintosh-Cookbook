program ExampleShape;

 const
  PI = 3.141592654;
  R = 60.0;
  DOTS = 10;

 var
  dot: integer;
  ax, ay, bx, by: real;
  center: Point;

begin

 dot := DOTS;
 setPt(center, 100, 100);

 repeat
  ax := center.h + R * cos(2 * PI * dot / DOTS);
  ay := center.v + R * sin(2 * PI * dot / DOTS);
  bx := center.h + R * cos(2 * PI * (dot + 1) / DOTS);
  by := center.v + R * sin(2 * PI * (dot + 1) / DOTS);
  moveTo(round(ax), round(ay));
  lineTo(round(bx), round(by));
  dot := dot - 1;
 until dot < 1;

 ShowDrawing;

end.