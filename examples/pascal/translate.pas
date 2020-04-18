program ExampleTranslate;

 var
  clip: Rect;

begin

 ShowDrawing;

{ origine }
 SetRect(clip, 10, 10, 100, 100);
 PaintArc(clip, 0, 180);
 FrameRect(clip);

{ translation }
 EraseArc(clip, 0, 180);
 OffSetRect(clip, 40, 40);
 PaintArc(clip, 0, 180);
 FrameRect(clip);

end.