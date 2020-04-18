program ExampleBezier;
{Program to read in four Bezier control points: }
{ P1 = first point }
{ P2 = second point, controlling slope at first }
{ P3 = third point, controlling slope at fourth }
{ P4 = fourth point, end of section }
{and compute and plot resulting parametric }
{cubic curve. }

 type
  mat = array[1..4, 1..4] of Real;
 var
  Px, Py, Cx, Cy: mat;
  Tv, Mb, x, y: mat;
  i, j, k, xx, yy: Integer;
  window: rect;
  t, dt: Real;
  P: point;

{************* MatMlt **************}

 procedure matmlt (var d, a, b: mat; n, m: integer);
    { Program to calculate matrix product: }
    {D=A*B, where }
    { A = n x 4 input matrix }
    { B = 4 x m input matrix }
    { D = n x m output matrix }

  var
   i, j, k: Integer;
   sum: Real;
   temp: mat;

 begin

  for i := 1 to n do
   begin
    for j := 1 to m do
     begin
      sum := 0.0;
      for k := 1 to 4 do
       sum := sum + a[i, k] * b[k, j];
      temp[i, j] := sum;
     end;
   end;
  for i := 1 to n do
   for j := 1 to m do
    d[i, j] := temp[i, j];

 end;

    {+++++++++ Get-Points ++++++++++++}
 procedure getPoints;

  var
   i, x, y: Integer;

 begin {First set up drawing window}

  SetRect(window, 30, 30, 400, 300);
  setDrawingRect(window);
  ShowDrawing;
  penSize(2, 2);
  moveto(40, 20); {Print heading }
  textSize(18);
  textFont(2);
  writeDraw('Bezier Parametric Cubic Curve');
  textSize(12);
  ForeColor(409); {Set pen to blue.}
        {Loop to read 4 points.}
  for i := 1 to 4 do
   begin
    SetRect(window, 90, 30, 255, 50);
    eraseRect(window);
    moveto(100, 45);
    writeDraw('Please click in point', I : 3);
    FrameRect(window);
    repeat
     getMouse(P)
    until button;
    repeat
    until (not button);
    Px[i, 1] := P.h;
    Py[i, 1] := P.v;
    SetRect(window, (P.h - 2), (P.v - 2), (P.h + 4), (P.v + 4));
        {Draw point as 6-pixel diameter circle.}
    paintOval(window);
   end;

 end;

 procedure set_BezMat;
 begin {Simplest to go brute force.}

  Mb[1, 1] := -1;
  Mb[1, 2] := 3;
  Mb[1, 3] := -3;
  Mb[1, 4] := 1;
  Mb[2, 1] := 3;
  Mb[2, 2] := -6;
  Mb[2, 3] := 3;
  Mb[2, 4] := 0;
  Mb[3, 1] := -3;
  Mb[3, 2] := 3;
  Mb[3, 3] := 0;
  Mb[3, 4] := 0;
  Mb[4, 1] := 1;
  Mb[4, 2] := 0;
  Mb[4, 3] := 0;
  Mb[4, 4] := 0;

 end;

{******** MAIN PROGRAM **************}
begin

 set_BezMat;
 getPoints;
    {Calculate coefficient vector}
 matmlt(Cx, Mb, Px, 4, 1);
 matmlt(Cy, Mb, Py, 4, 1);
    {Now trace out curve in 101 steps }
 t := -0.01;
 xx := round(Px[1, 1]);
 yy := round(Py[1, 1]);
 moveto(xx, yy);
 ForeColor(137); {Set pen to magenta.}
 for i := 1 to 101 do
  begin
   t := t + 0.01;
   Tv[1, 4] := 1;
   Tv[1, 3] := t * Tv[1, 4];
   Tv[1, 2] := t * Tv[1, 3];
   Tv[1, 1] := t * Tv[1, 2];
   matmlt(x, Tv, Cx, 1, 1);
   matmlt(y, Tv, Cy, 1, 1);
   xx := round(x[1, 1]);
   yy := round(y[1, 1]);
   lineto(xx, yy);
  end;

end.