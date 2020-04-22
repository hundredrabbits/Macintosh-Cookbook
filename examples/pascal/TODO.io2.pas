program BarCH; {Program to automatically plot BAR CHART based on }
{user supplied graph title, axes labels, and data. }
{Data may be supplied as existing file or keyed in } {directly. }

const

    left = 50;
    right = 450;
    top = 40;
    bottom = 340;
    XaxisB = 50;
    XaxisE = 350;
    YaxisB = 255;
    YaxisE = 5;

var

    Title, OrdLab, AbsLab: string;
    DataFile: text;
    ID, OutLine: string;
    npoints, ScMax, ScMin, tens, Dy: integer;
    Max, Min, x: real;
    Sy, Dx: real;

procedure GetInformation;
{Routine to open interactive query viewport to input }
{essential information. }
var

    TextPort: rect;
    i: integer;
    ans: string;

begin {Set up text window and open it.}

    SetRect(TextPort, left, top, right, bottom);
    setTextRect(TextPort);
    ShowText;
    WriteLn;
    WriteLn(' Bar Chart Grapher');
    Writeln;
    Writeln('How shall we title this graph? (enter string)');
    Readln(title);
    Writeln;
    Writeln('Ordinate Label? (enter string)');
    Readln(OrdLab);
    WriteLn('Abscissa Label? (enter string)');
    Readln(AbsLab);
    Writeln;
    Writeln('Is data in table (T) or from keyboard (K)? Enter T or K');
    Readln(ans);
    {If data file exists, query for its name.}
    if (ans = 't') or (ans = 'T') then
    {Use file query function, "OldFileName"}
    Reset(DataFile, OldFileName('DataFile for Bar Chart?'))
    else {Otherwise, create it from the keyboard.}
    begin
    ReWrite(DataFile, 'BarCH.dat'); {Open for writing.}
    Writeln;
    Writeln('Please key in data in format (Xi _ IDi) <cr>');
    Writeln('Terminate with message (n _ end) <cr>');
    Writeln(' where _ = space, n = number, "end" = sentinal to stop');
    Readln(x, ID);
    repeat {Read and write data points until end.}
    Writeln(DataFile, x, ID);
    Readln(x, ID);
    until ID = ' end';
    end;

end;

procedure Normalize;
{Routine to scan data to count points and set Min and Max.}
{Round to nearest single digit inclusive number and}
{extract power of ten for correct scaling.}
var

    i, n, b: integer;
    a: real;  

function sign (z: real): real;
{Returns the sign as a real number.}
begin

    sign := z / abs(z)

end;

procedure Reduce (xin: real; var a: real; var b: integer);
{Procedure to read a real x and return it in the form a x 10**b}
var

    x: real;

begin

    x := abs(xin);
    if x < 1e-10 then {Test if number Å o; set a,b =0}
    begin
    a := 0.0;
    b := 0;
    end
    else if x < 1 then {Scale small numbers up by powers of 10}
    begin

        b := 0;
        repeat
        x := 10 * x;
        b := b - 1;
        until x > 1;
        end
        else {Case: x>1} {Scale large numbers down by powers of 10}
        begin
        b := -1;
        repeat
        x := x / 10;
        b := b + 1;
        until x < 1
        end;
        a := sign(xin) * exp(ln(abs(xin)) - b * ln(10))

    end; {End Reduce}

begin
reset(DataFile); {Reset data file and open it for reading.}
Max := -1e30;
Min := -Max;
npoints := 0;
repeat
Readln(DataFile, x, ID);
npoints := npoints + 1;
if x > Max then
Max := x;
if x < Min then
Min := x;
until eof(DataFile);
Reduce(Max, a, b); {Convert Max to power of 10 notation.}
ScMax := Trunc(a + 1); {Round single digit up.}
Tens := b;
Reduce(Min, a, b); {Convert Max to power of 10 notation.}
if b < Tens then
ScMin := 0
else
ScMin := Trunc(a - 1);{Round single digit down.}
end; {End Normalize}

procedure PlotAxes;
{Routine to plot and label abscissa & ordinate axes.}
var
ViewPort: rect;
i, n: integer;

begin

    {Open Drawing window as viewport.}
    SetRect(ViewPort, left, top, right, bottom);
    setDrawingRect(ViewPort);
    ShowDrawing;
    {Draw Ordinate axis (Y), with arrowhead.}
    DrawLine(XaxisB, YaxisB, XaxisB, YaxisE);
    Line(5, 10);
    Line(-10, 0);
    Line(5, -10);
    {Draw Abscissa axis.}
    DrawLine(XaxisB, YaxisB, XaxisE, YaxisB);
    {Compute Dx, width of bar.}
    Dx := (XaxisE - XaxisB) / (2 * Npoints);
    {Compute Sy, the ordinate scale factor.}
    Sy := (YaxisB - YaxisE) / (ScMax - ScMin);
    if tens > 0 then {Scale by appropriate
    power of 10}
    for i := 1 to tens do
    Sy := Sy / 10
    else if tens < 0 then
    for i := tens to -1 do
    Sy := 10 * Sy;
    Dy := Round((YaxisB - YaxisE) / (ScMax - ScMin));
    n := 0;
    {Draw tick marks and label ordinate axis.}
    for i := ScMin to (ScMax - 1) do
    begin
    MoveTo(XaxisB - 15, YaxisB - n * Dy + 4);
    WriteDraw(i : 1);
    MoveTo(XaxisB, YaxisB - n * Dy);
    Line(5, 0);
    n := n + 1;
    end;
    MoveTo(XaxisB + 50, YaxisE + 10);{Write Title}
    TextSize(18);
    WriteDraw(Title);
    MoveTo(XaxisB + 150, YaxisB + 25); {Label abscissa}
    TextSize(12);
    WriteDraw(AbsLab);
    {Label ordinate}
    MoveTo(XaxisB - 45, (YaxisB + YaxisE) div 2);
    WriteDraw(OrdLab);
    {Write scale factor}
    MoveTo(XaxisB - 48, (YaxisB + YaxisE) div 2 + 15);
    TextSize(9);
    WriteDraw('(X10');
    Move(3, -5);
    WriteDraw(Tens : 1);
    Move(0, 5);
    WriteDraw(')');

end; {End PlotAxes}

procedure PlotData;
{Routine to plot data bars.}
var

    i, L, R, T, B: integer;
    Bar: rect;

begin

    B := YaxisB;
    reset(DataFile);
    for i := 1 to Npoints do
    begin {Read point and build Bar rectangle}
    Readln(DataFile, x, ID);
    T := B - Round(Sy * x) + Dy * ScMin;
    L := XaxisB + Round((2 * i - 1) * Dx);
    R := XaxisB + Round((2 * i) * Dx);
    SetRect(Bar, L, T, R, B);
    PaintRect(Bar);{Plot bar by painting rectangle}
    MoveTo(L, B + 12);{Label each bar with its ID}
    WriteDraw(ID);
    end;

end; {End PlotData}

begin {Main program}

    GetInformation;
    Normalize;
    PlotAxes;
    PlotData;

end.  