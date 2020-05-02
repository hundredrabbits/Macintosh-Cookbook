program Boxes;

 uses
  FixMath, Graf3D;

 type
  Box3D = record
    pt1: Point3D;
    pt2: Point3D;
   end;

 var
  w: WindowPtr; {A window to draw in}
  r: Rect; {A window Size}
  myPort: GrafPort;
  myPort3D: Port3D;
  i: INTEGER;
  dummy: EventRecord;
  pa, pb: Point3D;

 procedure WindowInit;
 begin
  SetRect(r, 50, 50, 600, 400);
  w := NewWindow(nil, r, '', true, zoomDocProc, WindowPtr(-1), false, 0);
  SetPort(w);
 end;

 procedure MainLoop;
 begin
  repeat
  until button;
 end;

 procedure DrawBrick (pt1, pt2: Point3D);
  var
   tempRgn: RgnHandle;
 begin
  tempRgn := NewRgn;
  OpenRgn;
  MoveTo3D(pt1.X, pt1.Y, pt1.Z); { front face, y=y1 }
  LineTo3D(pt1.X, pt1.Y, pt2.Z);
  LineTo3D(pt2.X, pt1.Y, pt2.Z);
  LineTo3D(pt2.X, pt1.Y, pt1.Z);
  LineTo3D(pt1.X, pt1.Y, pt1.Z);
  CloseRgn(tempRgn);
  FillRgn(tempRgn, ltgray);

  OpenRgn;
  MoveTo3D(pt1.X, pt1.Y, pt2.Z); { top face, z=z2 }
  LineTo3D(pt1.X, pt2.Y, pt2.Z);
  LineTo3D(pt2.X, pt2.Y, pt2.Z);
  LineTo3D(pt2.X, pt1.Y, pt2.Z);
  LineTo3D(pt1.X, pt1.Y, pt2.Z);
  CloseRgn(tempRgn);
  FillRgn(tempRgn, gray);

  OpenRgn;
  MoveTo3D(pt2.X, pt1.Y, pt1.Z); { right face, x=x2 }
  LineTo3D(pt2.X, pt1.Y, pt2.Z);
  LineTo3D(pt2.X, pt2.Y, pt2.Z);
  LineTo3D(pt2.X, pt2.Y, pt1.Z);
  LineTo3D(pt2.X, pt1.Y, pt1.Z);
  CloseRgn(tempRgn);
  FillRgn(tempRgn, black);

  PenPat(white);
  MoveTo3D(pt2.X, pt2.Y, pt2.Z); { outline right }
  LineTo3D(pt2.X, pt2.Y, pt1.Z);
  LineTo3D(pt2.X, pt1.Y, pt1.Z);
  PenNormal;

  DisposeRgn(tempRgn);
 end;

begin

 WindowInit;

 Open3DPort(@myPort3D);

 ViewPort(thePort^.portRect);
 LookAt(FixRatio(-100, 1), FixRatio(75, 1), FixRatio(100, 1), FixRatio(-75, 1));
 ViewAngle(FixRatio(30, 1));
 Identity;
 Roll(FixRatio(20, 1));
 Pitch(FixRatio(70, 1)); { roll and pitch the plane }

 PenPat(black);

 SetPt3D(pa, FixRatio(20, 1), FixRatio(20, 1), FixRatio(20, 1));
 SetPt3D(pb, FixRatio(-20, 1), FixRatio(-20, 1), FixRatio(-20, 1));
 DrawBrick(pa, pb);

 SetPt3D(pa, FixRatio(20, 1), FixRatio(20, 1), FixRatio(20, 1));
 SetPt3D(pb, FixRatio(30, 1), FixRatio(30, 1), FixRatio(30, 1));
 DrawBrick(pa, pb);

 SetWTitle(w, 'OH SHIT YEAH');

 MoveTo3D(Long2Fix(40), 0, 0);
 LineTo3D(Long2Fix(-40), 0, 0);
 MoveTo3D(0, Long2Fix(40), 0);
 LineTo3D(0, Long2Fix(-40), 0);
 MoveTo3D(0, 0, Long2Fix(40));
 LineTo3D(0, 0, Long2Fix(-40));

 MainLoop;

end.