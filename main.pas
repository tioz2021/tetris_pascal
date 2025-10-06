program Tetris;

uses crt, SysUtils, get_key;

const
    FIELD_WIDTH = 20;
    FIELD_HEIGHT = 30;
    FIELD_OFFSET_Y = 2;
    FIELD_OFFSET_X = 5;
    FIGURE_COUNT = 7;
    FIGURE_WIDTH = 8;
    FIGURE_HEIGHT = 8;

    FIGURES: array [
        1..FIGURE_COUNT, 1..FIGURE_HEIGHT, 1..FIGURE_WIDTH
    ] of byte = (
        { I/ftype = 1 }
        (
            { row 1/2 }
            (0, 0, 0, 0, 0, 0, 0, 0), (1, 1, 1, 1, 1, 1, 1, 1),
            { row 3/4 }
            (1, 1, 1, 1, 1, 1, 1, 1), (0, 0, 0, 0, 0, 0, 0, 0),
            { row 5/6 }
            (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0),
            { row 7/8 }
            (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0)
        ),
        { O/ftype = 2 }
        (
            { row 1/2 }
            (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 1, 1, 1, 1, 0, 0),
            { row 3/4 }
            (0, 0, 1, 1, 1, 1, 0, 0), (0, 0, 1, 1, 1, 1, 0, 0),
            { row 5/6 }
            (0, 0, 1, 1, 1, 1, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0),
            { row 7/8 }
            (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0)
        ),
        { T/ftype = 3 }
        (
            { row 1/2 }
            (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 1, 1, 0, 0, 0, 0),
            { row 3/4 }
            (0, 0, 1, 1, 0, 0, 0, 0), (1, 1, 1, 1, 1, 1, 0, 0),
            { row 5/6 }
            (1, 1, 1, 1, 1, 1, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0),
            { row 7/8 }
            (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0)
        ),
        { S/ftype = 4 }
        (
            { row 1/2 }
            (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 1, 1, 1, 1, 0, 0),
            { row 3/4 }
            (0, 0, 1, 1, 1, 1, 0, 0), (1, 1, 1, 1, 0, 0, 0, 0),
            { row 5/6 }
            (1, 1, 1, 1, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0),
            { row 7/8 }
            (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0)
        ),
        { Z/ftype = 5 }
        (
            { row 1/2 }
            (0, 0, 0, 0, 0, 0, 0, 0), (1, 1, 1, 1, 0, 0, 0, 0),
            { row 3/4 }
            (1, 1, 1, 1, 0, 0, 0, 0), (0, 0, 1, 1, 1, 1, 0, 0),
            { row 5/6 }
            (0, 0, 1, 1, 1, 1, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0),
            { row 7/8 }
            (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0)
        ),
        { J/ftype = 6 }
        (
            { row 1/2 }
            (0, 0, 0, 0, 0, 0, 0, 0), (1, 1, 0, 0, 0, 0, 0, 0),
            { row 3/4 }
            (1, 1, 0, 0, 0, 0, 0, 0), (1, 1, 1, 1, 1, 1, 0, 0),
            { row 5/6 }
            (1, 1, 1, 1, 1, 1, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0),
            { row 7/8 }
            (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0)
        ),
        { L/ftype = 7 }
        (
            { row 1/2 }
            (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 1, 1, 0, 0),
            { row 3/4 }
            (0, 0, 0, 0, 1, 1, 0, 0), (1, 1, 1, 1, 1, 1, 0, 0),
            { row 5/6 }
            (1, 1, 1, 1, 1, 1, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0),
            { row 7/8 }
            (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0)
        )
    );

type
    TField = array[1..FIELD_HEIGHT, 1..FIELD_WIDTH] of byte;
    TFigure = array[1..FIGURE_HEIGHT, 1..FIGURE_WIDTH] of byte;

