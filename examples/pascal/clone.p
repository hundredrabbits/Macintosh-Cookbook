program ExampleClone;

 const
  size = 50;

 var
  a, b: Rect;

begin

 showDrawing;

 setRect(a, 0, size, size * 2, size * 3);
 paintArc(a, 0, 90);
 setRect(a, size, size, size * 2, size * 2);
 b := a;

 offsetRect(b, size, 0);
 copyBits(thePort^.portBits, thePort^.portBits, a, b, srcCopy, nil);
 offsetRect(b, 0, size);
 copyBits(thePort^.portBits, thePort^.portBits, a, b, srcCopy, nil);

 frameRect(b);

end.