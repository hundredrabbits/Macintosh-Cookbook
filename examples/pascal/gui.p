program Test;

 var
  w: WindowPtr; {A window to draw in}
  r: Rect; {The bounding box of the window}

begin

  {Create the window}
 SetRect(r, 50, 50, 200, 100);
 w := NewWindow(nil, r, '', true, plainDBox, WindowPtr(-1), false, 0);

  {Make it the current drawing port}
 SetPort(w);

  {Draw a string!}
 MoveTo(5, 20);
 DrawString('Hello world!');

  {Wait for a mouse-click, then stop.}
 while not Button do
  ;

end.