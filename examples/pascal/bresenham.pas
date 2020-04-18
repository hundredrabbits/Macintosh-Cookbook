program ExampleBresenham;
    {Program to draw a straight }
    { line from (x1,y1) to (x2,y2) }
    {using Bresenham's Algorithm }
 var
  i, irange, xp, yp, dxs, dys: Integer;
  x1, y1, x2, y2: Real;
  dx, dy, x, y, range: Real;
  errp: Real;
  axis: char;
 procedure point (x, y: integer);
    {Procedure to plot point at (x,y)}
 begin
  moveto(xp, yp);
  lineto(xp, yp);
 end;
begin
    {Query the user for two points}
 Writeln('Bresenham''s Straight-Line Algorithm');
 Writeln('Input point 1 (x1,y1):');
 Readln(x1, y1);
 Writeln('Input point 2 (x2,y2):');
 Readln(x2, y2);
 range := abs(x2 - x1);
 axis := 'x';
        {Test for axis of more rapid motion}
 if abs(y2 - y1) > range then
  begin
   range := abs(y2 - y1);
   axis := 'y';
  end;
 irange := round(range);
 dx := (x2 - x1);
 dy := (y2 - y1);
 errp := 2 * dy - dx;
 dxs := 1;
    {Test for direction of x motion}
 if dx < 0 then
  dxs := -1;
 dys := 1;
    {Test for direction of y motion}
 if dy < 0 then
  dys := -1;
 xp := round(x1);
 yp := round(y1);
 ShowDrawing;
    {This part steps along x axis}
 case axis of
  'x': 
   begin
    for i := 1 to irange do
     begin
      point(xp, yp);
      if errp > 0 then
       begin
       yp := yp + dys;
       errp := errp - 2 * dx * dxs
       end;
      xp := xp + dxs;
      errp := errp + 2 * dy * dys;
     end;
   end;
  'y': {This part steps along y axis}
   begin
    for i := 1 to irange do
     begin
      point(xp, yp);
      if errp > 0 then
       begin
       xp := xp + dxs;
       errp := errp - 2 * dy * dys
       end;
      yp := yp + dys;
      errp := errp + 2 * dx * dxs;
     end;
   end;
 end;
end.