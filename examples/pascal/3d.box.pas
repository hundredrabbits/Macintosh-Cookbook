program ExampleBox;

 uses
  FixMath, Graf3D;

 type
  Link3D = record
    a: Integer;
    b: Integer;
   end;

{globals}
 var
  w: WindowPtr;
  r: Rect;
  myPort: GrafPort;
  myPort3D: Port3D;
  gDone, gWNEimplemented: BOOLEAN;
  gTheEvent: EventRecord;
  i: INTEGER;
  pa, pb: Point3D;

  shape: array[1..9] of Point3D;
  links: array[1..13] of Link3D;

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
 procedure MainLoop;
 begin
  repeat
  until button;
 end;

{>>}
 procedure WindowInit;
 begin
  SetRect(r, 200, 50, 500, 300);
  w := NewWindow(nil, r, '', true, zoomDocProc, WindowPtr(-1), false, 0);
  SetWTitle(w, 'treedee');
  SetPort(w);
  SetCursor(arrow);
 end;

{>>}
 procedure SetLk3D (var lk3D: Link3D; a, b: Integer);
 begin
  lk3D.a := a;
  lk3D.b := b;
 end;

begin

 WindowInit;
 InitGrf3D(nil);
 Open3DPort(@myPort3D);

{ camera }
 ViewPort(thePort^.portRect);
 LookAt(Long2Fix(-100), Long2Fix(100), Long2Fix(100), Long2Fix(-100));
 ViewAngle(Long2Fix(20));
 Identity;
 Roll(Long2Fix(20));
 Pitch(Long2Fix(70)); { roll and pitch the plane }

 PaintAxis(10);

 SetPt3D(shape[1], Long2Fix(20), 0, Long2Fix(20));
 SetPt3D(shape[2], Long2Fix(20), 0, Long2Fix(-20));
 SetPt3D(shape[3], Long2Fix(-20), 0, Long2Fix(-20));
 SetPt3D(shape[4], Long2Fix(-20), 0, Long2Fix(20));

 SetPt3D(shape[5], Long2Fix(20), Long2Fix(40), Long2Fix(20));
 SetPt3D(shape[6], Long2Fix(20), Long2Fix(40), Long2Fix(-20));
 SetPt3D(shape[7], Long2Fix(-20), Long2Fix(40), Long2Fix(-20));
 SetPt3D(shape[8], Long2Fix(-20), Long2Fix(40), Long2Fix(20));

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

 PenPat(black);

 for i := 1 to 12 do
  begin
   MoveTo3D(shape[links[i].a].x, shape[links[i].a].y, shape[links[i].a].z);
   LineTo3D(shape[links[i].b].x, shape[links[i].b].y, shape[links[i].b].z);
  end;

 MainLoop;

end.