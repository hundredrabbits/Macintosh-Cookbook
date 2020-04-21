program ExampleCircle;

 type
  Vector2 = record
    x, y: real
   end;

 var
  r: Real;

 procedure Circle (r: real);
  var
   theta, thinc: Real;
   i: Integer;
   pt: Vector2;
 begin
  theta := 0.0;
  thinc := 2 * pi / 100.0;
  pt.x := r;
  pt.y := 0.0;
  Moveto(round(pt.x), round(pt.y));
  for i := 1 to 100 do
   begin
    theta := theta + thinc;
    pt.x := r * cos(theta);
    pt.y := r * sin(theta);
    Lineto(round(pt.x), round(pt.y));
   end
 end;

begin

 Writeln('Radius:');
 Readln(r);
 Circle(r);

end.