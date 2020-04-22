program ExampleFontface;

begin

 ShowDrawing;

 MoveTo(70, 40);
 DrawString('Text');

 TextFace([bold]);
 MoveTo(70, 55);
 DraWString('Bold');

 TextFace([Italic]);
 MoveTo(70, 70);
 Drawstring('Italic');

 TextFace([underline]);
 MoveTo(70, 85);
 DrawString('Underline');

 TextFace([outline]);
 MoveTo(70, 100);
 DrawString('Outline');

 MoveTo(70, 100);
 TextFace([Shadow]);

 MoveTo(70, 115);
 Drawstring('Shadow');

{restore to normal }
 TextFace([]);

end.