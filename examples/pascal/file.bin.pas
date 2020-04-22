program ExampleFileBinary;

 type
  Number_File = file of real;

 var
  Data_Block: Number_File;
  Counter: integer;
  A: array[1..10] of real;

begin

 for Counter := 1 to 10 do
  A[Counter] := random;

 Open(Data_Block, 'data');
 Rewrite(Data_Block);

 for Counter := 1 to 10 do
  Write(Data_Block, A[Counter]);

 Close(Data_Block);

end.