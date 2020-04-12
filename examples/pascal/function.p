program Example;
 var
  a, b, ret: integer;

 function max (num1, num2: integer): integer;
  var
   result: integer;
 begin
  if (num1 > num2) then
   result := num1
  else
   result := num2;
  max := result;
 end;

begin
 a := 100;
 b := 200;

 ret := max(a, b);
 writeln('Max value is : ', ret);
end.