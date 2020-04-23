program ExampleFileBinary;

 var
  globalRef: Integer;

 procedure GetFile;
  var
   where: point;
   prompt: Str255;
   origName: Str255;
   err: OSErr;
   theReply: SFReply;
   myEOF: longint;
 begin
  setpt(where, 0, 0);
  prompt := 'Get resource File from';
  origName := 'unknownFile';
  SFGetFile(where, prompt, nil, -1, nil, nil, theReply);
  err := FSOpen(theReply.fname, theReply.vRefNum, globalRef);
  err := GetEOF(globalRef, myEOF);
  err := FSClose(globalRef);
 end;

begin

 GetFile;

end.