program ExamplePolygon;

 var
  myPoly: PolyHandle;
  myPattern: Pattern;

begin

 ShowDrawing;

 myPoly := OpenPoly;
 MoveTo(30, 90);
 LineTo(30, 80);
 LineTo(50, 65);
 LineTo(90, 65);
 LineTo(80, 80);
 LineTo(95, 90);
 LineTo(30, 90);
 ClosePoly;

 FramePoly(myPoly);

 OffsetPoly(myPoly, 25, 15);
 PenSize(3, 2);
 ErasePoly(myPoly);
 FramePoly(myPoly);

 OffsetPoly(myPoly, 25, 15);
 PaintPoly(myPoly);

 OffsetPoly(myPoly, 25, 15);
 PaintPoly(myPoly);
 PenNormal;
 FillPoly(myPoly, gray);

 OffsetPoly(myPoly, 25, 15);
 FillPoly(myPoly, myPattern);
 FramePoly(myPoly);

 KillPoly(myPoly);

end.