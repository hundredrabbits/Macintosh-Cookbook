program ExamplePatterns;

 var
  rblack, rdkgray, rgray, rltgray, rwhite: Rect;

begin

 ShowDrawing;
 SetRect(rblack, 10 + (50 * 0), 10, 10 + (50 * 1), 50);
 SetRect(rdkgray, 10 + (50 * 1), 10, 10 + (50 * 2), 50);
 SetRect(rgray, 10 + (50 * 2), 10, 10 + (50 * 3), 50);
 SetRect(rltgray, 10 + (50 * 3), 10, 10 + (50 * 4), 50);
 SetRect(rwhite, 10 + (50 * 4), 10, 10 + (50 * 5), 50);

 FillRect(rblack, black);
 FillRect(rdkgray, dkgray);
 FillRect(rgray, gray);
 FillRect(rltgray, ltgray);
 FillRect(rwhite, white);
 FrameRect(rblack);
 FrameRect(rdkgray);
 FrameRect(rgray);
 FrameRect(rltgray);
 FrameRect(rwhite);

end.