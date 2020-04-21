program SineFix;

 uses
  FixMath;
  
 var
  amp, y: Fixed;
  x, a: Longint;
  r: Rect;

begin

 ShowDrawing;
 
 amp := Long2Fix(50);
 a := 0;
 repeat
  x := -1;
  ShowDrawing;
  MoveTo(-1, -1);
  repeat
   y := FracSin((x + a) * 6000);
   y := FixMul(Frac2Fix(y), amp);
   LineTo(x, Fix2Long(y + amp));
   x := x + 3;
  until x > 250;
  a := a + 10;
  SetRect(r, 0, 0, 250, 50 * 2 + 1);
  FillRect(r, white);
 until False;

end.

{ note: This project requires the FixMath library. }