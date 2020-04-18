program ExampleSaver;

 type
  Collider = object
    x, y, dx, dy, speed: real;
   end;
  Size = object
    w, h: integer;
   end;

 var
  bounds: Size;
  frame, delay: Integer;
  view: Rect;
  p1, p2, p3: Collider;

 procedure Init;
 begin
  new(bounds);
  bounds.w := 420;
  bounds.h := 320;
  setRect(view, 100, 100, bounds.w + 120, bounds.h + 120);
  setDrawingRect(view);
  PenSize(1, 1);
  ShowDrawing;
  frame := 0;
  new(p1);
  p1.x := Random mod bounds.w + 220;
  p1.y := Random mod bounds.h + 120;
  p1.speed := 3.5;
  p1.dx := p1.speed;
  p1.dy := p1.speed;
  new(p2);
  p2.x := Random mod bounds.w + 220;
  p2.y := Random mod bounds.h + 120;
  p2.speed := 6.5;
  p2.dx := -p2.speed;
  p2.dy := p2.speed;
  new(p3);
  p3.x := Random mod bounds.w + 220;
  p3.y := Random mod bounds.h + 120;
  p3.speed := 7.5;
  p3.dx := p3.speed;
  p3.dy := -p3.speed;
 end;

 procedure Update;
 begin
  frame := frame + 1;
{ p1 }
  if p1.x > bounds.w then
   begin
    p1.dx := -p1.speed;
   end;
  if p1.x < 0 then
   begin
    p1.dx := p1.speed;
   end;
  if p1.y > bounds.h then
   begin
    p1.dy := -p1.speed;
   end;
  if p1.y < 0 then
   begin
    p1.dy := p1.speed;
   end;

{ p2 }
  if p2.x > bounds.w then
   begin
    p2.dx := -p2.speed;
   end;
  if p2.x < 0 then
   begin
    p2.dx := p2.speed;
   end;
  if p2.y > bounds.h then
   begin
    p2.dy := -p2.speed;
   end;
  if p2.y < 0 then
   begin
    p2.dy := p2.speed;
   end;

{ p3 }
  if p3.x > bounds.w then
   begin
    p3.dx := -p3.speed;
   end;
  if p3.x < 0 then
   begin
    p3.dx := p3.speed;
   end;
  if p3.y > bounds.h then
   begin
    p3.dy := -p3.speed;
   end;
  if p3.y < 0 then
   begin
    p3.dy := p3.speed;
   end;

  p1.x := p1.x + p1.dx;
  p1.y := p1.y + p1.dy;
  p2.x := p2.x + p2.dx;
  p2.y := p2.y + p2.dy;
  p3.x := p3.x + p3.dx;
  p3.y := p3.y + p3.dy;

 end;

 procedure Draw;
 begin

  MoveTo(round(p1.x), round(p1.y));
  LineTo(round(p2.x), round(p2.y));
  LineTo(round(p3.x), round(p3.y));
  LineTo(round(p1.x), round(p1.y));
 end;

begin

 Init;

 while frame < 200 do
  begin
   Update;
   Draw;
  end

end.