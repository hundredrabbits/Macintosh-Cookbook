program ExampleRings;

 var
  Top, Left, Bottom, Right: Integer;
  Diam, Increase: Integer;
  Box: Rect;

begin

 Top := 0;
 Left := 0;
 Diam := 0;
 Write('Type an integer between 1 and 25: ');
 Read(Increase);
 ShowDrawing;
 repeat
  Diam := Diam + Increase;
  Bottom := Diam;
  Right := Diam;
  SetRect(box, Left, Top, Right, Bottom);
  FrameOval(box);
 until Diam > 400
 
end.