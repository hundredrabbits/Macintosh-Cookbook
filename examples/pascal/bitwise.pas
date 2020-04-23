program ExampleBitwise;

 var
  value, mask: Integer;

begin

 ShowText;

 Writeln(BAnd(20, 123));
 Writeln(Btst(20, 16));

{ compare }
 Writeln(Bxor(20, 123));
 Writeln(Bor(20, 123));

{bit shift }
 Writeln(Bsl(20, 1));
 Writeln(Bsr(20, 1));

end.