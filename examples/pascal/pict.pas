program ExamplePict;

 const
  BASE_RES_ID = 400;
 var
  gPictureWindow: WindowPtr;
  gPictureWindowRect: Rect;

 procedure CenterPict (thePicture: PicHandle; var myRect: Rect);
  var
   windRect, pictureRect: Rect;
 begin
  windRect := myRect;
  pictureRect := thePicture^^.picFrame;
  myRect.top := (windRect.bottom - windRect.top - (pictureRect.bottom - pictureRect.top)) div 2 + windRect.top;
  myRect.bottom := myRect.top + (pictureRect.bottom - pictureRect.top);
  myRect.left := (windRect.right - windRect.left - (pictureRect.right - pictureRect.left)) div 2 + windRect.left;
  myRect.right := myRect.left + (pictureRect.right - pictureRect.left);
 end;

 procedure DrawMyPicture (pictureWindow: WindowPtr);
  var
   myRect: Rect;
   thePicture: PicHandle;
 begin
  myRect := pictureWindow^.portRect;
  thePicture := GetPicture(BASE_RES_ID);
  CenterPict(thePicture, myRect);
  DrawPicture(thePicture, myRect);
 end;

 procedure WindowInit;
 begin
  SetRect(gPictureWindowRect, 150, 50, 300, 360);
  gPictureWindow := NewWindow(nil, gPictureWindowRect, 'Show Picture', true, zoomDocProc, WindowPtr(-1), false, 0);
  SetPort(gPictureWindow);
 end;

begin

 WindowInit;
 DrawMyPicture(gPictureWindow);
 while (not Button) do
  begin
  end;

end.

{ note: You must create a PICT asset with 400 in ResEdit, and add the Resource to Run Options. }