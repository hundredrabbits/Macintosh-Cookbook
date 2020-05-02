program ExampleStrings;

 var
  width, height: Integer;
  ws, hs, combined: str255;
  drawingRect: Rect;

begin

 width := 220;
 height := 140;

 NumToString(width, ws);
 NumToString(height, hs);

 SetRect(drawingRect, 60, 60, 60 + width, 60 + height);

 ShowDrawing;
 SetDrawingRect(drawingRect);
 MoveTo(20, 20);
 WriteDraw('Window Size');
 MoveTo(20, 40);
 WriteDraw(concat(ws, 'x', hs));

end.