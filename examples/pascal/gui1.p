program ExampleGui1;

 var
  w: WindowPtr; {A window to draw in}
  r: Rect; {The bounding box of the window}

 procedure WindowInit;
 begin
  SetRect(r, 50, 50, 300, 100);
  w := NewWindow(nil, r, '', true, zoomDocProc, WindowPtr(-1), false, 0);
  SetPort(w);
 end;

 procedure MainLoop;
 begin
  TextSize(24);
  MoveTo(20, 20);
  DrawString('Hello world!');
  while (not Button) do
   begin
   end;
 end;

begin

 WindowInit;
 MainLoop;

end.