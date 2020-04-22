program Transform;
{ Program to transform graphical objects } 
{ by user-specified translation, scaling, and rotation } 
{and any concatenation of these three transformations.} 
const 

    nd = 3; {Dimension of matrices} 
    ns = 100; {Maximum size of object } 
    {(in control points)} 
    VxL = 20; {Viewport left boundary} 
    VxR = 450; {Viewport right boundary} 
    VyT = 20; {Viewport top boundary} 
    VyB = 350; {Viewport bottom boundary} 
    Xo = 50; {X pixel coordinate off-set of origin} 
    Yo = 50; {Y pixel coordinate off-set of origin} 

type 

    mat = array[1..nd, 1..nd] of real; 
    var 
    dx, dy: real; 
    m: mat; 
    i, j, k, npts: integer; 
    x, y, xp, yp: array[1..ns] of real; 
    c: array[1..ns] of integer; 
    infile: text; 
    pt, xx, yy, cc: integer; 
    ViewPort: rect; 

{***************************************} 
procedure applyxfn; 
{Applies concatenated transform.} 

    var 
    i: integer; 

begin 

    for i := 1 to npts do 
    begin 
    xp[i] := x[i] * m[1, 1] + y[i] * m[2, 1] + m[3, 1]; 
    yp[i] := x[i] * m[1, 2] + y[i] * m[2, 2] + m[3, 2]; 
    end; 

end; 
{************************************} 
procedure diagmat (var xmat: mat); 
{Generates the identity matrix} 

    var 
    i, j: integer; 

begin 

    for i := 1 to nd do 
    begin 
    for j := 1 to nd do 
    xmat[i, j] := 0.0; 
    xmat[i, i] := 1.0; 
    end; 

end; 
{*************************************} 
procedure matmlt (var d, a, b: mat); 
{Calculate matrix product: D=A*B } 

    var 
    n, i, j, k: integer; 
    sum: real; 
    temp: mat; 

begin 

    n := nd; 
    for i := 1 to n do 
    begin 
    for j := 1 to n do 
    begin 
    sum := 0.0; 
    for k := 1 to n do 
    sum := sum + a[i, k] * b[k, j]; 
    temp[i, j] := sum; 
    end; 
    end; 
    for i := 1 to n do 
    for j := 1 to n do 
    d[i, j] := temp[i, j]; 

end;
 
{*****************************************} 
procedure display; 
{Procedure to draw object in viewport} 

    var 
    i, xx, yy: integer; 
    screen: rect; 

begin 

    ShowDrawing; 
    applyxfn; {Apply concatenated matrix to X vector} 
    for i := 1 to npts do {Draw object} 
    begin 
    xx := VxL + Xo + round(xp[i]); 
    yy := VyB - Yo - round(yp[i]); 
    if (c[i] = 0) then {invisible move} 
    moveto(xx, yy); 
    if (c[i] = 1) then {draw visible line} 
    lineto(xx, yy); 
    end; 

end;
 
{**************************************} 
procedure getobject; {Procedure to select } 
{and read in data file.} 

    var {Format is (xi, yi, ci).} 
    infile: text; 
    i, pt, cc: integer; 
    xx, yy: real; 

begin 

    i := 0; 
    open(infile, OldFileName('Transform DataFile?')); 
    repeat 
    i := i + 1; 
    readln(infile, xx, yy, cc); 
    x[i] := xx; 
    y[i] := yy; 
    c[i] := cc; 
    until eof(infile); 
    npts := i; 

end;
 
{*************************************} 
procedure load; 
begin 

    getobject; 
    diagmat(m); 
    display; 

end;


{**************************************} 
procedure translate; 
{Procedure to translate point by dx,dy} 

    var 
    t: mat; 

begin {Get translation parameters.} 

    writeln('Tx, Ty?'); 
    readln(dx, dy); 
    diagmat(t); {Set up matrix, T } 
    t[nd, 1] := dx; 
    t[nd, 2] := dy; 
    matmlt(m, m, t); {Now compose with M matrix} 

end;
{**************************************}
 
procedure scale; 
{Procedure to scale X by SX and Y by SY} 

    var 
    sx, sy: real; 
    s: mat; 

begin {Get scaling parameters.} 

    writeln('SX, SY?'); 
    readln(sx, sy); 
    diagmat(s); {Set up matrix, S} 
    s[1, 1] := sx; 
    s[2, 2] := sy; 
    matmlt(m, m, s); {Now compose with M} 

end; 
{***************************************} 
procedure rotate; 
{Procedure to set up rotation matrix} 

    const 
    rad = 57.29578; 
    var 
    th: real; 
    R: mat; 

begin {Get rotation angle, th} 

    writeln('Angle (deg)?'); 
    readln(th); 
    th := th / rad; 
    diagmat(R); 
    R[1, 1] := cos(th); 
    R[2, 2] := R[1, 1]; 
    R[1, 2] := sin(th); 
    R[2, 1] := -R[1, 2]; 
    matmlt(m, m, r); {Concatenate M with R} 

end;
 
{***************************************} 
procedure clear_viewprt; 
begin 

    SetRect(ViewPort, 0, 0, VxR - VxL, VyB - VyT); 
    EraseRect(ViewPort); 

end;
 
{***************************************} 
procedure menu; 

    var 
    done: Boolean; 
    command: char; 

begin 

    done := false; 
    setRect(ViewPort, VxR - 20, VyT, VxR + 80, VyB); 
    setTextRect(ViewPort); 
    ShowText; 
    setRect(ViewPort, VxL, VyT, VxR, VyB); 
    setDrawingRect(ViewPort); 
    repeat 
    writeln(' Menu'); 
    writeln('L) Load'); 
    writeln('T) Translate'); 
    writeln('S) Scale'); 
    writeln('R) Rotate'); 
    writeln('D) Display'); 
    writeln('C) Clear'); 
    writeln('Q) Quit'); 
    readln(command); 
    {Now branch to chosen procedure} 
    case command of 
    'l', 'L': 
    load; 
    't', 'T': 
    translate; 
    's', 'S': 
    scale; 
    'r', 'R': 
    rotate; 
    'd', 'D': 
    display; 
    'c', 'C': 
    clear_viewprt; 
    'q', 'Q': 
    done := true; 
    otherwise 
    begin 
    writeln('Bad command'); 
    writeln('Try again . '); 
    readln; 
    end; 
    end; 
    until done; 

end;
 
{********** Main Program *************} 
begin 

    diagmat(m); 
    getobject; 
    menu; 

end. 