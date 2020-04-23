program ExampleFractal;

{ Program to play the Chaos Game }

{ Algorithm: }
{ 1. Pick a point in a triangle at random & plot it }
{ 2. Pick a vertex of the triangle at random }
{ 3. Move 1/2 way from present point to this vertex }
{ 4. Plot point and loop from (2) until mouse pressed.}

 var
  xp, yp, i: integer;
  x, y: array[1..3] of real;

 function Rndint (n: integer): integer;
{Function to return random integer on range 1 --> n}
  var
   rr: longint;
   r: real;
 begin

  rr := random; {Intrinsic routine}
  r := (rr + 32767) / (32767 + 32768);
  Rndint := trunc(n * r) + 1;

 end;

begin

 ShowDrawing;
    {Set corners of triangle centered at (110,125),}
    {with sides 200 pixels long}
 x[1] := 110 - 100;
 y[1] := 125 + 57.73503;
 x[2] := 110;
 y[2] := 125 - 115.470;
 x[3] := 110 + 100;
 y[3] := y[1];
    {Pick first point at random in box containing triangle}
 xp := Rndint(200) + 10;
 yp := Rndint(173) + 10;
 DrawLine(xp, yp, xp, yp); {Plot point}

 repeat {until Mouse button is pressed}
  i := Rndint(3); {Pick random corner}
  xp := round((x[i] - xp) / 2 + xp); {Go half way}
  yp := round((y[i] - yp) / 2 + yp); {Go half way}
  DrawLine(xp, yp, xp, yp); {Plot point}
 until button;

end.