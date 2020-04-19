program EventTutor;

 const
  BASE_RES_ID = 400;
  LEAVE_WHERE_IT_IS = FALSE;
  NORMAL_UPDATES = TRUE;
  SLEEP = 60;
  WNE_TRAP_NUM = $60;
  UNIMPL_TRAP_NUM = $9F;
  SUSPEND_RESUME_BIT = $0001;
  ACTIVATING = 1;
  RESUMING = 1;
  TEXT_FONT_SIZE = 12;
  DRAG_THRESHOLD = 30;
  MIN_WINDOW_HEIGHT = 50;
  MIN_WINDOW_WIDTH = 50;
  SCROLL_BAR_PIXELS = 15;
  ROWHEIGHT = 15;
  LEFTMARGIN = 10;
  STARTROW = 0;
  HORIZONTAL_OFFSET = 0;

 var
  gPictWindow, gEventWindow: WindowPtr;
  gTheEvent: EventRecord;
  gSizeRect: Rect;
  gDone, gWNEimplemented: BOOLEAN;
  gCurRow, gMaxRow: INTEGER;

{>>}
 procedure CenterPict (thePicture: PicHandle; var myRect: Rect);
  var
   windRect, pictureRect: Rect;
 begin
  windRect := myRect;
  pictureRect := thePicture^^.picFrame;
  myRect.top := (windRect.bottom - windRect.top - (pictureRect.bottom - pictureRect.top)) div 2 + windRect.top;
  myRect.bottom := myRect.top + (pictureRect.bottom - pictureRect.top);
  myRect.left := (windRect.right - windRect.left - (pictureRect.right - pictureRect.left)) div 2 + windRect.left;
  myRect.right := myRect.left + (pictureRect.right - pictureRect.left);
 end;

{>>}
 procedure DrawMyPicture (drawingWindow: WindowPtr);
  var
   drawingClipRect, myRect: Rect;
   oldPort: GrafPtr;
   tempRgn: RgnHandle;
   thePicture: PicHandle;
 begin
  GetPort(oldPort);
  SetPort(drawingWindow);
  tempRgn := NewRgn;
  GetClip(tempRgn);
  EraseRect(drawingWindow^.portRect);
  DrawGrowicon(drawingWindow);
  drawingClipRect := drawingWindow^.portRect;
  drawingClipRect.right := drawingClipRect.right - SCROLL_BAR_PIXELS;
  drawingClipRect.bottom := drawingClipRect.bottom - SCROLL_BAR_PIXELS;
  myRect := drawingWindow^.portRect;
  thePicture := GetPicture(BASE_RES_ID);
  CenterPict(thePicture, myRect);
  ClipRect(drawingClipRect);
  DrawPicture(thePicture, myRect);
  SetClip(tempRgn);
  DisposeRgn(tempRgn);
  SetPort(oldPort);
 end;

{>>}
 procedure HandleMouseDown;
  var
   whichWindow: WindowPtr;
   thePart: INTEGER;
   windSize: LONGINT;
   oldPort: GrafPtr;
 begin
  thePart := FindWindow(gTheEvent.where, whichWindow);
  case thePart of
   inSysWindow: 
    SystemClick(gTheEvent, whichWindow);
   inDrag: 
    DragWindow(whichWindow, gTheEvent.where, screenBits.bounds);
   inContent: 
    if whichWindow <> FrontWindow then
     SelectWindow(whichWindow);
   inGrow: 
    begin
     windSize := GrowWindow(whichWindow, gTheEvent.where, gSizeRect);
     if (windSize <> 0) then
      begin
       GetPort(oldPort);
       SetPort(whichWindow);
       EraseRect(whichWindow^.portRect);
       SizeWindow(whichWindow, LoWord(windSize), HiWord(windSize), NORMAL_UPDATES);
       InvalRect(whichWindow^.portRect);
       SetPort(oldPort);
      end;
    end;
   inGoAway: 
    gDone := TRUE;
   inZoomIn, inZoomOut: 
    if TrackBox(whichWindow, gTheEvent.where, thePart) then
     begin
      GetPort(oldPort);
      SetPort(whichWindow);
      EraseRect(whichWindow^.portRect);
      ZoomWindow(whichWindow, thePart, LEAVE_WHERE_IT_IS);
      InvalRect(whichWindow^.portRect);
      SetPort(oldPort);
     end;
  end;
 end;

{>>}
 procedure ScrollWindow;
  var
   tempRgn: RgnHandle;
 begin
  tempRgn := NewRgn;
  ScrollRect(gEventWindow^.portRect, HORIZONTAL_OFFSET, -ROWHEIGHT, tempRgn);
  DisposeRgn(tempRgn);
 end;

