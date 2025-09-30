program main; 
uses crt, get_key;

const
    MATRIX_WIDTH = 36;
    MATRIX_HEIGHT = 34;
    MATRIX_BORDER_LEFT = 2;
    MATRIX_BORDER_TOP = 3;
    FIGURE_COUNT = 3;
    FIGURE_BG = '#';

type
    gameMatrixT = array [1..MATRIX_WIDTH + MATRIX_BORDER_LEFT,
        1..MATRIX_HEIGHT + MATRIX_BORDER_TOP] of char;

    gameSettings = record
        matrix: gameMatrixT;
        moveStatus: boolean;
    end;

    figureTypeNumberT = 1..FIGURE_COUNT;
    figureSizeT = record
        width, height: integer;
    end;
    figureT = record
        ftype: figureTypeNumberT;
        size: figureSizeT;
    end;

procedure DrawGameMatrix(var gameMatrix: gameMatrixT);
var
    x, y: integer;
begin
    for x := 1 to MATRIX_WIDTH do
    begin
        for y := 1 to MATRIX_HEIGHT do
        begin
            if (x > MATRIX_BORDER_LEFT) and (y > MATRIX_BORDER_TOP) then
            begin
                gameMatrix[x][y] := '0';
            end
        end
    end;

    for x := 1 to MATRIX_WIDTH do
    begin
        for y := 1 to MATRIX_HEIGHT do
        begin
            if (x > MATRIX_BORDER_LEFT) and (y > MATRIX_BORDER_TOP) then
                write(gameMatrix[x][y])
            else
                write(' ');
        end;
        writeln
    end;
    writeln
end;

procedure DrawChar(var gameMatrix: gameMatrixT; x, y: integer; ch: char);
var
    localX, localY: integer;
begin
    localX := x + MATRIX_BORDER_LEFT;
    localY := y + MATRIX_BORDER_TOP;

    {
    GotoXY(1, 1);
    write('gm: ',gameMatrix[localX, localY]);
    }

    gameMatrix[localY, localX] := ch;
    GotoXY(localX, localY);
    write(ch);
end;

function DrawCheckMatrix(
    var fig: figureT;
    var gameMatrix: gameMatrixT;
    x, y: integer
): boolean;
var
    i, j: integer;
begin
    GotoXY(1, 2);
    write('check x: ', x, '  ');
    write('y: ', y, '  ');
    GotoXY(1, 1);

    write(gameMatrix[y, x]);
    GotoXY(20, 2);

    if gameMatrix[y, x] = '0' then
    begin
        DrawCheckMatrix := true
    end
    else
    begin
        DrawCheckMatrix := false
    end
end;

procedure DrawFigure(
    var fig: figureT;
    var gs: gameSettings;
    x, y: integer;
    ch: char
);
var
    i, j: integer;
    draw: boolean;
begin
    for i := 1 to fig.size.height do
    begin
        for j := 1 to fig.size.width do
        begin
            case fig.ftype of
                1:
                begin
                    if i > 2 then
                    begin
                        if j > 6 then
                        begin
                            DrawChar(gs.matrix, x+j-1, y+i-1, ch)
                        end
                    end
                    else    
                    begin
                        DrawChar(gs.matrix, x+j-1, y+i-1, ch)
                    end
                end
            end
        {end for j }
        end
    {end for i }
    end;
    GotoXY(1, 1)
end;

procedure DrawFigureCheckerBorder(
    var fig: figureT;
    var gs: gameSettings;
    x, y: integer;
    ch: char
);
var
    i, j: integer;
begin
    for i := 1 to fig.size.height do
    begin
        for j := 1 to fig.size.width do
        begin
            case fig.ftype of
                1:
                begin
                    if i > 4 then
                    begin
                        if j > 6 then
                        begin
                            gs.moveStatus := DrawCheckMatrix(
                                fig,
                                gs.matrix,
                                x+j+1,
                                y+i+1
                            );
                            {DrawChar(gs.matrix, x+j-2, y+i-2, ch)}
                        end
                    end
                    else    
                    begin
                        gs.moveStatus := DrawCheckMatrix(
                            fig,
                            gs.matrix,
                            x+j+1,
                            y+i+1
                        );
                        {DrawChar(gs.matrix, x+j-2, y+i-2, ch)}
                    end
                end
            end;
        {end for j }
        end
    {end for i }
    end;
    GotoXY(1, 1)
end;

var
    fig, figB, fig2, fig2B: figureT;
    gs: gameSettings;
    keyCode: integer;
    x, y, i: integer;
    xMove, yMove: integer;
begin
    clrscr;
    
    xMove := 0;
    yMove := 0;
    gs.moveStatus := true;
    DrawGameMatrix(gs.matrix);

    fig.ftype := 1;
    fig.size.width := 9;
    fig.size.height := 6;
    figB.ftype := 1;
    figB.size.width := fig.size.width+2;
    figB.size.height := fig.size.height+2;

    fig2.ftype := 1;
    fig2.size.width := 9;
    fig2.size.height := 6;
    fig2B.ftype := 1;
    fig2B.size.width := fig2.size.width+2;
    fig2B.size.height := fig2.size.height+2;

    while true do
    begin
        
        GotoXY(20, 1);
        write('gs.moveStatus: ', gs.moveStatus);
        GotoXY(1, 1);

        DrawFigureCheckerBorder(figB, gs, xMove+MATRIX_BORDER_LEFT+1,
            yMove+1, 'x');
        DrawFigure(fig, gs, xMove+MATRIX_BORDER_LEFT+1, yMove+1, FIGURE_BG);
        delay(100);
        DrawFigure(fig, gs, xMove+MATRIX_BORDER_LEFT+1, yMove+1, '0');
        DrawFigureCheckerBorder(figB, gs, xMove+MATRIX_BORDER_LEFT+1,
            yMove+1, '0');

        DrawFigureCheckerBorder(fig2B, gs, 10, 20, 'x');
        DrawFigure(fig2, gs, 10, 20, FIGURE_BG);

        if KeyPressed then
        begin
            GetKey(keyCode);
            case keyCode of
                122: { z }
                begin
                end;
                120: { x }
                begin
                end;
                -72: { up }
                begin
                    if yMove > 0 then
                        yMove := yMove-1;
                end;
                -80: { down }
                begin
                    if yMove < (MATRIX_HEIGHT - MATRIX_BORDER_TOP-3) then
                    begin
                        if gs.moveStatus then
                            yMove := yMove+1
                    end
                end;
                -75: { left }
                begin
                    if xMove+MATRIX_BORDER_LEFT > 2 then 
                        xMove := xMove-1;
                end;
                -77: { right }
                begin
                    if xMove < (MATRIX_WIDTH -
                        fig.size.width - MATRIX_BORDER_LEFT-3) then
                    begin
                        xMove := xMove+1
                    end
                end;
                32: 
                begin
                    GotoXY(1, 1);
                    clrscr;
                    break;
                    {halt(1)}
                end;
                27: 
                begin
                    GotoXY(1, 1);
                    clrscr;
                    halt(1)
                end
            end
        end
    end;

    for x := 1 to MATRIX_WIDTH do
    begin
        for y := 1 to MATRIX_HEIGHT do
        begin
            if (x > MATRIX_BORDER_LEFT) and (y > MATRIX_BORDER_TOP) then
                write(gs.matrix[x][y])
            else
                write(' ');
        end;
        writeln
    end;
    writeln
end.