{ #global var}
var
    field: TField;
    currentFig: TFigure;
    figX, figY, figType: byte;
    score, level: integer;
    gameOver: boolean;

procedure DrawInfo;
begin
    TextColor(Yellow);
    GotoXY(FIELD_OFFSET_X + FIELD_WIDTH + 5, FIELD_OFFSET_Y);
    write('TETRIS');

    GotoXY(FIELD_OFFSET_X + FIELD_WIDTH + 5, FIELD_OFFSET_Y + 2);
    write('Score: ');
    TextColor(Red);
    write(score);
    TextColor(Yellow);

    GotoXY(FIELD_OFFSET_X + FIELD_WIDTH + 5, FIELD_OFFSET_Y + 3);
    write('Level: ');
    TextColor(Red);
    write(level);
    TextColor(Yellow);

    GotoXY(FIELD_OFFSET_X + FIELD_WIDTH + 5, FIELD_OFFSET_Y + 5);
    write('Управление:');
    GotoXY(FIELD_OFFSET_X + FIELD_WIDTH + 5, FIELD_OFFSET_Y + 6);
    write('LeftArrow/RightArrow - влево/вправо');
    GotoXY(FIELD_OFFSET_X + FIELD_WIDTH + 5, FIELD_OFFSET_Y + 7);
    write('UpArrow - поворот');
    GotoXY(FIELD_OFFSET_X + FIELD_WIDTH + 5, FIELD_OFFSET_Y + 8);
    write('DownArrow - быстрее');
    GotoXY(FIELD_OFFSET_X + FIELD_WIDTH + 5, FIELD_OFFSET_Y + 9);
    write('ESC - выход');
end;

procedure InitField;
var
    i, j: byte;
begin
    for i := 1 to FIELD_HEIGHT do
    begin
        for j := 1 to FIELD_WIDTH do
        begin
            field[i, j] := 0;
        end
    end
end;

procedure DrawBorder;
var
    i: byte;
begin
    for i := 1 to FIELD_HEIGHT do
    begin
        GotoXY(FIELD_OFFSET_X - 1, FIELD_OFFSET_Y + i - 1);
        write('|');
        GotoXY(FIELD_OFFSET_X + FIELD_WIDTH, FIELD_OFFSET_Y + i - 1);
        write('|');
    end;
    GotoXY(FIELD_OFFSET_X - 1, FIELD_OFFSET_Y + FIELD_HEIGHT);
    for i := 1 to FIELD_WIDTH + 2 do
        write('-')
end;

procedure DrawField;
var
    i, j: byte;
begin
    for i := 1 to FIELD_HEIGHT do
    begin
        for j := 1 to FIELD_WIDTH do
        begin
            GotoXY(FIELD_OFFSET_X + j - 1, FIELD_OFFSET_Y + i - 1);
            if field[i, j] > 0 then
            begin
                TextColor(field[i, j]);
                write('#')
            end
            else
                write(' ')
        end
    end
end;

procedure LoadFigure(figNum: byte);
var
    i, j: byte;
begin
    for i := 1 to FIGURE_HEIGHT do
    begin
        for j := 1 to FIGURE_WIDTH do
        begin
            currentFig[i, j] := FIGURES[figNum, i, j]
        end
    end
end;

procedure RotateFigure;
var
    tmpFig: TFigure;
    i, j: byte;
begin
    for i := 1 to FIGURE_HEIGHT do
    begin
        for j := 1 to FIGURE_WIDTH do
        begin
            tmpFig[i, j] := currentFig[FIGURE_HEIGHT - j + 1, i]
        end
    end;
    currentFig := tmpFig
end;

function CanPlace(x, y: integer): boolean;
var
    i, j: byte;
begin
    CanPlace := true;
    for i := 1 to FIGURE_HEIGHT do
    begin
        for j := 1 to FIGURE_WIDTH do
        begin
            if currentFig[i, j] > 0 then
            begin
                if (x + i - 1 > FIELD_HEIGHT) or (x + j - 1 < 1) or
                    (x + j - 1 > FIELD_WIDTH) or (y + i - 1 < 1) then
                begin
                    CanPlace := false;
                    exit
                end;

                if field[y + i - 1, x + j - 1] > 0 then
                begin
                    CanPlace := false;
                    exit
                end
            end
        end
    end
end;

procedure PlaceFigure;
var
    i, j: byte;
begin
    for i := 1 to FIGURE_HEIGHT do
    begin
        for j := 1 to FIGURE_WIDTH do
        begin
            if currentFig[i, j] > 0 then
                field[figY + i - 1, figX + j - 1] := figType
        end
    end
end;

procedure DrawCurrentFigure;
var
    i, j: byte;
begin
    TextColor(figType);
    for i := 1 to FIGURE_HEIGHT do
    begin
        for j := 1 to FIGURE_WIDTH do
        begin
            if currentFig[i, j] > 0 then
            begin
                GotoXY(
                    FIELD_OFFSET_X + figX + j - 2,
                    FIELD_OFFSET_Y + figY + i - 3
                );
                write('#')
            end
        end
    end
end;

procedure CheckLines;
var
    i, j, k: byte;
    full: boolean;
    linesCleared: byte;
begin
    linesCleared := 0;
    i := FIELD_HEIGHT;

    while i >= 1 do
    begin
        full := true;
        for j := 1 to FIELD_WIDTH do
        begin
            if field[i, j] = 0 then
            begin
                full := false;
                break
            end
        end;
    
        if full then
        begin
            linesCleared := linesCleared + 1;
            for k := i downto (FIGURE_COUNT div 2) do
            begin
                for j := 1 to FIELD_WIDTH do
                begin
                    field[k, j] := field[k - 1, j]
                end;
                for j := 1 to FIELD_WIDTH do
                begin
                    field[1, j] := 0
                end;
            end
        end
        else
            i := i - 1
    end;

    if linesCleared > 0 then
    begin
        score := score + linesCleared * 100 * level;
        if score div 1000 > level - 1 then
        begin
            level := level + 1;
        end
    end
end;

procedure NewFigure;
begin
    figType := random(FIGURE_COUNT) + 1;
    LoadFigure(figType);
    figX := FIELD_WIDTH div 2 - 1;
    figY := 1;

    if not CanPlace(figX, figY) then
        gameOver := true
end;

var
    lastMove: QWord;
    moveDelay: integer;
    keyCode: integer;
    saveTextAttr: integer;
begin
    randomize;
    clrscr;
    saveTextAttr := TextAttr;

    InitField;
    score := 0;
    level := 1;
    gameOver := false;

    DrawBorder;
    NewFigure;
    lastMove := GetTickCount64;

    while not gameOver do
    begin
        moveDelay := 500 - (level - 1) * 50;
        if moveDelay < 100 then
            moveDelay := 100;

        if KeyPressed then
        begin
            GetKey(keyCode);
            case keyCode of
                -75: { left }
                begin
                    if CanPlace(figX - 1, figY) then
                        figX := figX - 1;
                end;
                -77: { right }
                begin
                    if CanPlace(figX + 1, figY) then
                        figX := figX + 1;
                end;
                -72: { up }
                begin
                    RotateFigure;
                    if not CanPlace(figX, figY)then
                    begin
                        RotateFigure;
                        RotateFigure;
                        RotateFigure
                    end
                end;
                -80: { down }
                begin
                    moveDelay := 50
                end;
                27: { esc }
                begin
                    gameOver := true
                end
            end;
        end;

        if (GetTickCount64 - lastMove > moveDelay) then
        begin
            if CanPlace(figX, figY + 1) then
                figY := figY + 1
            else
            begin
                PlaceFigure;
                CheckLines;
                NewFigure
            end;
                
            lastMove := GetTickCount64;
        end;

        DrawField;
        DrawCurrentFigure;
        DrawInfo;

        delay(30)
    end;

    { Post game info }
    clrscr;
    GotoXY(1, 1);
    TextColor(RED);
    write('Score: ', score);
    GotoXY(FIELD_OFFSET_X + FIELD_WIDTH + 5, FIELD_OFFSET_Y + 3);
    TextAttr := SaveTextAttr;
    GotoXY(1, 3);
    Write('Please Type Enter for close game');
    readln;
    clrscr
end.
