program const_circle (input, output);

 const
  PI = 3.141592654;

 var
  r, d, c: Real;   {variable declaration: radius, dia, circumference}

begin

 ShowText;
 Writeln('Enter the radius of the circle');
 Readln(r);

 d := 2 * r;
 c := PI * d;
 Writeln('The circumference of the circle is ', c : 7 : 2);

end.