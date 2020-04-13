program PaddleBall;

 var
  Ball, Paddle, Top, Bottom, Left, Right, TempRect: Rect;
  Difficulty, XPaddle, YPaddle, I, J, DispHoriz, DispVert, Slope: Integer;
  Gameover, Forward: Boolean;
 procedure Init;
 begin
{ setup screen }
  SetRect(TempRect, 0, 0, 512, 342);
  SetDrawingRect(TempRect);
  ShowDrawing;
  HideCursor;
{ size of ball is 9 by 9 }
  SetRect(Ball, 0, 0, 9, 9);
{ boundaries }
  SetRect(Left, 0, 11, 1, 332);
  SetRect(Top, 0, 20, 502, 326);
  SetRect(Bottom, 0, 325, 502, 326);
  SetRect(Right, 498, 10, 511, 332);
{ Initial Position/Direction }
  DispHoriz := 100;
  DispVert := 100;
  Slope := 2;
  Forward := true;
  Difficulty := 0;
  Gameover := false;
 end;

 procedure MovePaddle;
{ erase paddle and redraw at new location }
  var
   Pt: Point;
 begin
  GetMouse(Pt);
  EraseRect(Paddle);
  SetRect(Paddle, Difficulty, Pt.v, Difficulty + 11, Pt.v + 25);
  FrameRect(Paddle);
 end;

 procedure MoveBall;
 begin
  if SectRect(Right, Ball, TempRect) then
   begin
    SysBeep(1);
    Forward := False
   end
  else if SectRect(Left, Ball, TempRect) then
{hit left wall, game over }
   Gameover := true
  else if SectRect(Top, Ball, TempRect) or SectRect(Bottom, Ball, TempRect) then
   begin
    Slope := -Slope
   end
  else if SectRect(Paddle, Ball, TempRect) and (not Forward) then
   begin
    Forward := true;
    Difficulty := Difficulty + 10;
   end;
  if Forward then
   DispHoriz := DispHoriz + 10
  else
   DispHoriz := DispHoriz - 10;
  DispVert := DispVert + Slope;
  EraseOval(Ball);
  SetRect(Ball, DispHoriz, DispVert, DispHoriz + 9, DispVert + 9);
  PaintOval(Ball);
 end;

begin { main program}
  
 Init;
 while not Gameover do
  begin
   MoveBall;
   MovePaddle;
  end

end.