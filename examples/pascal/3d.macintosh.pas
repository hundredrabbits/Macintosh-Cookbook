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
  shape: array[1..42] of Point3D;
  links: array[1..56] of Link3D;

{>>}
 procedure SetLk3D (var lk3D: Link3D; a, b: Integer);
 begin
  lk3D.a := a;
  lk3D.b := b;
 end;

{>>}
 procedure CreateCube;
 begin
  SetPt3D(shape[1], Long2Fix(-60), Long2Fix(-80), Long2Fix(45));
  SetPt3D(shape[2], Long2Fix(-60), Long2Fix(-50), Long2Fix(65));
  SetPt3D(shape[3], Long2Fix(-60), Long2Fix(80), Long2Fix(65));
  SetPt3D(shape[4], Long2Fix(-60), Long2Fix(80), Long2Fix(-55));
  SetPt3D(shape[5], Long2Fix(-60), Long2Fix(60), Long2Fix(-55));
  SetPt3D(shape[6], Long2Fix(-60), Long2Fix(60), Long2Fix(-70));
  SetPt3D(shape[7], Long2Fix(60), Long2Fix(-80), Long2Fix(-70));
  SetPt3D(shape[8], Long2Fix(60), Long2Fix(-80), Long2Fix(45));
  SetPt3D(shape[9], Long2Fix(60), Long2Fix(-50), Long2Fix(65));
  SetPt3D(shape[10], Long2Fix(60), Long2Fix(80), Long2Fix(65));
  SetPt3D(shape[11], Long2Fix(60), Long2Fix(80), Long2Fix(-55));
  SetPt3D(shape[12], Long2Fix(60), Long2Fix(60), Long2Fix(-55));
  SetPt3D(shape[13], Long2Fix(60), Long2Fix(60), Long2Fix(-70));
  SetPt3D(shape[14], Long2Fix(-25), Long2Fix(-50), Long2Fix(65));
  SetPt3D(shape[15], Long2Fix(-25), Long2Fix(-60), Long2Fix(-10));
  SetPt3D(shape[16], Long2Fix(-25), Long2Fix(-80), Long2Fix(-10));
  SetPt3D(shape[17], Long2Fix(-25), Long2Fix(-80), Long2Fix(45));
  SetPt3D(shape[18], Long2Fix(25), Long2Fix(-50), Long2Fix(65));
  SetPt3D(shape[19], Long2Fix(25), Long2Fix(-60), Long2Fix(-10));
  SetPt3D(shape[20], Long2Fix(25), Long2Fix(-80), Long2Fix(-10));
  SetPt3D(shape[21], Long2Fix(25), Long2Fix(-80), Long2Fix(45));
  SetPt3D(shape[22], Long2Fix(-50), Long2Fix(-65), Long2Fix(-70));
  SetPt3D(shape[23], Long2Fix(50), Long2Fix(-65), Long2Fix(-70));
  SetPt3D(shape[24], Long2Fix(50), Long2Fix(10), Long2Fix(-70));
  SetPt3D(shape[25], Long2Fix(-50), Long2Fix(10), Long2Fix(-70));
  SetPt3D(shape[26], Long2Fix(-45), Long2Fix(-60), Long2Fix(-63));
  SetPt3D(shape[27], Long2Fix(45), Long2Fix(-60), Long2Fix(-63));
  SetPt3D(shape[28], Long2Fix(45), Long2Fix(5), Long2Fix(-63));
  SetPt3D(shape[29], Long2Fix(-45), Long2Fix(5), Long2Fix(-63));
  SetPt3D(shape[30], Long2Fix(50), Long2Fix(22), Long2Fix(-70));
  SetPt3D(shape[31], Long2Fix(30), Long2Fix(22), Long2Fix(-70));
  SetPt3D(shape[32], Long2Fix(30), Long2Fix(25), Long2Fix(-70));
  SetPt3D(shape[33], Long2Fix(-5), Long2Fix(25), Long2Fix(-70));
  SetPt3D(shape[34], Long2Fix(-5), Long2Fix(32), Long2Fix(-70));
  SetPt3D(shape[35], Long2Fix(30), Long2Fix(32), Long2Fix(-70));
  SetPt3D(shape[36], Long2Fix(30), Long2Fix(35), Long2Fix(-70));
  SetPt3D(shape[37], Long2Fix(50), Long2Fix(35), Long2Fix(-70));
  SetPt3D(shape[38], Long2Fix(-50), Long2Fix(32), Long2Fix(-70));
  SetPt3D(shape[39], Long2Fix(-37), Long2Fix(32), Long2Fix(-70));
  SetPt3D(shape[40], Long2Fix(-37), Long2Fix(45), Long2Fix(-70));
  SetPt3D(shape[41], Long2Fix(-50), Long2Fix(45), Long2Fix(-70));
  SetPt3D(shape[42], Long2Fix(-60), Long2Fix(-80), Long2Fix(-70));

  SetLk3D(links[1], 42, 1);
  SetLk3D(links[2], 1, 2);
  SetLk3D(links[3], 2, 3);
  SetLk3D(links[4], 3, 4);
  SetLk3D(links[5], 4, 5);
  SetLk3D(links[6], 5, 6);
  SetLk3D(links[7], 6, 42);
  SetLk3D(links[8], 7, 8);
  SetLk3D(links[9], 8, 9);
  SetLk3D(links[10], 9, 10);
  SetLk3D(links[11], 10, 11);
  SetLk3D(links[12], 11, 12);
  SetLk3D(links[13], 12, 13);
  SetLk3D(links[14], 13, 7);
  SetLk3D(links[15], 42, 7);
  SetLk3D(links[16], 2, 9);
  SetLk3D(links[17], 3, 10);
  SetLk3D(links[18], 4, 11);
  SetLk3D(links[19], 5, 12);
  SetLk3D(links[20], 6, 13);
  SetLk3D(links[21], 14, 15);
  SetLk3D(links[22], 15, 16);
  SetLk3D(links[23], 16, 17);
  SetLk3D(links[24], 17, 14);
  SetLk3D(links[25], 18, 19);
  SetLk3D(links[26], 19, 20);
  SetLk3D(links[27], 20, 21);
  SetLk3D(links[28], 21, 18);
  SetLk3D(links[29], 17, 1);
  SetLk3D(links[30], 21, 8);
  SetLk3D(links[31], 15, 19);
  SetLk3D(links[32], 16, 20);
  SetLk3D(links[33], 22, 23);
  SetLk3D(links[34], 23, 24);
  SetLk3D(links[35], 24, 25);
  SetLk3D(links[36], 25, 22);
  SetLk3D(links[37], 26, 27);
  SetLk3D(links[38], 27, 28);
  SetLk3D(links[39], 28, 29);
  SetLk3D(links[40], 29, 26);
  SetLk3D(links[41], 22, 26);
  SetLk3D(links[42], 23, 27);
  SetLk3D(links[43], 24, 28);
  SetLk3D(links[44], 25, 29);
  SetLk3D(links[45], 30, 31);
  SetLk3D(links[46], 31, 32);
  SetLk3D(links[47], 32, 33);
  SetLk3D(links[48], 33, 34);
  SetLk3D(links[49], 34, 35);
  SetLk3D(links[50], 35, 36);
  SetLk3D(links[51], 36, 37);
  SetLk3D(links[52], 37, 30);
  SetLk3D(links[53], 38, 39);
  SetLk3D(links[54], 39, 40);
  SetLk3D(links[55], 40, 41);
  SetLk3D(links[56], 41, 38);
 end;

