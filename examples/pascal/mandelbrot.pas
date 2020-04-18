program ExampleMandelbrot;

 const
Nit = 100;
scale = 0.005;
R = 10;

 type
complex = record
  r: real;
  i: real
 end;

 var
i, j, k, n, row, col: integer;
x, y: real;
z, znew, c: complex;
done, gone: Boolean;

 procedure prod (a, b: complex; var c: complex);

{Does complex multiplication: c = a bullet b}

 begin
c.r := a.r * b.r - a.i * b.i;
c.i := a.r * b.i + a.i * b.r;

 end;

 procedure sub (a, b: complex; var c: complex);

{Does complex subtraction: c = a - b}

 begin
c.r := a.r - b.r;
c.i := a.i - b.i;

 end;

 procedure plot (c, r, n: integer);

{Procedure to pixel (c.r) in color code n.}

 begin
case n of
 0..4: 
  ForeColor(blueColor);
 5: 
  ForeColor(cyanColor);
 6: 
  ForeColor(greenColor);
 7: 
  ForeColor(magentaColor);
 8..11: 
  ForeColor(redColor);
 12..20: 
  ForeColor(yellowColor);
 21..99: 
  ForeColor(whiteColor);
 100: 
  ForeColor(blackColor);
 otherwise
  ForeColor(blackColor);
end;
moveto(c, r);
lineto(c, r);
r := 400 - r;
moveto(c, r);
lineto(c, r);

 end;

begin

 for col := 1 to 400 do
for row := 1 to 200 do
 begin
  z.r := 0.0;
  z.i := 0.0;
  c.r := (col - 100) * scale;
  c.i := (200 - row) * scale;
  repeat
   n := n + 1;
   prod(z, z, znew);
   sub(znew, c, z);
   done := (n > Nit);
   gone := (z.r * z.r + z.i * z.i > R);
  until done or gone or button;
  plot(col, row, n);
  n := 0;
 end;

end.