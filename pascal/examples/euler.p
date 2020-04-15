program EulerSpiral;
 const
  l = 4;
  a = 11;
 var
  wx, wy, wa: real;
  i: integer;
 procedure lineAngle;
  var
   t: real;
 begin
  moveTo(round(wx), round(wy));
  t := wa * PI / 180;
  wx := wx + l * cos(t);
  wy := wy + l * sin(t);
  wa := wa + (i * a);
  lineTo(round(wx), round(wy));
 end;
begin
 wx := 100;
 wy := 300;
 i := 0;
 showDrawing;
 repeat
  lineAngle;
  i := i + 1;
 until i > 20000;
end.