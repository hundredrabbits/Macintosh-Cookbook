program ExampleEulerStorm;

 const
  A = -1;
  B = 3;
  C = -2;
  D = 5;
  eps = 0.05;

 var
  ds: real;

 function f (x, y: real): real;
 begin
  f := y - x * x * x / 3
 end;

 function g (x, y: real): real;
 begin
  g := -x
 end;

 procedure segment (x, y: real);
 begin
  LineTo(round(510 * (x - A) / (B - A)), round(340 * (y - D) / (c - d)))
 end;

 procedure euler (S: integer; var err: boolean; x0, y0: real; var x1, y1: real);
  var
   dx, dy, dt: real;
 begin
  err := false;
  dx := f(x0, y0);
  dy := g(x0, y0);
  if abs(dx) + abs(dy) < eps then
   err := true
  else
   begin
    dt := ds / sqrt(dx * dx + dy * dy);
    x1 := x0 + S * dt * dx;
    y1 := y0 + S * dt * dy
   end
 end;

 procedure trajectory (x, y: real);
  var
   N, S: integer;
   x0, y0, x1, y1: real;
   msg: boolean;
 begin
  for S := 0 to 1 do
   begin
    x0 := x;
    y0 := y;
    N := 1;
    MoveTo(round(510 * (x - A) / (B - A)), round(340 * (y - D) / (C - D)));
    repeat
     euler(2 * S - 1, msg, x0, y0, x1, y1);
     if not (msg) then
      begin
       segment(x1, y1);
       N := N + 1;
       x0 := x1;
       y0 := y1
      end
    until msg or (N > 50) or (x1 < A) or (x1 > B) or (y1 < C) or (y1 > D)
   end
 end;

 procedure DrawPicture;
  var
   i, j, diviseur: integer;
 begin
  diviseur := 10;
  for j := 2 to 5 do
   for i := 1 to diviseur do
    trajectory((B + A) / 2 + (B - A) * cos(2 * pi * i / diviseur) / j, (C + D) / 2 + (D - C) * sin(2 * pi * i / diviseur) / j)
 end;

begin

 ds := (B - A) / 50;
 ShowDrawing;
 DrawPicture;

end.