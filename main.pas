program main; 
uses crt, get_key;

const
    MATRIX_WIDTH = 36;
    MATRIX_HEIGHT = 34;
    MATRIX_BORDER_LEFT = 2;
    MATRIX_BORDER_TOP = 2;
    FIGURE_COUNT = 17;
    FIGURE_BG = '#';

type
    gameMatrixT = array [1..MATRIX_WIDTH + MATRIX_BORDER_LEFT,
        1..MATRIX_HEIGHT + MATRIX_BORDER_TOP] of char;

    gameSettings = record
        matrix: gameMatrixT;
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
                gameMatrix[x][y] := '0';
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
    gameMatrix[localX, localY] := ch;
    GotoXY(localX, localY);
    write(ch)
end;

procedure
DrawFigure(var fig: figureT; var gameMatrix: gameMatrixT; x, y: integer);
var
    i, j: integer;
begin
    for i := 1 to fig.size.height do
    begin
        for j := 1 to fig.size.width do

        case fig.ftype of
            1:
            begin
                if i > 2 then
                begin
                    if j > 6 then
                        DrawChar(gameMatrix, x+j-1, y+i-1, FIGURE_BG)
                end
                else    
                    DrawChar(gameMatrix, x+j-1, y+i-1, FIGURE_BG)
            end;
            2:
            begin
                if i <= 2 then
                begin
                    if (j > 3) and (j < 7) then
                        DrawChar(gameMatrix, x+j-1, y+i-1, FIGURE_BG)
                end
                else    
                    DrawChar(gameMatrix, x+j-1, y+i-1, FIGURE_BG)
            end;
            3:
            begin
                if i <= 2 then
                begin
                    DrawChar(gameMatrix, x+j-1, y+i-1, FIGURE_BG)
                end
                else    
                begin
                    if j < 4 then
                        DrawChar(gameMatrix, x+j-1, y+i-1, FIGURE_BG)
                end
            end;

        end
    end
end;

var
    fig: figureT;
    gs: gameSettings;
    keyCode: integer;
    x, y, i: integer;
begin
    clrscr;
    
    DrawGameMatrix(gs.matrix);

    fig.ftype := 3;
    fig.size.width := 6;
    fig.size.height := 6;

    while true do
    begin

        DrawFigure(fig, gs.matrix, 10, 10);
        delay(250);

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
                end;
                -80: { down }
                begin
                end;
                -75: { left }
                begin
                end;
                -77: { right }
                begin
                end;
                32: 
                begin
                    GotoXY(1, 1);
                    clrscr;
                    halt(1)
                end;
                27: 
                begin
                    GotoXY(1, 1);
                    clrscr;
                    halt(1)
                end
            end
        end;
    end
end.
