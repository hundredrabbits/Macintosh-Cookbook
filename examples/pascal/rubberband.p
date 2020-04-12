program RubberBand;

{Program to demonstrate Rubber Band technique}
{for constructing graphical objects }
 var
  x1, y1, x2, y2: integer;
  p: point;
begin

 ShowDrawing; {Open Drawing Window}
 MoveTo(20, 20); {Label graph and options}
 TextSize(18);
 WriteDraw('Rubber Band Program');
 TextSize(10);
 MoveTo(30, 40);
 WriteDraw('* Button down to draw line');
 MoveTo(30, 50);
 WriteDraw('* Double-click left of window to QUIT');
 PenMode(patXor); {Set Pen Mode to Xor}
    {to erase and redraw line}
 repeat {Keep working until exit}
  if Button then {executes once/line}
   begin
    GetMouse(p); {Read first point on line}
    x1 := p.h; {horizontal element of point}
    y1 := p.v;
{ vertical element of point }
    while Button do {Loop until button released}
     begin
      GetMouse(p); {Read second point}
      x2 := p.h; {horizontal element}
      y2 := p.v;
{ vertical element }
      DrawLine(x1, y1, x2, y2); {Draw line}
      DrawLine(x1, y1, x2, y2); {Erase line}
     end; {Now redraw permanent line }

    DrawLine(x1, y1, x2, y2);
   end;

 until (x1 < 0) and Button {Exit by clicking left}

end. {of Drawing Window}