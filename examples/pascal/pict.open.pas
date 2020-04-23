program readPICT;
    {the following variable must be at the top level}

 var
  globalRef: INTEGER;      {refNum of the file to read from}
  err: OSErr;

    {the following procedure must be at the top level}

 procedure GetPICTData (dataPtr: Ptr; byteCount: INTEGER);
  var
   err: OSErr;
   longCount: LONGINT;
 begin
  longCount := byteCount;
  err := FSRead(globalRef, longCount, dataPtr);
          {can't check for an error because we don't know how to handle it}
 end;

 const
  abortPICT = 128;         {error code if DrawPicture aborted}

 procedure GetDrawPICTFile;     {read in a PICT FILE selected by the user}
  var
   wher: Point;     {where to display dialog}
   reply: SFReply;   {reply record}
   myFileTypes: SFTypeList; {more Standard FILE goodies}
   numFileTypes: INTEGER;
   savedProcs: QDProcsPtr;
   myProcs: QDProcs;   {use CQDProcs for a color window}
   myPicture: PicHandle; {we need a picture handle for DrawPicture}
   longCount: LONGINT;
   myEOF: LONGINT;
   myFilePos: longint;
 begin
  myFilePos := 0;
  wher.h := 20;
  wher.v := 20;
  numFileTypes := 1;       {display PICT files}
  myFileTypes[0] := 'PICT';
  SFGetFile(wher, '', nil, numFileTypes, nil, nil, reply);
  if reply.good then
   begin
    SetStdProcs(myProcs); {use SetStdCProcs for a CGrafPort}
    myProcs.getPicProc := @GetPICTData;
    savedProcs := thePort^.grafProcs; {set the grafProcs to ours}
    thePort^.grafProcs := @myProcs;
    myPicture := PicHandle(NewHandle(SizeOf(myPicture)));
    err := FSOpen(reply.fname, reply.vRefNum, globalRef);
    err := GetEOF(globalRef, myEOF); {get EOF for later check}
    err := SetFPos(globalRef, fsFromStart, 512); {skip header}
    longCount := SizeOf(myPicture);
    err := FSRead(globalRef, longCount, Ptr(myPicture^));
    DrawPicture(myPicture, myPicture^^.picFrame); {draw the picture}
    err := GetFPos(globalRef, myFilePos); {get position for check}
    err := FSClose(globalRef);
    DisposHandle(Handle(myPicture));
    thePort^.grafProcs := savedProcs; {restore the procs}
    if myFilePos <> myEOF then
     err := abortPICT;
   end;
 end;

begin


end.