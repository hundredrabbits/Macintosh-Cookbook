program ExampleAngle;

 var
  ax, ay, bx, by, angle, length, t: real;

begin

 angle := 45;
 length := 100;

 ax := 100;
 ay := 100;

 t := angle * PI / 180;
 bx := ax + length * cos(t);
 by := ay + length * sin(t);
{ origin }
 moveTo(round(ax), round(ay));
 lineTo(round(ax + 100), round(ay));
{ offset }
 moveTo(round(ax), round(ay));
 lineTo(round(bx), round(by));

end.