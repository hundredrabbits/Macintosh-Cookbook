program ExampleLines;

begin

 ShowDrawing;

 MoveTo(100, 70);
 WriteDraw('A');
 MoveTo(140, 110);
 WriteDraw('B');
 MoveTo(125, 140);
 WriteDraw('C');
 MoveTo(60, 140);
 WriteDraw('D');

 MoveTo(90, 110);
 WriteDraw('E');
{Draw a line from point A to point B.}
 DrawLine(100, 70, 140, 110);
{Draw a line from point B to point C.}
 LineTo(125, 140);
{Draw a line from point c to point D.}
 LineTo(65, 140);
{Draw a line from point D to point E.}
 LineTo(90, 110);
{Draw a line from point E to point B.}
 LineTo(140, 110);
{Finish drawing the remaining lines.}
 DrawLine(100, 70, 125, 140);
 DrawLine(100, 70, 65, 140);
 DrawLine(100, 70, 90, 110);

end.