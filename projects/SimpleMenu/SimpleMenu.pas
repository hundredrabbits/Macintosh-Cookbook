program SimpleMenu;

 const
  BASE_RES_ID = 400;
  INCLUDE_SECONDS = TRUE;
  SLEEP = 60;
  WNE_TRAP_NUM = $60;
  UNIMPL_TRAP_NUM = $9F;
  QUIT_ITEM = 1;
  ABOUT_ITEM = 1;
  APPLE_MENU_ID = BASE_RES_ID;
  FILE_MENU_ID = BASE_RES_ID + 1;
  EDIT_MENU_ID = BASE_RES_ID + 2;
  OPTIONS_MENU_ID = BASE_RES_ID + 3;
  ABOUT_ALERT = 400;

 var
  gClockWindow: WindowPtr;
  gDone, gWNEimplemented: BOOLEAN;
  gCurrentTime, gOldTime: LONGINT;
  gTheEvent: EventRecord;

{>>}
 procedure HandleAppleChoice (theItem: INTEGER);
  var
   accName: Str255;
   accNumber, itemNumber, dummy: INTEGER;
   appleMenu: MenuHandle;
 begin
  case theItem of
   ABOUT_ITEM: 
    dummy := NoteAlert(ABOUT_ALERT, nil);
   otherwise
    begin
     appleMenu := GetMHandle(APPLE_MENU_ID);
     GetItem(appleMenu, theItem, accName);
     accNumber := OpenDeskAcc(accName);
    end;
  end;
 end;

{>>}
 procedure HandleFileChoice (theItem: INTEGER);
 begin
  case theItem of
   QUIT_ITEM: 
    gDone := TRUE;
  end;
 end;

{>>}
 procedure HandleOptionsChoice (theItem: INTEGER);
  var
   fontNumber: INTEGER;
   fontName: Str255;
   fontMenu: MenuHandle;
 begin
  writeln(theItem);
 end;

{>>}
 procedure HandleMenuChoice (menuChoice: LONGINT);
  var
   theMenu, theItem: INTEGER;
 begin
  if menuChoice <> 0 then
   begin
    theMenu := HiWord(menuChoice);
    theItem := LoWord(menuChoice);
    case theMenu of
     APPLE_MENU_ID: 
      HandleAppleChoice(theItem);
     FILE_MENU_ID: 
      HandleFileChoice(theItem);
     OPTIONS_MENU_ID: 
      HandleOptionsChoice(theItem);
    end;
    HiliteMenu(0);
   end;
 end;

{>>}
 procedure HandleMouseDown;
  var
   whichWindow: WindowPtr;
   thePart: INTEGER;
   menuChoice, windSize: LONGINT;
 begin
  thePart := FindWindow(gTheEvent.where, whichWindow);
  case thePart of
   inMenuBar: 
    begin
     menuChoice := MenuSelect(gTheEvent.where);
     HandleMenuChoice(menuChoice);
    end;
   inSysWindow: 
    SystemClick(gTheEvent, whichWindow);
   inDrag: 
    DragWindow(whichWindow, gTheEvent.where, screenBits.bounds);
   inGoAway: 
    gDone := TRUE;
  end;
 end;

{>>}
 procedure DrawClock (theWindow: WindowPtr);
  var
   myTimeString: Str255;
 begin
  IUTimeString(gCurrentTime, INCLUDE_SECONDS, myTimeString);
  EraseRect(theWindow^.portRect);
  MoveTo(12, 25);
  DrawString(myTimeString);
  gOldTime := gCurrentTime;
 end;

{>>}
 procedure HandleNull;
 begin
  GetDateTime(gCurrentTime);
  if gCurrentTime <> gOldTime then
   DrawClock(gClockWindow);
 end;

{>>}
 procedure HandleEvent;
  var
   theChar: CHAR;
   dummy: BOOLEAN;
 begin
  if gWNEimplemented then
   dummy := WaitNextEvent(everyEvent, gTheEvent, SLEEP, nil)
  else
   begin
    SystemTask;
    dummy := GetNextEvent(everyEvent, gTheEvent);
   end;
  case gTheEvent.what of
   nullEvent: 
    HandleNull;
   mouseDown: 
    HandleMouseDown;
   keyDown, autoKey: 
    begin
     theChar := CHR(BitAnd(gTheEvent.message, charCodeMask));
     if (BitAnd(gTheEvent.modifiers, cmdKey) <> 0) then
      HandleMenuChoice(MenuKey(theChar));
    end;
   updateEvt: 
    begin
     BeginUpdate(WindowPtr(gTheEvent.message));
     EndUpdate(WindowPtr(gTheEvent.message));
    end;
  end;
 end;

{>>}
 procedure MainLoop;
 begin
  gDone := FALSE;
  gWNEimplemented := (NGetTrapAddress(WNE_TRAP_NUM, ToolTrap) <> NGetTrapAddress(UNIMPL_TRAP_NUM, ToolTrap));
  while (gDone = FALSE) do
   HandleEvent;
 end;

{>>}
 procedure MenuBarInit;
  var
   myMenuBar: Handle;
   aMenu: MenuHandle;
 begin
  myMenuBar := GetNewMBar(BASE_RES_ID);
  SetMenuBar(myMenuBar);
  DisposHandle(myMenuBar);
  aMenu := GetMHandle(APPLE_MENU_ID);
  AddResMenu(aMenu, 'DRVR');
  DrawMenuBar;
 end;

{>>}
 procedure Windowinit;
 begin
  gClockWindow := GetNewWindow(BASE_RES_ID, nil, WindowPtr(-1));
  SetPort(gClockWindow);
  ShowWindow(gClockWindow);
  TextSize(24);
 end;

begin

 Windowinit;
 MenuBarInit;
 DrawClock(gClockWindow);
 MainLoop;

end.

{ Resources needed: }
{ 1x WIND #400 }
{ 1x MBAR #400 4 options}
{ 1x MENU #400 -> Apple#400[about] File#401[quit] Edit#402[undo, cut, copy, paste, clear] Options#403[option1, option2] }
{ 1x ALRT #400 }
{ 1x DITL #400 }