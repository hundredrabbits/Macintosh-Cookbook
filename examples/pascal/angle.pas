program ExampleAngle;

 var
  ax, ay, bx, by, angle, length, t: Real;

begin

 angle := 45;
 length := 100;

 ax := 100;
 ay := 100;

 t := angle * PI / 180;
 bx := ax + length * cos(t);
 by := ay + length * sin(t);

 ShowDrawing;
{ origin }
 MoveTo(round(ax), round(ay));
 LineTo(round(ax + 100), round(ay));
{ offset }
 MoveTo(round(ax), round(ay));
 LineTo(round(bx), round(by));

end.