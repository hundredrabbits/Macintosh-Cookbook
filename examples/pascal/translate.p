program ExampleTranslate;

 var
  clip: Rect;

begin

 showDrawing;

{ origine }
 setRect(clip, 10, 10, 100, 100);
 paintArc(clip, 0, 180);
 frameRect(clip);

{ translation }
 eraseArc(clip, 0, 180);
 offsetRect(clip, 40, 40);
 paintArc(clip, 0, 180);
 frameRect(clip);

end.