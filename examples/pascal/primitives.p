program Primitives;

  {Program to demonstrate Pascal point & line primitives.}

begin

 ShowDrawing; {Opens Drawing Window}

  {First draw three points by three different functions}

 PenSize(1, 1); {Sets pen size to 1 x 1 pixels}
 DrawLine(50, 50, 50, 50);
 WriteDraw(' Point at (50,50) using DrawLine');

 PenSize(2, 2);
 MoveTo(100, 75); {Absolute move}
 LineTo(100, 75);
 WriteDraw(' Point at (100,75) using LineTo');

 PenSize(3, 3);
 MoveTo(150, 100); {Absolute move}
 Line(0, 0);
 WriteDraw(' Point at (150,100) using Line');

  {Now Draw three lines by three different functions}

 MoveTo(150, 175); {Absolute move}
 WriteDraw('Line drawn with DrawLine');
 DrawLine(150, 125, 50, 225);

 PenSize(2, 2);
 Move(0, 25); {Relative move}
 LineTo(150, 250);
 WriteDraw('Line drawn by LineTo');

 Pensize(1, 1);
 Move(0, 25); {Relative move}
 Line(-100, 50);
 WriteDraw('Line drawn by Line');

end.