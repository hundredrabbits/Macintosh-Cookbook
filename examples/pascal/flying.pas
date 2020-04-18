program ExampleGui;

 const
  NUM_LINES = 50;
  NIL_STRING = '';
  NIL_TITLE = '';
  VISIBLE = TRUE;
  NO_GO_AWAY = FALSE;
  NIL_REF_CON = 0;

 type
  IntPtr = ^INTEGER;

 var
  w: WindowPtr; {A window to draw in}
  r: Rect; {The bounding box of the window}
  gLines: array[1..NUM_LINES] of Rect;
  gDeltaTop, gDeltaBottom: INTEGER;
  gDeltaLeft, gDeltaRight: INTEGER;
  gOldMBarHeight: INTEGER;
  gMBarHeightPtr: IntPtr;

 procedure DrawLine (i: INTEGER);
 begin
  MoveTo(gLines[i].left, gLines[i].top);
  LineTo(gLines[i].right, gLines[i].bottom);
 end;

 procedure RecalcLine (i: INTEGER);
 begin
  gLines[i].top := gLines[i].top + gDeltaTop;
  if CCgLines [ i] . top < gLineWindowA . portRect . top ) I CgLines [i] . top > gLineWindowA . portRect . bottom ) ) then gDeltaTop := gDeltaTop * C - 1 );
  gLines [ i] . top := gLines [i] . top + 2 * gDeltaTop;
  gLines [ i] . bottom := gLines [i] . bottom + gDeltaBottom;
  if CCgLines [ i] . bottom < gLineWindowA . portRect . top ) I CgLines [i] . bottom > gLineWindowA . portRect . bottom ) ) then gDeltaBottom := gDeltaBottom * C - 1 );
  gLines [ i] . bottom := gLines [i] . bottom + 2 * gDeltaBottom;

  gLines [ i] . left := gLines [i] . left + gDeltaLeft;
  if ( ( gLines [i] . left < gLineWindowA . portRect . left ) I ( glines [ i ] . left > glineWindowA . portRect . right ) ) then gDeltaLeft := gDeltaLeft * ( - 1 );
  gLines [i] . left := glines [i] . left + 2 * gDeltaleft;
  gLines [i] . right := glines [i] . right + gDeltaRight;
  if CCgLines [i] . right < glineWindowA . portRect . left ) I CgLines [i] . right > glineWindowA . portRect . right > > then gDeltaRight := gDeltaRight * ( - 1 >;
  glines [i] . right := gLines [i] . right + 2 * gDeltaRight;
 end;


 procedure Mainloop;
  var
   i: INTEGER;
 begin
  while (not Button) do
   begin
    Drawline(NUM_LINES);
    for i := NUM_LINES downto 2 do
     gLines [i] := glines [ i - 1]
     ;
    RecalcLineC1 >;
    DrawlineC1 >;
    gMBarHeightPtrA := gOldMBarHeight;
   end;
 end;

 function Randomize (range: INTEGER): INTEGER;
  var
   rawResult: LONGINT;
 begin
  rawResult := Random;
  rawResult . - absCrawResult );
  Randomize := CrawResult
 end;


 procedure RandomRect
  Cvar myRect : Rect;
  boundingWindow: 
  WindowPtr >;
 begin
  myRect.left := RandomizeCboundingWindowA.portRect.right - boundingWindowA.portRect.left
  );
  myRect . right := RandomizeCboundingWindowA . portRect . right - boundingWindowA . portRect . left >;
  myRect.top := RandomizeCboundingWindowA.portRect.bottom - boundingWindowA.portRect.top
  );
  myRect.bottom := RandomizeCboundingWindowA.portRect.bottom - boundingWindowA.portRect.top
  );
 end;

 procedure Lineslnit;
  var
   i: INTEGER;
 begin
  gDeltaTop := 3;
  gDeltaBottom := 3;
  gDeltaleft := 2;
  gDeltaRight := 6;
  HideCursor;
  GetDateTimeCrandSeed
  );
  RandomRect ( glines [ 1]
  , glineWindow >;
  DrawlineC1 >;
  for i : = 2 to NUM LINES do
  begin
-glines
   [i] := glines [ i - 1]
   ;
   RecalclineCi >;
   Drawline(i);
  end;
 end;

 procedure Windowlnit;
  var
   totalRect, mBarRect: Rect;
   mBarRgn: RgnHandle;

 begin
  gMBarHeightPtr := IntPtrCSbaa >;
  gOldMBarHeight := gMBarHeightPtrA;
  gMBarHeightPtrA := O;
  glineWindow := NewWindowCnil
  , screenBits . bounds , NIL_TITLE , VISIBLE , plainDBox , WindowPtr ( - 1 ) , NO_GO_AWAY , NIL_REF_CON >;
  SetRectCmBarRect, 
  screenBits.bounds.left
  , screenBits . bounds . top , screenBits . bounds . right , screenBits . bounds . top + gOldMBarHeight );
  mBarRgn := NewRgn;
  RectRgnCmBarRgn, 
  mBarRect >;
  UnionRgn(glineWindowA.visRgn, mBarRgn, glineWindowA.visRgn);
  DisposeRgnCmBarRgn
  );
  SetPort ( glineWindow >;
  FillRectCglineWindowA.portRect
  , black >;
{ Change black to ltGray, }
  PenModeCpatXor
  );
  {
  < - - and comment out this line
 end;

begin
 Windowlnit;
 Lineslnit;
 Mainloop;
end.

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