program ExampleScale;

 var
  clip: Rect;

begin

 showDrawing;

{ origine }
 setRect(clip, 10, 10, 100, 100);
 paintArc(clip, 0, 180);
 frameRect(clip);

{ scale }
 eraseArc(clip, 0, 180);
 insetRect(clip, 20, 20);
 paintArc(clip, 0, 180);
 frameRect(clip);

end.