program ExampleGui2;

 const
  everyEvent = 8; { Exit on key}

 var
  w: WindowPtr; {A window to draw in}
  r: Rect; {A window Size}
  gTheEvent: EventRecord;
  gDone: BOOLEAN;

 procedure WindowInit;
 begin
  SetRect(r, 50, 50, 300, 100);
  w := NewWindow(nil, r, '', true, zoomDocProc, WindowPtr(-1), false, 0);
  SetPort(w);
 end;

 procedure HandleEvent;
  var
   gotOne: BOOLEAN;
 begin
  SystemTask;
  gotOne := GetNextEvent(everyEvent, gTheEvent);
  if gotOne then
   begin
    gDone := TRUE;
   end;
 end;

 procedure MainLoop;
 begin
  gDone := FALSE;
  while gDone = FALSE do
   HandleEvent;
 end;

begin

 WindowInit;
 MainLoop;

end.

{ mDownMask 2 }
{ mUpMask 4 }
{ keyDownMask 8 }
{ keyUpMask 16 }
{ autoKeyMask 32 }
{ updateMask 64 }
{ diskMask 128 }
{ activMask 256 }
{ networkMask 1024 }
{ driverMask 2048 }
{ app1 Mask4096 }
{ app2Mask 8192 }
{ app3Mask 16384 }
{ app4Mask =32768 }
{ everyEvent =1  }