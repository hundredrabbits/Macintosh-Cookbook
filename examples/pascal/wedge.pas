program ExampleWedge;

 var
  whole, wedge: Rect;

begin

 ShowDrawing;
 
 SetRect(whole, 10, 10, 90, 90);
 PaintArc(whole, 0, 144);
 FillArc(whole, 144, 120, ltgray);
 FrameOval(whole);
 
end.