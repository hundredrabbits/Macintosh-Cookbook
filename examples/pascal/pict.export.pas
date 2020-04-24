program ExampleDrawingExport;

 var
  oval, clip: Rect;
  pic: PicHandle;
  err: OSErr;
  refNum, i: Integer;
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
   FillOval(oval, black);
   ClosePicture;
   DrawPicture(pic, clip);
 end;

begin
 
 refNum := -1;
 bigZero := 0;
 SetRect(clip, 0, 0, 100, 100);

 PaintPicture;
 
 err := Create('export', 0, 'RS$$', 'PICT');
 CheckError;
 err := FSOpen('export', 0, refNum);
 CheckError;

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

end.