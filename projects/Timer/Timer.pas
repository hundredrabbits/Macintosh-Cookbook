program Timer;

 const
  BASE_RES_ID = 400;
  PLAIN = [];
  PLAIN_ITEM = 1;
  BOLD_ITEM = 2;
  ITALIC_ITEM = 3;
  UNDERLINE_ITEM = 4;
  OUTLINE_ITEM = 5;
  SHADOW_ITEM = 6;

  INCLUDE_SECONDS = TRUE;

  ADD_CHECK_MARK = TRUE;
  REMOVE_CHECK_MARK = FALSE;

  DRAG_THRESHOLD = 30;

  SLEEP = 60;
  WNE_TRAP_NUM = $60;
  UNIMPL_TRAP_NUM = $9F;

  QUIT_ITEM = 1;
  ABOUT_ITEM = 1;

  NOT_A_NORMAL_MENU = -1;
  APPLE_MENU_ID = BASE_RES_ID;
  FILE_MENU_ID = BASE_RES_ID + 1;
  FONT_MENU_ID = 100;
  STYLE_MENU_ID = 101;

  CLOCK_LEFT = 12;
  CLOCK_TOP = 25;
  CLOCK_SIZE = 24;

  ABOUT_ALERT = 400;

 var
  gClockWindow: WindowPtr;
  gDone, gWNEimplemented: BOOLEAN;
  gCurrentTime, gOldTime: LONGINT;
  gTheEvent: EventRecord;
  gLastFont: INTEGER;
  gCurrentStyle: Style;

{>>}
 procedure CheckStyles;
  var
   styleMenu: MenuHandle;
 begin
  styleMenu := GetMHandle(STYLE_MENU_ID);
  Checkitem(styleMenu, PLAIN_ITEM, (gCurrentStyle = PLAIN));
  Checkitem(styleMenu, BOLD_ITEM, (bold in gCurrentStyle));
  Checkitem(styleMenu, ITALIC_ITEM, (italic in gCurrentStyle));
  Checkitem(styleMenu, UNDERLINE_ITEM, (underline in gCurrentStyle));
  Checkitem(styleMenu, OUTLINE_ITEM, (outline in gCurrentStyle));
  Checkitem(styleMenu, SHADOW_ITEM, (shadow in gCurrentStyle));
 end;

{>>}
 procedure HandleStyleChoice (theitem: INTEGER);
 begin
  case theitem of
   PLAIN_ITEM: 
    gCurrentStyle := PLAIN;
   BOLD_ITEM: 
    if bold in gCurrentStyle then
     gCurrentStyle := gCurrentStyle - [bold]
    else
     gCurrentStyle := gCurrentStyle + [bold];
   ITALIC_ITEM: 
    if italic in gCurrentStyle then
     gCurrentStyle := gCurrentStyle - [italic]
    else
     gCurrentStyle := gCurrentStyle + [italic];
   UNDERLINE_ITEM: 
    if underline in gCurrentStyle then
     gCurrentStyle := gCurrentStyle - [underline]
    else
     gCurrentStyle := gCurrentStyle + [underline];
   OUTLINE_ITEM: 
    if outline in gCurrentStyle then
     gCurrentStyle := gCurrentStyle - [outline]
    else
     gCurrentStyle := gCurrentStyle + [outline];
   SHADOW_ITEM: 
    if shadow in gCurrentStyle then
     gCurrentStyle := gCurrentStyle - [shadow]
    else
     gCurrentStyle := gCurrentStyle + [shadow];
  end;
  CheckStyles;
  TextFace(gCurrentStyle);
 end;

{>>}
 procedure HandleFontChoice (theItem: INTEGER);
  var
   fontNumber: INTEGER;
   fontName: Str255;
   fontMenu: MenuHandle;
 begin
  fontMenu := GetMHandle(FONT_MENU_ID);
  CheckItem(fontMenu, glastFont, REMOVE_CHECK_MARK);
  CheckItem(fontMenu, theItem, ADD_CHECK_MARK);
  gLastFont := theItem;
  GetItem(fontMenu, theItem, fontName);
  GetFNum(fontName, fontNumber);
  TextFont(fontNumber);
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
 procedure HandleMenuChoice (menuChoice: LONGINT);
  var
   theMenu, theitem: INTEGER;
 begin
  if menuChoice <> 0 then
   begin
    theMenu := HiWord(menuChoice);
    theitem := LoWord(menuChoice);
    case theMenu of
     APPLE_MENU_ID: 
      HandleAppleChoice(theItem);
     FILE_MENU_ID: 
      HandleFileChoice(theItem);
     FONT_MENU_ID: 
      HandleFontChoice(theItem);
     STYLE_MENU_ID: 
      HandleStyleChoice(theItem);
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
  MoveTo(CLOCK_LEFT, CLOCK_TOP);
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
  aMenu := GetMenu(FONT_MENU_ID);
  InsertMenu(aMenu, NOT_A_NORMAL_MENU);
  AddResMenu(aMenu, 'FONT');
  aMenu := GetMenu(STYLE_MENU_ID);
  InsertMenu(aMenu, NOT_A_NORMAL_MENU);
  Checkitem(aMenu, PLAIN_ITEM, TRUE);
  DrawMenuBar;
  gLastFont := 1;
  gCurrentStyle := PLAIN;
  HandleFontChoice(gLastFont);
 end;

{>>}
 procedure Windowinit;
 begin
  gClockWindow := GetNewWindow(BASE_RES_ID, nil, WindowPtr(-1));
  SetPort(gClockWindow);
  ShowWindow(gClockWindow);
  TextSize(CLOCK_SIZE);
 end;

begin

 Windowinit;
 MenuBarInit;
 DrawClock(gClockWindow);
 MainLoop;

end.