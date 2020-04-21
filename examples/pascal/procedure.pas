program ExampleProcedure;

 procedure Tri (x, y, side: integer);
 begin
  MoveTo(x, y);
  LineTo(x + side, y);
  LineTo(x + side div 2, Round(y + Side / Sqrt(2)));
  LineTo(x, y);
 end;

begin

 Tri(10, 10, 100);
 Tri(40, 40, 80);
 Tri(80, 85, 180);
 
end.