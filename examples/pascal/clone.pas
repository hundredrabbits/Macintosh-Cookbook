program ExampleClone;

 const
  size = 50;

 var
  a, b: Rect;

begin

 ShowDrawing;

 SetRect(a, 0, size, size * 2, size * 3);
 PaintArc(a, 0, 90);
 SetRect(a, size, size, size * 2, size * 2);
 b := a;

 OffSetRect(b, size, 0);
 CopyBits(thePort^.portBits, thePort^.portBits, a, b, srcCopy, nil);
 OffSetRect(b, 0, size);
 CopyBits(thePort^.portBits, thePort^.portBits, a, b, srcCopy, nil);

 FrameRect(b);

end.