{>>}
 procedure PaintCube;
  var
   i: Integer;
 begin

  for i := 1 to 56 do
   begin
    MoveTo3D(shape[links[i].a].x, shape[links[i].a].y, shape[links[i].a].z);
    LineTo3D(shape[links[i].b].x, shape[links[i].b].y, shape[links[i].b].z);
   end;
 end;

{>>}
 procedure PaintFace;
  var
   tempRgn: RgnHandle;
 begin
  tempRgn := NewRgn;
  OpenRgn;
  MoveTo3D(shape[26].x, shape[26].Y, shape[26].Z);
  LineTo3D(shape[27].X, shape[27].Y, shape[27].Z);
  LineTo3D(shape[28].X, shape[28].Y, shape[28].Z);
  LineTo3D(shape[29].X, shape[29].Y, shape[29].Z);
  LineTo3D(shape[26].X, shape[26].Y, shape[26].Z);
  CloseRgn(tempRgn);
  FillRgn(tempRgn, ltgray);
  DisposeRgn(tempRgn);
 end;

{>>}
 procedure PaintInspector (pt3D: Point3D);
 begin
  MoveTo3D(pt3D.x, pt3D.y, pt3D.z);
  Line2D(pt3D.x + 5, pt3D.y);
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
  w := NewWindow(nil, r, 'Study', true, zoomDocProc, WindowPtr(-1), false, 0);
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
  LookAt(Long2Fix(-200), Long2Fix(200), Long2Fix(200), Long2Fix(-200));
  ViewAngle(Long2Fix(50));
  Identity;
  Roll(Long2Fix(hangle));
  Pitch(Long2Fix(vangle)); { roll and pitch the plane }
  PaintFace;
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

 Redraw;
 MainLoop;

end.