{>>}
 procedure DrawEventString (s: Str255);
 begin
  if (gCurRow > gMaxRow) then
   ScrollWindow
  else
   gCurRow := gCurRow + ROWHEIGHT;
  MoveTo(LEFTMARGIN, gCurRow);
  DrawString(s);
 end;

{>>}
 procedure HandleEvent;
  var
   gotOne: BOOLEAN;
 begin
  if gWNEimplemented then
   gotOne := WaitNextEvent(everyEvent, gTheEvent, SLEEP, nil)
  else
   begin
    SystemTask;
    gotOne := GetNextEvent(everyEvent, gTheEvent);
   end;
  if gotOne then
   case gTheEvent.what of
    nullEvent: 
     begin
     end;
    mouseDown: 
     begin
      DrawEventString('mouseDown');
      HandleMouseDown;
     end;
    mouseUp: 
     DrawEventString('mouseUp');
    keyDown: 
     DrawEventString('keyDown');
    keyUp: 
     DrawEventString('keyUp');
    autoKey: 
     DrawEventString('autoKey');
    updateEvt: 
     if (WindowPtr(gTheEvent.message) = gPictWindow) then
      begin
       DrawEventString('updateEvt: gPictWindow');
       BeginUpdate(WindowPtr(gTheEvent.message));
       DrawMyPicture(WindowPtr(gTheEvent.message));
       EndUpdate(WindowPtr(gTheEvent.message));
      end
     else
      begin
       DrawEventString('updateEvt:gEventWindow ');
       BeginUpdate(WindowPtr(gTheEvent.message));
       EndUpdate(WindowPtr(gTheEvent.message));
      end;
    diskEvt: 
     DrawEventString('diskEvt');
    activateEvt: 
     if (WindowPtr(gTheEvent.message) = gPictWindow) then
      begin
       DrawGrowicon(WindowPtr(gTheEvent.message));
       if (BitAnd(gTheEvent.modifiers, activeFlag) = ACTIVATING) then
       DrawEventString('activateEvt: activating gPictWindow')
       else
       DrawEventString('activateEvt: deactivating gPictWindow');
      end
     else
      begin
       if (BitAnd(gTheEvent.modifiers, activeFlag) = ACTIVATING) then
       DrawEventString('activateEvt: activating gEventWindow')
       else
       DrawEventString('activateEvt: deactivating gEventWindow');
      end;
    networkEvt: 
     DrawEventString('networkEvt');
    driverEvt: 
     DrawEventString('driverEvt');
    app1Evt: 
     DrawEventString('app1Evt');
    app2Evt: 
     DrawEventString('app2Evt');
    app3Evt: 
     DrawEventString('app3Evt');
    app4Evt: 
     if (BitAnd(gTheEvent.message, SUSPEND_RESUME_BIT) = RESUMING) then
      DrawEventString('Resume event')
     else
      DrawEventString('Suspend event');
   end;
 end;

{>>}
 procedure MainLoop;
 begin
  gDone := FALSE;
  gWNEimplemented := (NGetTrapAddress(WNE_TRAP_NUM, ToolTrap) <> NGetTrapAddress(UNIMPL_TRAP_NUM, ToolTrap));
  while gDone = FALSE do
   HandleEvent;
 end;

{>>}
 procedure SetUpSizeRect;
 begin
  gSizeRect.top := MIN_WINDOW_HEIGHT;
  gSizeRect.left := MIN_WINDOW_WIDTH;
  gSizeRect.bottom := 32767;
  gSizeRect.right := 32767;
 end;

{>>}
 procedure SetupEventWindow;
  var
   eventRect: Rect;
   fontNum: INTEGER;
 begin
  eventRect := gEventWindow^.portRect;
  gMaxRow := eventRect.bottom - eventRect.top - ROWHEIGHT;
  gCurRow := STARTROW;
  SetPort(gEventWindow);
  GetFNum('monaco', fontNum);
  TextFont(fontNum);
  TextSize(TEXT_FONT_SIZE);
 end;

{>>}
 procedure Windowinit;
 begin
  gPictWindow := GetNewWindow(BASE_RES_ID, nil, WindowPtr(-1));
  gEventWindow := GetNewWindow(BASE_RES_ID + 1, nil, WindowPtr(-1));
  SetupEventWindow;
  ShowWindow(gEventWindow);
  ShowWindow(gPictWindow);
 end;

begin

 Windowinit;
 SetUpSizeRect;
 Mainloop;

end.

{ note: This projects needs 2 WIND resources with id 400 and 401, and a PICT resource with id 400 }