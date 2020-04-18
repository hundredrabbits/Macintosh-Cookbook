program ExampleCircleFill;

 procedure fillcircle (xc, yc, radius: integer);
  var
   x, y: Integer;
 begin
  for y := -radius to radius do
   begin
    for x := -radius to radius do
     begin
      if (x * x + y * y <= radius * radius) then
       begin
       moveto(xc + x, yc + y);
       lineto(xc + x, yc + y);
       end;
     end;
   end;
 end;

begin

 fillcircle(60, 60, 40);

end.