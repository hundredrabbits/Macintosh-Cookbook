program ExampleCircleFill;

 procedure Fillcircle (xc, yc, radius: integer);
  var
   x, y: Integer;
 begin
  for y := -radius to radius do
   begin
    for x := -radius to radius do
     begin
      if (x * x + y * y <= radius * radius) then
       begin
       Moveto(xc + x, yc + y);
       Lineto(xc + x, yc + y);
       end;
     end;
   end;
 end;

begin

 Fillcircle(60, 60, 40);

end.