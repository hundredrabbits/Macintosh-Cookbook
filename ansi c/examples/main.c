// Add Mac Libraries/MacTraps
// Use ResEdit to create a WIND resource with ID#128, named "PROJECT NAMEx.rsrc"

int main(void) {
  WindowPtr TheWindow;
  InitGraf(&thePort);
  InitFonts();
  InitWindows();

  TheWindow = GetNewWindow(128, 0L, (WindowPtr)-1L);
  SetPort(TheWindow);
  MoveTo(30, 50);
  DrawString("\pHello, World");
  while(!Button()) { }

  return 0;
}
