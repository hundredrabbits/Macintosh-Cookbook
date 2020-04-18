program TowersOfHanoi (input, output);

 var
  disks: integer;

 procedure Hanoi (source, temp, destination: char; n: integer);

 begin
  if n > 0 then
   begin
    Hanoi(source, destination, temp, n - 1);
    writeln('Move disk ', n : 1, ' from peg ', source, ' to peg ', destination);
    Hanoi(temp, source, destination, n - 1);
   end;
 end;

begin
 write('Enter the number of disks: ');
 readln(disks);
 writeln('Solution:');
 Hanoi('A', 'B', 'C', disks);
end.