program ExampleDrawingExport;

 var
  pic: PicHandle;
  err: OSErr;
  refNum: Integer;

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
  var
   clip, oval: rect;
 begin
  ShowDrawing;
  SetRect(clip, 0, 0, 100, 100);
  SetRect(oval, 20, 20, 80, 80);
  pic := OpenPicture(clip);
  FillOval(oval, ltgray);
  ClosePicture;
  DrawPicture(pic, clip);
 end;

 procedure WriteFile;
  var
   toWrite, bigZero: Longint;
   i: integer;
 begin
  bigZero := 0;
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

 procedure CreateFile;
  var
   wher: Point; { where to display dialog }
   reply: SFReply;
 begin
  wher.h := 20;
  wher.v := 20;
  SFPutFile(wher, 'Save the PICT as:', 'untitled.pict', nil, reply);
  if reply.good then
   begin
    err := Create(reply.fname, reply.vrefnum, '????', 'PICT');
    if (err = noerr) | (err = dupfnerr) then
     begin
      err := FSOpen(reply.fname, reply.vrefnum, refNum);
      WriteFile;
     end;
   end;
 end;

begin

 PaintPicture;
 CreateFile;

end.