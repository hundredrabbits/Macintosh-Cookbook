program ExampleGui;

 var
  w: WindowPtr; {A window to draw in}
  r: Rect; {The bounding box of the window}

begin

  {Create the window}
 SetRect(r, 50, 50, 300, 100);
 w := NewWindow(nil, r, '', true, zoomDocProc, WindowPtr(-1), false, 0);

  {Make it the current drawing port}
 SetPort(w);

  {Draw a string!}
 MoveTo(20, 20);
 DrawString('Hello world!');

  {Wait for a mouse-click, then stop.}
 while not Button do
  ;

end.

{ window types }
{ documentProc: movable, sizable window, no zoom box }
{ dBoxProc: alert box or modal dialog box }
{ plainDBox: plain box }
{ altDBoxProc: plain box with shadow }
{ noGrowDocProc: movable window, no size box or zoom box }
{ movableDBoxProc: movable modal dialog box }
{ zoomDocProc: standard document window }
{ zoomNoGrow: zoomable, nonresizable window }