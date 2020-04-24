program ExampleDrawingExport;

 var
  oval, clipin, clipout: Rect;
  output: PicHandle;

 var
  PICTcount: LONGINT;
  globalRef: INTEGER;
  newPICThand: PicHandle;

 procedure PutPICTData (dataPtr: Ptr; byteCount: INTEGER);
  var
   longCount: LONGINT;
   err: INTEGER;
 begin
  longCount := byteCount;
  PICTCount := PICTCount + byteCount;
  err := FSWrite(globalRef, longCount, dataPtr);
  if newPICTHand <> nil then
   newPICTHand^^.picSize := PICTCount;
 end;

 procedure SpoolOutPICTFile (PICTHand: PicHandle       );
  var
   err: OSErr;
   i: INTEGER;
   wher: Point; { where to display dialog }
   longCount, Zero: LONGINT;
   pframe: Rect;
   reply: SFReply;
   myProcs: QDProcs; 
 begin
  wher.h := 20;
  wher.v := 20;
  SFPutFile(wher, 'Save the PICT as:', 'untitled', nil, reply);
  if reply.good then
   begin
    err := Create(reply.fname, reply.vrefnum, '????', 'PICT');
    if (err = noerr) | (err = dupfnerr) then
     begin
      err := FSOpen(reply.fname, reply.vrefnum, globalRef);
      SetStdProcs(myProcs); {use SetStdCProcs for a CGrafPort}
      thePort^.grafProcs := @myProcs;
      myProcs.putPicProc := @putPICTdata;
      Zero := 0;
      longCount := 2;
      PICTCount := SizeOf(Picture);
     {now write out the 512 byte header}
      for i := 1 to (512 + SizeOf(Picture)) div longCount do
       err := FSWrite(globalRef, longCount, @Zero);
      pFrame := PICThand^^.picFrame;
      newPICTHand := nil;
      newPICTHand := OpenPicture(pFrame);
      DrawPicture(PICTHand, pFrame);
      ClosePicture;
      err := SetFPos(globalRef, fsFromStart, 512);
    {skip the MacDraw header}
      longCount := SizeOf(Picture);
    {write out the correct (low word of the) size and the frame at the beginning}
      err := FSWrite(globalRef, longCount, Ptr(newPICTHand^));
      err := FSClose(globalRef);
      thePort^.grafProcs := nil;
      KillPicture(newPICTHand);
     end
    else
     err := err;
   end; {IF reply.good}
 end; {OutPICT}

begin

 ShowDrawing;

 SetRect(clipin, 0, 0, 100, 100);
 SetRect(clipout, 0, 0, 100, 100);
 SetRect(oval, 20, 20, 180, 180);

 output := OpenPicture(clipin);
 PenPat(black);
 PaintOval(oval);
 ClosePicture;

 DrawPicture(output, clipout);

 SpoolOutPICTFile(output);

end.