program Boxes;

 uses
  FixMath, Graf3D;

 type
  Link3D = record
    a: Integer;
    b: Integer;
   end;

 var
  w: WindowPtr; {A window to draw in}
  r: Rect; {A window Size}
  myPort: GrafPort;
  myPort3D: Port3D;
  pa, pb: Point3D;
  hangle, vangle: Longint;
{cursor}
  cursor, prev: Point;
  isDown: Boolean;
{cube}
  shape: array[1..9] of Point3D;
  links: array[1..13] of Link3D;

{>>}
 procedure SetLk3D (var lk3D: Link3D; a, b: Integer);
 begin
  lk3D.a := a;
  lk3D.b := b;
 end;

{>>}
 procedure CreateCube;
 begin
  SetPt3D(shape[1], Long2Fix(20), Long2Fix(20), Long2Fix(20));
  SetPt3D(shape[2], Long2Fix(20), Long2Fix(40), Long2Fix(-20));
  SetPt3D(shape[3], Long2Fix(-20), Long2Fix(20), Long2Fix(-20));
  SetPt3D(shape[4], Long2Fix(-20), Long2Fix(20), Long2Fix(20));

  SetPt3D(shape[5], Long2Fix(20), Long2Fix(-20), Long2Fix(20));
  SetPt3D(shape[6], Long2Fix(20), Long2Fix(-20), Long2Fix(-20));
  SetPt3D(shape[7], Long2Fix(-20), Long2Fix(-20), Long2Fix(-20));
  SetPt3D(shape[8], Long2Fix(-20), Long2Fix(-20), Long2Fix(20));

  SetLk3D(links[1], 1, 2);
  SetLk3D(links[2], 2, 3);
  SetLk3D(links[3], 3, 4);
  SetLk3D(links[4], 4, 1);

  SetLk3D(links[5], 5, 6);
  SetLk3D(links[6], 6, 7);
  SetLk3D(links[7], 7, 8);
  SetLk3D(links[8], 8, 5);

  SetLk3D(links[9], 1, 5);
  SetLk3D(links[10], 2, 6);
  SetLk3D(links[11], 3, 7);
  SetLk3D(links[12], 4, 8);
 end;

{>>}
 procedure PaintCube;
  var
   i: Integer;
 begin

  for i := 1 to 12 do
   begin
    MoveTo3D(shape[links[i].a].x, shape[links[i].a].y, shape[links[i].a].z);
    LineTo3D(shape[links[i].b].x, shape[links[i].b].y, shape[links[i].b].z);
   end;
 end;

{>>}
 function Interpolate (a, b, t: Fixed): Fixed;
 begin
  Interpolate := a + FixMul(b - a, t);
 end;

{>>}
 function HasPixel3D (col, row: Integer): Boolean;
 begin
  HasPixel3D := ((col + (row mod 2 + 1)) mod 2 = 0)
 end;


{>>}
 procedure LerpPt (var dest, a, b: Point3D; t: Fixed);
 begin
  SetPt3D(dest, Interpolate(a.x, b.x, t), Interpolate(a.y, b.y, t), Interpolate(a.z, b.z, t))
 end;

{>>}
 procedure ToPlane (var dest, a, b, c, d: Point3D; col, row, limit: Integer);
  var
   top, bottom, left, right, result1, result2: Point3D;
 begin
  LerpPt(top, a, b, FixRatio(row, limit));
  LerpPt(bottom, d, c, FixRatio(row, limit));
  LerpPt(left, a, d, FixRatio(col, limit));
  LerpPt(right, b, c, FixRatio(col, limit));
  LerpPt(result1, top, bottom, FixRatio(col, limit));
  LerpPt(result2, left, right, FixRatio(row, limit));
  LerpPt(dest, result1, result2, FixRatio(col, 2));
 end;

{>>}
 procedure PaintFace (a, b, c, d: Point3D);
  var
   tempRgn: RgnHandle;
   row, col: Integer;
   hpt, vpt, minia, minib, minic, minid: Point3D;
   x, y, z: Fixed;
   limit: Integer;
 begin

  limit := 10;

  tempRgn := NewRgn;
  OpenRgn;

  for col := 0 to limit - 1 do
   begin
    row := 0;
    for row := 0 to limit - 1 do
     begin
      if HasPixel3D(col, row) then
       begin
       ToPlane(minia, a, b, c, d, row, col, limit);
       ToPlane(minib, a, b, c, d, row + 1, col, limit);
       ToPlane(minic, a, b, c, d, row, col + 1, limit);
       ToPlane(minid, a, b, c, d, row + 1, col + 1, limit);
       MoveTo3D(minia.x, minia.y, minia.z);
       LineTo3D(minib.x, minib.y, minib.z);
       LineTo3D(minid.x, minid.y, minid.z);
       LineTo3D(minic.x, minic.y, minic.z);
       LineTo3D(minia.x, minia.y, minia.z);
       end;
     end;
   end;

  CloseRgn(tempRgn);
  PaintRgn(tempRgn);
  DisposeRgn(tempRgn);

 end;

{>>}
 procedure PaintAxis (size: Integer);
 begin
  PenPat(black);
  MoveTo3D(0, 0, 0);
  LineTo3D(Long2Fix(size), 0, 0);
  WriteDraw('x');
  MoveTo3D(0, 0, 0);
  LineTo3D(0, Long2Fix(size), 0);
  WriteDraw('y');
  MoveTo3D(0, 0, 0);
  LineTo3D(0, 0, Long2Fix(size));
  WriteDraw('z');
 end;

{>>}
 procedure WindowInit;
 begin
  SetRect(r, 100, 50, 300, 250);
  w := NewWindow(nil, r, 'Mapping', true, zoomDocProc, WindowPtr(-1), false, 0);
  SetPort(w);
 end;

{>>}
 procedure ClearScreen;
  var
   size: Rect;
 begin
  SetRect(size, 0, 0, 200, 200);
  FillRect(size, white);
 end;

{>>}
 procedure Redraw;
 begin
  ClearScreen;
  LookAt(Long2Fix(-50), Long2Fix(50), Long2Fix(50), Long2Fix(-50));
  ViewAngle(Long2Fix(20));
  Identity;
  Roll(Long2Fix(hangle));
  Pitch(Long2Fix(vangle)); { roll and pitch the plane }

  PaintAxis(10);
  PaintFace(shape[1], shape[2], shape[3], shape[4]);
  PaintCube;
 end;

{>>}
 procedure WhenDownChanged;
  var
   hoff, voff: Integer;
 begin
  hoff := prev.h - cursor.h;
  hangle := hangle + hoff;
  voff := prev.v - cursor.v;
  vangle := vangle + voff;
  Redraw;
  GetMouse(prev);
 end;

{>>}
 procedure WhenDown;
 begin
  GetMouse(cursor);
  if cursor.h <> prev.h then
   if cursor.v <> prev.v then
    WhenDownChanged;
 end;

{>>}
 procedure MainLoop;
 begin
  repeat {Until we click outside screen}
   while button do
    begin
     GetMouse(cursor);
     GetMouse(prev);
     repeat {Tight loop until button up}
      WhenDown;
     until not Button;
    end;
  until cursor.h < 0;
 end;

begin

 WindowInit;
 InitGrf3D(nil);
 Open3DPort(@myPort3D);
 ViewPort(thePort^.portRect);

 CreateCube;

 hangle := 145;
 vangle := 65;

 Redraw;
 MainLoop;

end.