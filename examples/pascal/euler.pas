program EulerSpiral;

 const
  l = 4;
  a = 11;
 var
  wx, wy, wa: Real;
  i: Integer;
 procedure DrawAngle;
  var
   t: Real;
 begin
  MoveTo(round(wx), round(wy));
  t := wa * PI / 180;
  wx := wx + l * cos(t);
  wy := wy + l * sin(t);
  wa := wa + (i * a);
  LineTo(round(wx), round(wy));
 end;

begin

 wx := 100;
 wy := 300;
 i := 0;
 ShowDrawing;
 repeat
  DrawAngle;
  i := i + 1;
 until i > 20000;

end.