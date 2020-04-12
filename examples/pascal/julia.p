program ExampleJulia;

{Program to compute and plot Julia set.}

 const
  scale = 0.01;
  R = 10;
 type
  complex = record
    r: real;
    i: real
   end;
 var
  i, j, k, n, row, col, Nit: integer;
  x, y: real;
  z, znew, c: complex;
  done, gone: Boolean;
 procedure prod (a, b: complex; var c: complex);
{Does complex multiplication: c = a bullet b}
 begin
  c.r := a.r * b.r - a.i * b.i;
  c.i := a.r * b.i + a.i * b.r;
 end;
 procedure add (a, b: complex; var c: complex);
{Does complex addition: c = a + b}
 begin
  c.r := a.r + b.r;
  c.i := a.i + b.i;
 end;
 procedure plot (c, r: integer);
{Procedure to pixel (c.r).}
 begin
  moveto(c, r);
  lineto(c, r);
 end;
begin
 showtext;
 writeLn('How many iterations at each point?');
 readLn(Nit);
 writeLn('Value of C: (Cr,Ci)?');
 ReadLn(c.r, c.i);
 showdrawing;
 ForeColor(blackColor);
 n := 0;
 for col := 1 to 400 do
  for row := 1 to 400 do
   begin
    z.r := (col - 200) * scale;
    z.i := (row - 200) * scale;
    repeat
     prod(z, z, znew);
     add(znew, c, z);
     gone := (z.r * z.r + z.i * z.i > R);
     n := n + 1;
     done := (n > Nit);
    until done or gone or button;
    if done then
     plot(col, row);
    n := 0;
   end;
end.