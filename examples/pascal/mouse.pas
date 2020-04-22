program ExampleMouse;

 var
  Pt: Point;

begin

 ShowDrawing;
 ShowText;

 repeat {Until we double-click}

  GetMouse(Pt);

{Button down message detector}

  while button do
   begin
    Writeln('down', Pt.h, Pt.v);
    repeat {Tight loop until button up}
    until not Button;
   end;

{ Button up message detector}

  while not button do
   begin
    Writeln('up', Pt.h, Pt.v);
    repeat {Tight loop until button down}
    until button;
   end;

 until 1 > 1; { forever}

end.