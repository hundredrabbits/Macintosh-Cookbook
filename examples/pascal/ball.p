program Bouncing_Ball;
 const
  PICTURE_HEIGHT = 100;
  PICTURE_WIDTH = 400;
  BALL_SIZE = 8;
  GRAVITY = -0.5;
  BOUNCINESS = 0.9;
  COURT_LEVEL = 100;
 var
  Horizontal_Position: Integer;
  Vertical_Position, Velocity: Real;
  box: Rect;

 procedure Draw_Ball (Vertical_Position: Integer);
  var
   Top, Left, Bottom, Right: Integer;
 begin
  Top := COURT_LEVEL - Vertical_Position - BALL_SIZE;
  Left := Horizontal_Position - BALL_SIZE;
  Bottom := COURT_LEVEL - Vertical_Position + BALL_SIZE;
  Right := Horizontal_Position + BALL_SIZE;
  setRect(box, Left, Top, Right, Bottom);
  FrameOval(box);
 end;

begin {bouncing ball}
 ShowDrawing;
 Horizontal_Position := BALL_SIZE + 1;
 Vertical_Position := PICTURE_HEIGHT - BALL_SIZE - 1;
 Velocity := 0;
 Draw_Ball(round(Vertical_Position));
 repeat
  Horizontal_Position := Horizontal_Position + 2;
  Velocity := Velocity + GRAVITY;
  Vertical_Position := Vertical_Position + Velocity;
  if Vertical_Position <= 0 then
   begin
    Vertical_Position := Abs(Vertical_Position);
    Velocity := -(BOUNCINESS * Velocity);
   end;
  Draw_Ball(round(Vertical_Position));
 until Horizontal_Position >= PICTURE_WIDTH;
end.
end.