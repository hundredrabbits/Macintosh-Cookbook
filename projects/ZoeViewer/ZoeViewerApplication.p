program SimpleMenu;

 var
  inputRefNum: Integer;
  outputRefNum: Integer;
  err: OSErr;

{ Output ----------------------------------------- }

 var
  pic: PicHandle;

 procedure CleanupOutput;
 begin
  if outputRefNum <> -1 then
   begin
    err := FSClose(outputRefNum);
    outputRefNum := -1;
   end;
 end;

 procedure CheckErrorOutput;
 begin
  if err = noErr then
   Exit(CheckErrorOutput);
  ShowText;
  WriteLn('Error:', err);
  CleanupOutput;
  Halt;
 end;

 procedure SelectOutputFile;
  var
   wher: Point; { where to display dialog }
   reply: SFReply;
   toWrite, bigZero: Longint;
   i: integer;
 begin
  wher.h := 20;
  wher.v := 20;
  SFPutFile(wher, 'Save the PICT as:', 'untitled.pict', nil, reply);
  if reply.good then
   begin
    err := Create(reply.fname, reply.vrefnum, '????', 'PICT');
    if (err = noerr) | (err = dupfnerr) then
     begin
      err := FSOpen(reply.fname, reply.vrefnum, outputRefNum);
      bigZero := 0;
      toWrite := SizeOf(Longint);
      for i := 1 to 512 div SizeOf(Longint) do
       err := FSWrite(outputRefNum, toWrite, @bigZero);
      CheckErrorOutput;
      toWrite := GetHandleSize(Handle(pic));
      HLock(Handle(pic));
      err := FSWrite(outputRefNum, toWrite, Pointer(pic^));
      HUnlock(Handle(pic));
      CheckErrorOutput;
      CleanupOutput;
      CheckErrorOutput;
      KillPicture(pic);
      pic := nil;
     end;
   end;
 end;


{ Input ----------------------------------------- }

 var
  contents: Ptr;
  fileSize, thisRead: Longint;

{>>}
 procedure CloseFile;
 begin
  if inputRefNum = -1 then
   Exit(CloseFile);
  err := FSClose(inputRefNum);
  if err <> 0 then
   WriteLn('FSClose error:', err);
  inputRefNum := -1;
 end;

{>>}
 procedure Cleanup;
 begin
  CloseFile;
  if contents <> nil then
   begin
    DisposePtr(Pointer(contents));
    contents := nil;
   end;
 end;

{>>}
 procedure CleanupAndHalt;
 begin
  Cleanup;
  Halt;
 end;

{>>}
 procedure SelectInputFile;
  var
   reply: SFReply;
   totalRead: Longint;
   pnt: Point;
 begin
  inputRefNum := -1;
  totalRead := 0;
  contents := nil;
  SetPt(pnt, 0, 0);
  SFGetFile(pnt, 'Pick a ZOE file:', nil, -1, nil, nil, reply);
  if not reply.good then
   Halt;
  err := FSOpen(reply.fName, reply.vRefNum, inputRefNum);
  if err <> 0 then
   begin
    WriteLn('FSOpen error:', err);
    CleanupAndHalt;
   end;
  err := GetEOF(inputRefNum, fileSize);
  if err <> 0 then
   begin
    WriteLn('GetEOF error:', err);
    CleanupAndHalt;
   end;
  if fileSize < 4 then
   begin
    WriteLn('File too small');
    CleanupAndHalt;
   end;
  contents := NewPtr(fileSize);
  if contents = nil then
   begin
    WriteLn('Couldn'' t allocate buffer');
    CleanupAndHalt;
   end;
  repeat
   thisRead := fileSize - totalRead;
   err := FSRead(inputRefNum, thisRead, Pointer(Longint(contents) + totalRead));
   if err <> 0 then
    begin
     WriteLn('File read error:', err);
     CleanupAndHalt;
    end;
   totalRead := totalRead + thisRead;
   if totalRead >= fileSize then
    Leave;
  until False;
 end;

