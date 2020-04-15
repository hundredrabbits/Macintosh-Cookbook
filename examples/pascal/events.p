program ExampleEvents;
{Program to demonstrate detection of button events }
{and use of button for program control. }

 var
  tic1, tic2: longint;

begin

    {Open Drawing Window and label screen.}
 ShowDrawing;
 MoveTo(20, 20);
 TextSize(18);
 WriteDraw('Button Event Test');
 MoveTo(35, 40);
 TextSize(12);

 WriteDraw('Double-Click to QUIT');
 MoveTo(40, 70);
 WriteDraw('Now the Button is: ');

    {Use XOR pattern to erase and rewrite output}
 TextMode(srcXor);
 MoveTo(80, 100);
 TextSize(24);
 TextFace([bold]);

 repeat {Until we double-click}
  while button do {Button down message detector}
   begin
    WriteDraw('down');
    MoveTo(80, 100);
    repeat {Tight loop until button up}
    until not Button;
    WriteDraw('down'); {Erase "down" text}
    MoveTo(80, 100);
    tic1 := TickCount; {Sample system clock: }
   end; {1/60 sec ticks}

  while not button do { Button up message detector}
   begin
    WriteDraw('up');
    MoveTo(80, 100);
    repeat {Tight loop until button down}
    until button;
    WriteDraw('up'); {Erase "up" text}
    MoveTo(80, 100);
    tic2 := TickCount; {Sample system clock}
   end;

 until abs(tic2 - tic1) < 30; {Double click message detector}

end.