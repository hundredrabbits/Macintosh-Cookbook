program readPICT;
    {the following variable must be at the top level}

    VAR
       globalRef   : INTEGER;      {refNum of the file to read from}

    {the following procedure must be at the top level}

    PROCEDURE GetPICTData(dataPtr: Ptr; byteCount: INTEGER);
    {replacement for the QuickDraw bottleneck routine}

       VAR
          err         : OSErr;
          longCount   : LONGINT;

       BEGIN
          longCount := byteCount;
          err := FSRead(globalRef,longCount,dataPtr);
          {can't check for an error because we don't know how to handle it}
       END;

    CONST
       abortPICT    = 128;         {error code if DrawPicture aborted}

    PROCEDURE GetDrawPICTFile;     {read in a PICT FILE selected by the user}

       VAR
          wher        : Point;     {where to display dialog}
          reply       : SFReply;   {reply record}
          myFileTypes : SFTypeList; {more Standard FILE goodies}
          numFileTypes: INTEGER;

          savedProcs  : QDProcsPtr;
          myProcs     : QDProcs;   {use CQDProcs for a color window}

          myPicture   : PicHandle; {we need a picture handle for DrawPicture}
          longCount   : LONGINT;
          myEOF       : LONGINT;
          myFilePos   : LONGINT;

       BEGIN
          wher.h := 20;
          wher.v := 20;
          numFileTypes := 1;       {display PICT files}
          myFileTypes[0] := 'PICT';
          SFGetFile(wher,'',NIL,numFileTypes,myFileTypes,NIL,reply);

          IF reply.good THEN BEGIN
             SetStdProcs(myProcs); {use SetStdCProcs for a CGrafPort}
             myProcs.getPicProc := @GetPICTData;
             savedProcs := thePort^.grafProcs; {set the grafProcs to ours}
             thePort^.grafProcs := @myProcs;

             myPicture := PicHandle(NewHandle(SizeOf(myPicture)));

             Signal(FSOpen(reply.fname,reply.vRefNum,globalRef));
             Signal(GetEOF(globalRef,myEOF)); {get EOF for later check}
             Signal(SetFPos(globalRef,fsFromStart,512)); {skip header}

             {read in the (obsolete) size word and the picFrame}
             longCount := SizeOf(myPicture);
             Signal(FSRead(globalRef,longCount,Ptr(myPicture^)));

             DrawPicture(myPicture,myPicture^^.picFrame); {draw the picture}

             Signal(GetFPos(globalRef,filePos)); {get position for check}
             Signal(FSClose(globalRef));

             DisposHandle(Handle(myPicture));

             thePort^.grafProcs := savedProcs; {restore the procs}

             {Check for errors. If there wasn't enough room,}
             {DrawPicture will abort; the FILE position mark}
             {won't be at the end of the FILE.}
             IF filePos <> myEOF THEN Signal(abortPICT);
          END; {IF reply.good}
       END; {GetDrawPICTFile}