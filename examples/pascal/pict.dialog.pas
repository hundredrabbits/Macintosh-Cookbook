program ExampleDrawingExport;

 var
  oval, clip: Rect;
  pic: PicHandle;
  err: OSErr;
  refNum: Integer;
  toWrite, bigZero: Longint;

 procedure Cleanup;
 begin
  if refNum <> -1 then
   begin
    err := FSClose(refNum);
    refNum := -1;
   end;
 end;

 procedure CheckError;
 begin
  if err = noErr then
   Exit(CheckError);
  ShowText;
  WriteLn('Error:', err);
  Cleanup;
  Halt;
 end;

 procedure PaintPicture;
 begin
  ShowDrawing;
  SetRect(oval, 20, 20, 80, 80);
  pic := OpenPicture(clip);
  FillOval(oval, ltgray);
  ClosePicture;
  DrawPicture(pic, clip);
 end;

 procedure CreateFile;
  var
   wher: Point; { where to display dialog }
   reply: SFReply;
   i: integer;
 begin
  wher.h := 20;
  wher.v := 20;
  SFPutFile(wher, 'Save the PICT as:', 'untitled', nil, reply);
  if reply.good then
   begin
    err := Create(reply.fname, reply.vrefnum, '????', 'PICT');
    if (err = noerr) | (err = dupfnerr) then
     begin
      err := FSOpen(reply.fname, reply.vrefnum, refNum);
      toWrite := SizeOf(Longint);
      for i := 1 to 512 div SizeOf(Longint) do
       err := FSWrite(refNum, toWrite, @bigZero);
      CheckError;
      toWrite := GetHandleSize(Handle(pic));
      HLock(Handle(pic));
      err := FSWrite(refNum, toWrite, Pointer(pic^));
      HUnlock(Handle(pic));

      CheckError;
      Cleanup;
      CheckError;

      KillPicture(pic);

      pic := nil;
     end;
   end;
 end;

begin

 bigZero := 0;
 SetRect(clip, 0, 0, 100, 100);

 PaintPicture;

 CreateFile;


end.
