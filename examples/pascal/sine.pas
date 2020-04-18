program ExampleSine;

 const
  PI = 3.141592654;
  AMP = 50;
 var
  x, y: real;

begin

 ShowDrawing;
 x := 0;

 repeat
  y := sin((x / 300) * (2 * PI)) * AMP;
  moveTo(round(x), AMP + round(y));
  lineTo(round(x), AMP + round(y));
  x := x + 1;
 until x > 400

end.

{ note: If this does not draw a sine in THINK Pascal on Mac II }
{ note: Project > Compile options : toggle 68881/ 68882 }