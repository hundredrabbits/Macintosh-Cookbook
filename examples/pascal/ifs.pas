program ExampleIFS;
{Program to compute fractals using IFSs.}
{Ref.: Barnsley, "Fractals Everywhere , p. 88}
 const
  pixdim = 120;
 type
  pic = array[1..pixdim, 1..pixdim] of Boolean;
  vec = array[1..4] of Real;
  dimvec = array[1..4] of Integer;
 var
  s, t: pic;
  a, b, c, d, e, f, p: vec;
  x, y: dimvec;
  i, j, k, dpix: Integer;
  box: rect;

{********** Pset **************}
 procedure pset (x, y: integer);
{Procedure to plot point at pixel (x,y).}
 begin
  moveto(x, y);
  lineto(x, y);
 end;

{********* Define Object ***********}
 procedure DefineObject (var t: pic);
{Procedure to define initial graphical object}
  var
   i, j: Integer;
 begin
{Initialize object to an upper half-diagonal square.}
  for i := 1 to pixdim do
   for j := 1 to pixdim do
    if j < i then
     begin
      t[i, j] := true;
      pset(i, j);
     end;
  SetRect(box, 1, 1, pixdim, pixdim);
 end;

{************* SetCoef ***********}
 procedure SetCoef (var a, b, c, d, e, f: vec);
{Procedure to set up coefficient of affine transform.}
  var
   i: Integer;
 begin {Set problem parameters for Sierpinski triangle.}
  for i := 1 to 3 do
   begin
    a[i] := 0.5;
    b[i] := 0;
    c[i] := 0;
    d[i] := 0.5;
    e[i] := pixdim / 2;
    f[i] := 1;
   end;
  e[1] := 1;
  f[3] := pixdim / 2;
 end;

{***************Main Program***************}
begin
 DefineObject(t);
 SetCoef(a, b, c, d, e, f);
 dpix := pixdim div 2;
{Map next generation of image A(n+1) = W(A(n))}
 repeat
  for i := 1 to pixdim do
   for j := 1 to pixdim do
    if t[i, j] then
     begin
      for k := 1 to 3 do
       begin
       x[k] := trunc(a[k] * i + b[k] * j + e[k]);
       y[k] := trunc(c[k] * i + d[k] * j + f[k]);
       s[x[k], y[k]] := true;
       end;
     end;
{Now plot.}
  EraseRect(box);
  for i := 1 to pixdim do
   for j := 1 to pixdim do
    begin
     t[i, j] := s[i, j];
     s[i, j] := false;
     if t[i, j] then
      pset(i, j);
    end;
  dpix := dpix div 2;
  WriteLn('dpix = ', dpix);
 until button or (dpix < 1)
end.