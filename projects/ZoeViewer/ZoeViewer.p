program ZoeViewer;

 var
  fileRefNum: Integer;
  contents: Ptr;
  fileSize, thisRead: Longint;
  err: OSErr;

 procedure CloseFile;
 begin
  if fileRefNum = -1 then
   Exit(CloseFile);
  err := FSClose(fileRefNum);
  if err <> 0 then
   WriteLn('FSClose error:', err);
  fileRefNum := -1;
 end;

 procedure Cleanup;
 begin
  CloseFile;
  if contents <> nil then
   begin
    DisposePtr(Pointer(contents));
    contents := nil;
   end;
 end;

 procedure CleanupAndHalt;
 begin
  Cleanup;
  Halt;
 end;

 procedure SelectFile;
  var
   reply: SFReply;
   totalRead: Longint;
   pnt: Point;
 begin
  fileRefNum := -1;
  totalRead := 0;
  contents := nil;
  SetPt(pnt, 0, 0);
  SFGetFile(pnt, 'Pick a ZOE file:', nil, -1, nil, nil, reply);
  if not reply.good then
   Halt;
  err := FSOpen(reply.fName, reply.vRefNum, fileRefNum);
  if err <> 0 then
   begin
    WriteLn('FSOpen error:', err);
    CleanupAndHalt;
   end;
  err := GetEOF(fileRefNum, fileSize);
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
   err := FSRead(fileRefNum, thisRead, Pointer(Longint(contents) + totalRead));
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

 procedure DrawFile;
  var
   bmap: BitMap;
   headerPtr: ^Longint;
   header: Longint;
   width, height: Integer;
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
  if width = 0 then
   begin
    WriteLn('Zero width');
    CleanupAndHalt;
   end;
  height := (fileSize - 4) div width;
  if height = 0 then
   begin
    WriteLn('Zero height');
    CleanupAndHalt;
   end;
  ShowDrawing;
  SetRect(bmap.bounds, 0, 0, width * 8, height);
  bmap.rowBytes := width;
  bmap.baseAddr := Pointer(Longint(contents) + 4);
  CopyBits(bmap, thePort^.portBits, bmap.bounds, bmap.bounds, srcCopy, nil);
  Cleanup;
 end;

begin

 ShowText;

 SelectFile;
 DrawFile;

end.