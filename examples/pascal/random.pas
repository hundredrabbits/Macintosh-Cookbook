program ExampleRandom;

 var
  x, ps, start1, start2, endpt1, endpt2: Integer;

begin

 for x := 1 to 20 do
  begin
   ps := Random mod 10;
   start1 := Random mod 200;
   start2 := Random mod 200;
   endpt1 := Random mod 200;
   endpt2 := Random mod 200;
   PenSize(ps, ps);
   Moveto(start1 + 200, start2 + 100);
   Lineto(endpt1 + 200, endpt2 + 100);
  end

end.