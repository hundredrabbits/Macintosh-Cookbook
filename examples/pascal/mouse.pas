program ExampleMouse;

 var
  tic1, tic2: Longint;
  Pt: Point;

begin

 ShowDrawing;

 repeat {Until we double-click}

  GetMouse(Pt);

{Button down message detector}

  while button do
   begin
    Writeln('down', Pt.h, Pt.v);
    repeat {Tight loop until button up}
    until not Button;
    tic1 := TickCount; {Sample system clock: }
   end; {1/60 sec ticks}

{ Button up message detector}

  while not button do
   begin
    Writeln('up', Pt.h, Pt.v);
    repeat {Tight loop until button down}
    until button;
    tic2 := TickCount; {Sample system clock}
   end;

 until abs(tic2 - tic1) < 10; {Double click message detector}

end.