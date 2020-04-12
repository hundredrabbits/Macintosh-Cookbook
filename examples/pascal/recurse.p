program Recurse;

 var
  i, left, top, right, bottom: integer;
  box: rect;

begin

 showDrawing;
 PenSize(9, 9);
 PenMode(patXor);

 for i := 1 to 50 do
  begin
   left := 110 - 1 * i;
   top := 110 - 10 * i;
   right := 120 + 10 * i;
   bottom := 115 + 10 * i;
   SetRect(box, left, top, right, bottom);
   PaintOval(box);
  end

end.