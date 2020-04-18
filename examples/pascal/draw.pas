program ExampleDraw;

 const
  radius = 10;
 var
  cursor, prev: Point;
  isDown: Boolean;

 procedure WhenDownChanged;
 begin
  MoveTo(prev.h, prev.v);
  LineTo(cursor.h, cursor.v);
  GetMouse(prev);
 end;

 procedure WhenDown;
 begin
  GetMouse(cursor);
  if cursor.h <> prev.h then
   if cursor.v <> prev.v then
    WhenDownChanged;
 end;

 procedure MainLoop;
 begin
  repeat {Until we click outside screen}
   while button do
    begin
     GetMouse(cursor);
     GetMouse(prev);
     MoveTo(cursor.h, cursor.v);
     LineTo(prev.h, prev.v);
     repeat {Tight loop until button up}
      WhenDown;
     until not Button;
    end;
  until cursor.h > 300;
 end;

begin

 ShowDrawing;
 Writeln('Started');
 MainLoop;
 Writeln('stopped');
 
end.