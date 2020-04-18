program ExamplePatterns;

 var
  rblack, rdkgray, rgray, rltgray, rwhite: Rect;

begin

 ShowDrawing;
 setRect(rblack, 10 + (50 * 0), 10, 10 + (50 * 1), 50);
 setRect(rdkgray, 10 + (50 * 1), 10, 10 + (50 * 2), 50);
 setRect(rgray, 10 + (50 * 2), 10, 10 + (50 * 3), 50);
 setRect(rltgray, 10 + (50 * 3), 10, 10 + (50 * 4), 50);
 setRect(rwhite, 10 + (50 * 4), 10, 10 + (50 * 5), 50);

 fillRect(rblack, black);
 fillRect(rdkgray, dkgray);
 fillRect(rgray, gray);
 fillRect(rltgray, ltgray);
 fillRect(rwhite, white);
 frameRect(rblack);
 frameRect(rdkgray);
 frameRect(rgray);
 frameRect(rltgray);
 frameRect(rwhite);

end.