program Showing_Cursors (input, output);

 type
  Port = GrafPtr;
  Rect_Table = array[1..3] of Rect;
 var
  Rectangle: Rect_Table;
  Window: Port;
  J: Integer;
  Area: array[1..3] of RgnHandle;
  Smile, Frown, Justso: Cursor;
  Mousepoint: Point;

 procedure Open_Window (var Viewport: Port);
 begin
  new(Viewport);
  OpenPort(Viewport)
 end;

 procedure Initialize_Rectangles (var Box: Rect_Table);
 begin
  SetRect(Box[1], 0, 0, 512, 342);
  SetRect(Box[2], 40, 40, 250, 250);
  SetRect(Box[3], 300, 120, 500, 320);
 end;

 procedure Dispose_of_Window (var Viewport: Port);
 begin
  ClosePort(Viewport);
  Dispose(Viewport)
 end;

 procedure Pushbutton;
  var
   Time: Longint;
 begin

  while not Button do { nothing }
   ;
  Delay(10, Time);
 end;

begin

 HideAll;
 HideCursor;

{ Initialize the data arrays for the three cursors. }

 Smile.data[0] := 1;
 Smile.data[1] := -32767;
 Smile.data[2] := -32767;
 Smile.data[3] := -26599;
 Smile.data[4] := -26599;
 Smile.data[5] := -32767;
 Smile.data[6] := -32767;
 Smile.data[7] := -32511;
 Smile.data[8] := -31871;
 Smile.data[9] := -32511;
 Smile.data[10] := -28655;
 Smile.data[11] := -30687;
 Smile.data[12] := -31679;
 Smile.data[13] := -31871;
 Smile.data[14] := -32767;
 Smile.data[15] := -1;
 Smile.hotspot.v := 8;
 Smile.hotspot.h := 8;
 Frown.data[0] := -1;
 Frown.data[1] := -32767;
 Frown.data[2] := -32767;
 Frown.data[3] := -26599;
 Frown.data[4] := -26599;
 Frown.data[5] := -32767;
 Frown.data[6] := -32767;
 Frown.data[7] := -32511;
 Frown.data[8] := -31871;
 Frown.data[9] := -32511;
 Frown.data[10] := -32767;
 Frown.data[11] := -31871;
 Frown.data[12] := -31679;
 Frown.data[13] := -30687;
 Frown.data[14] := -32767;
 Frown.data[15] := -1;
 Frown.hotspot.v := 8;
 Frown.hotspot.h := 8;
 Justso.data[0] := -1;
 Justso.data[1] := -32767;
 Justso.data[2] := -32767;
 Justso.data[3] := -26599;
 Justso.data[4] := -26599;
 Justso.data[5] := -32767;
 Justso.data[6] := -32767;
 Justso.data[7] := -32511;
 Justso.data[8] := -31871;
 Justso.data[9] := -32511;
 Justso.data[10] := -32767;
 Justso.data[11] := -32767;
 Justso.data[12] := -24591;
 Justso.data[13] := -32767;
 Justso.data[14] := -32767;
 Justso.data[15] := -1;
 Justso.hotspot.v := 8;
 Justso.hotspot.h := 8;

{ Initialize the three rectangles. }

 Initialize_Rectangles(Rectangle);

 for J := 1 to 3 do
  Area[J] := NewRgn;

 Open_Window(Window);

 PenSize(2, 2);

{ Establish each of the three regions. }

 begin { first region }
  OpenRgn;
  FrameRect(Rectangle[1]);
  CloseRgn(Area[1]);
  FillRgn(Area[1], white);
 end;
 begin { second region }
  OpenRgn;
  FrameRoundRect(Rectangle[2], 90, 90);
  CloseRgn(Area[2]);
  FrameRgn(Area[2]);
  MoveTo(100, 200);
  DrawString('Happy Region');
 end;
 begin { third region }
  OpenRgn;
  FrameOval(Rectangle[3]);
  CloseRgn(Area[3]);
  FrameRgn(Area[3]);
  MoveTo(360, 280);
  DrawString('Sad Region');
 end;

{ Prompt the user to continue. }
 MoveTo(266, 50);
 Drawstring(' Press mouse button to stop: ');

{ Establish a new cursor, and then obscure the new cursor until }
{ the mouse is moved. }
 SetCursor(Justso);
 ShowCursor;
 ObscureCursor;
 while not button do
  begin
   GetMouse(Mousepoint);
   if PtInRgn(Mousepoint, Area[2]) then
    SetCursor(Smile)
   else if PtinRgn(Mousepoint, Area[3]) then
    SetCursor(Frown)
   else
    SetCursor(Justso);
  end;

{ Erase the complete screen with a gray background. }
 BackPat(gray);
 EraseRgn(Area[1]);

{ Dispose of storage for the window and the areas. }
 Dispose_of_Window(Window);
 for J := 1 to 3 do
  DisposeRgn(Area[J]);
  
end.