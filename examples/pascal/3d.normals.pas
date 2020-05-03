program ExampleNormals;

 uses
  FixMath, Graf3D;

 var
  w: WindowPtr; {A window to draw in}
  r: Rect; {A window Size}
  myPort: GrafPort;
  myPort3D: Port3D;
  i: INTEGER;
  dummy: EventRecord;
  pa, pb: Point3D;

{>>}
 procedure WindowInit;
 begin
  SetRect(r, 100, 50, 550, 400);
  w := NewWindow(nil, r, 'Color Cube', true, zoomDocProc, WindowPtr(-1), false, 0);
  SetPort(w);
 end;

{>>}
 procedure MainLoop;
 begin
  repeat
  until button;
 end;

{>>}
 procedure DrawBrick (pt1, pt2: Point3D);
  var
   tempRgn: RgnHandle;
 begin
  tempRgn := NewRgn;
  ForeColor(blueColor);
  BackColor(yellowColor);

  OpenRgn;
  MoveTo3D(pt1.X, pt1.Y, pt1.Z); { front face, y=y1 }
  LineTo3D(pt1.X, pt1.Y, pt2.Z);
  LineTo3D(pt2.X, pt1.Y, pt2.Z);
  LineTo3D(pt2.X, pt1.Y, pt1.Z);
  LineTo3D(pt1.X, pt1.Y, pt1.Z);
  CloseRgn(tempRgn);
  FillRgn(tempRgn, ltgray);

  ForeColor(redColor);
  BackColor(cyanColor);
  OpenRgn;
  MoveTo3D(pt1.X, pt1.Y, pt2.Z); { top face, z=z2 }
  LineTo3D(pt1.X, pt2.Y, pt2.Z);
  LineTo3D(pt2.X, pt2.Y, pt2.Z);
  LineTo3D(pt2.X, pt1.Y, pt2.Z);
  LineTo3D(pt1.X, pt1.Y, pt2.Z);
  CloseRgn(tempRgn);
  FillRgn(tempRgn, ltgray);

  ForeColor(greenColor);
  BackColor(magentaColor);
  OpenRgn;
  MoveTo3D(pt2.X, pt1.Y, pt1.Z); { right face, x=x2 }
  LineTo3D(pt2.X, pt1.Y, pt2.Z);
  LineTo3D(pt2.X, pt2.Y, pt2.Z);
  LineTo3D(pt2.X, pt2.Y, pt1.Z);
  LineTo3D(pt2.X, pt1.Y, pt1.Z);
  CloseRgn(tempRgn);
  FillRgn(tempRgn, ltgray);

  PenPat(white);
  MoveTo3D(pt2.X, pt2.Y, pt2.Z); { outline right }
  LineTo3D(pt2.X, pt2.Y, pt1.Z);
  LineTo3D(pt2.X, pt1.Y, pt1.Z);
  PenNormal;

  DisposeRgn(tempRgn);
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

 SetPt3D(pa, FixRatio(20, 1), FixRatio(20, 1), FixRatio(20, 1));
 SetPt3D(pb, FixRatio(-20, 1), FixRatio(-20, 1), FixRatio(-20, 1));
 DrawBrick(pa, pb);

 MainLoop;

end.