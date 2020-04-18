program ExampleScale;

 var
  clip: Rect;

begin

 ShowDrawing;

{ origine }
 SetRect(clip, 10, 10, 100, 100);
 PaintArc(clip, 0, 180);
 FrameRect(clip);

{ scale }
 EraseArc(clip, 0, 180);
 InsetRect(clip, 20, 20);
 PaintArc(clip, 0, 180);
 FrameRect(clip);

end.