{>>}
 procedure DrawFile (contents: Ptr; fileSize: Longint);
  var
   bmap: BitMap;
   headerPtr: ^Longint;
   header: Longint;
   width, height: Integer;
   viewer, clip: Rect;
 begin
  bmap.baseAddr := nil;
  headerPtr := Pointer(contents);
  header := headerPtr^;
  if BitAnd(header, $FFFFFF00) <> $5a4f4500 then
   begin
    WriteLn('Header mismatch');
    CleanupAndHalt;
   end;
  width := Integer(BitAnd(header, $000000FF));
  height := (fileSize - 4) div width;
  SetRect(bmap.bounds, 0, 0, width * 8, height);
  SetRect(viewer, 60, 60, width * 8 + 15, height + 75);
  SetDrawingRect(viewer);
  bmap.rowBytes := width;
  bmap.baseAddr := Pointer(Longint(contents) + 4);
  SetRect(clip, 0, 0, 512, 342);
  pic := OpenPicture(clip);
  CopyBits(bmap, thePort^.portBits, bmap.bounds, bmap.bounds, srcCopy, nil);
  ClosePicture;
  DrawPicture(pic, clip);
  Cleanup;
 end;


{ Window ---------------------------------------- }

 var
  windowRect: Rect;
  window: WindowPtr;
  gDone, gWNEimplemented: BOOLEAN;
  gCurrentTime, gOldTime: LONGINT;
  gTheEvent: EventRecord;

{>>}
 procedure DoOpenFile;
 begin
  SelectInputFile;
  DrawFile(contents, fileSize);
 end;

{>>}
 procedure DoSaveFile;
 begin
  SelectOutputFile;
 end;

{>>}
 procedure HandleAppleChoice (theItem: INTEGER);
  var
   accName: Str255;
   accNumber, itemNumber, dummy: INTEGER;
   appleMenu: MenuHandle;
 begin
  case theItem of
   1: 
    dummy := NoteAlert(400, nil);
   otherwise
    begin
     appleMenu := GetMHandle(400);
     GetItem(appleMenu, theItem, accName);
     accNumber := OpenDeskAcc(accName);
    end;
  end;
 end;

{>>}
 procedure HandleFileChoice (theItem: INTEGER);
 begin
  case theItem of
   1: {open}
    DoOpenFile;
   2: {save}
    DoSaveFile;
   3: {quit}
    gDone := TRUE;
  end;
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
     400: {apple menu}
      HandleAppleChoice(theItem);
     401: {file menu}
      HandleFileChoice(theItem);
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
 procedure HandleNull;
 begin
  GetDateTime(gCurrentTime);
  if gCurrentTime <> gOldTime then
   Writeln('something');
 end;

{>>}
 procedure HandleEvent;
  var
   theChar: CHAR;
   dummy: BOOLEAN;
 begin
  if gWNEimplemented then
   dummy := WaitNextEvent(everyEvent, gTheEvent, 60, nil)
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
  gWNEimplemented := (NGetTrapAddress($60, ToolTrap) <> NGetTrapAddress($9F, ToolTrap));
  while (gDone = FALSE) do
   HandleEvent;
 end;

{>>}
 procedure MenuBarInit;
  var
   myMenuBar: Handle;
   aMenu: MenuHandle;
 begin
  myMenuBar := GetNewMBar(400);
  SetMenuBar(myMenuBar);
  DisposHandle(myMenuBar);
  aMenu := GetMHandle(400);
  AddResMenu(aMenu, 'DRVR');
  DrawMenuBar;
 end;

{>>}
 procedure Windowinit;
 begin
  SetRect(windowRect, 50, 50, 520 + 50, 342 + 50);
  window := NewWindow(nil, windowRect, 'ZOE', true, zoomDocProc, WindowPtr(-1), false, 0);
  SetPort(window);
  ShowWindow(window);
  TextSize(24);
 end;

begin

 Windowinit;
 MenuBarInit;
 MainLoop;

end.

{ Resources needed: }
{ 1x WIND #400 }
{ 1x MBAR #400 4 options}
{ 1x MENU #400 -> Apple#400[about] File#401[open, save, quit] Edit#402[undo, cut, copy, paste, clear] }
{ 1x ALRT #400 }
{ 1x DITL #400 }