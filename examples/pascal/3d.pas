program Boxes;

 uses
  FixMath, Graf3D;

 type
  Box3D = record
    pt1: Point3D;
    pt2: Point3D;
   end;

 var
  myPort: GrafPort;
  myPort3D: Port3D;
  i: INTEGER;
  dummy: EventRecord;
  pa, pb: Point3D;

begin

 ShowDrawing;
 InitGraf(@thePort);

 OpenPort(@myPort);
 Open3DPort(@myPort3D);

 ViewPort(myPort.portRect);
 LookAt(FixRatio(-100, 1), FixRatio(75, 1), FixRatio(100, 1), FixRatio(-75, 1));
 ViewAngle(FixRatio(30, 1));
 Identity;
 Roll(FixRatio(20, 1));
 Pitch(FixRatio(70, 1)); { roll and pitch the plane }


 PenPat(black);
 SetPt3D(pa, 0, 0, 0);
 SetPt3D(pb, 100, -100, 100);

 MoveTo3D(pa.X, pa.Y, pa.Z);
 LineTo3D(pb.X, pb.Y, pb.Z);

 for i := -10 to 10 do
  begin
   MoveTo3D(FixRatio(i * 10, 1), FixRatio(-100, 1), 0);
   LineTo3D(FixRatio(i * 10, 1), FixRatio(100, 1), 0);
  end;

 for i := -10 to 10 do
  begin
   MoveTo3D(FixRatio(-100, 1), 0, FixRatio(i * 10, 1));
   LineTo3D(FixRatio(100, 1), 0, FixRatio(i * 10, 1));
  end;

end.