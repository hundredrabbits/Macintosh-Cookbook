program ExampleSprial;

  {Program to build spiral pattern, using}
  {relative line routine in a recursive loop}

 var
  sign: integer;

 procedure Spiral (x, y, sign: integer);

  {Procedure to spiral into limbo}

  var
   temp: integer;

 begin

  sign := (-1) * sign;
  if (abs(x) < 10) and (abs(y) < 10) then
   halt {Done recurring - ground case}
  else {Spiral still sizable}
   begin

    line(x, y); {Plot relative line}

  {Reduce magnitude of relative move by 5 pixels}

    if abs(x) > abs(y) then
     x := x - (x div abs(x) * 5)
    else
     y := y - (y div abs(y) * 5);

  {Exchange x<--> y}

    temp := x;
    x := y;
    y := temp;

  {On even calls, change sign}

    x := sign * x;
    y := sign * y;
    Spiral(x, y, sign); {Recur}
   end;

 end;

begin

 sign := 1;
 PenSize(9, 9);
 ShowDrawing;
 MoveTo(20, 20);
 Spiral(200, 0, -1);

end.