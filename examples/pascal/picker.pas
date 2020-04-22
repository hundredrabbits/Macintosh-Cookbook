program ExamplePicker;

 var
  Pt: Point;

 procedure PaintPatterns;
  var
   selection: Rect;
 begin
  SetRect(selection, 10 + (50 * 0), 10, 10 + (50 * 1), 50);
  FillRect(selection, black);
  FrameRect(selection);
  SetRect(selection, 10 + (50 * 1), 10, 10 + (50 * 2), 50);
  FillRect(selection, dkgray);
  FrameRect(selection);
  SetRect(selection, 10 + (50 * 2), 10, 10 + (50 * 3), 50);
  FillRect(selection, gray);
  FrameRect(selection);
  SetRect(selection, 10 + (50 * 3), 10, 10 + (50 * 4), 50);
  FillRect(selection, ltgray);
  FrameRect(selection);
  SetRect(selection, 10 + (50 * 4), 10, 10 + (50 * 5), 50);
  FillRect(selection, white);
  FrameRect(selection);
 end;

 procedure MainLoop;
 begin
  repeat {Until we double-click}
   GetMouse(Pt);
   while button do
    begin
     Writeln('pixel:', Pt.h : 4, ',', Pt.v : 4, '=', GetPixel(pt.h, pt.v));
     repeat {Tight loop until button up}
     until not Button;
    end;
  until 1 > 1; { forever}
 end;

begin

 ShowText;
 ShowDrawing;
 PaintPatterns;
 MainLoop;

end.