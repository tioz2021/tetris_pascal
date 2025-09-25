program main; 
uses 
    crt,
    get_key;

{uses figure_api;}

const
    figureBg = '#';
    figuresCount = 17;
    speed = 500;

type
    area_t = record
        width, height: integer;
        borderChar: char;
        borderTop, borderBottom, borderLeft, borderRight: integer;
    end;
    gameSettings = record
        { base }
        speed: integer;
        lvl: integer;

        { area }
        area: area_t;
    end;

    figure_type_t = 0..figuresCount;
    figure_position_t = record
        x, y, curX, curY: integer;
    end;
    figure_size_t = record
        width, height: integer;
    end;
    figure_t = record
        position: figure_position_t;
        size: figure_size_t;
        ftype: figure_type_t;
    end;
    direction_t = (down, left, right);

procedure ClearArea(x, y, countX, countY: integer);
var
    i, j: integer;
begin
    GotoXY(x, y);

    for i := 1 to countY do
    begin
        for j := 1 to countX do
        begin
            write(' ');
            GotoXY(x+j, y+i); 
        end;
    end
end;

procedure FigureWrite(var figure: figure_t);
var
    i, j: integer;
    figureChar: char;
begin
    figureChar := figureBg;

    { print figure }
    for i := 1 to figure.size.height do
    begin
        for j := 1 to figure.size.width do
        begin
            GotoXY(figure.position.curX, figure.position.curY);
            figure.position.curX := figure.position.curX + 1;

            case figure.ftype of
                1:
                begin
                    if i <= 2 then
                    begin
                        if j > 6 then 
                            write(figureChar)
                    end
                    else
                        write(figureChar)
                end;
                2:
                begin
                    if i <= 2 then
                    begin
                        if (j > 3) and (j < 7) then 
                            write(figureChar)
                    end
                    else
                        write(figureChar)
                end;
                3:
                begin
                    if i <= 2 then
                        write(figureChar)
                    else
                    begin
                        if j < 4 then
                            write(figureChar)
                    end
                end;
                4, 5, 9:
                begin
                    write(figureChar)
                end;
                6:
                begin
                    if i <= 2 then
                    begin
                        if j < 7 then 
                            write(figureChar)
                    end
                    else
                    begin
                        if j > 3 then
                            write(figureChar)
                    end
                end;
                7:
                begin
                    if i <= 2 then
                        write(figureChar)
                    else
                    begin
                        if (j > 3) and (j < 7) then
                            write(figureChar)
                    end
                end;
                8:
                begin
                    if i <= 2 then
                    begin
                        if j <= 3 then
                            write(figureChar)
                    end
                    else if (i > 2) and (i < 5) then
                        write(figureChar)
                    else
                    begin
                        if j > 3 then
                            write(figureChar)
                    end
                end;
                10:
                begin
                    if i <= 2 then
                    begin
                        if j <= 3 then
                            write(figureChar)
                    end
                    else if (i > 2) and (i < 5) then
                        write(figureChar)
                    else
                    begin
                        if j <= 3 then
                            write(figureChar)
                    end
                end;
                11:
                begin
                    if i <= 4 then
                    begin
                        if j <= 3 then
                            write(figureChar)
                    end
                    else
                    begin
                        write(figureChar)
                    end
                end;
                12:
                begin
                    if i <= 2 then
                        write(figureChar)
                    else
                    begin
                        if j > 6 then
                            write(figureChar)
                    end
                end;
                13:
                begin
                    if i <= 2 then
                    begin
                        if j > 3 then
                            write(figureChar)
                    end
                    else if (i > 2) and (i < 5) then
                        write(figureChar)
                    else
                    begin
                        if j > 3 then
                            write(figureChar)
                    end
                end;
                14:
                begin
                    if i <= 2 then
                        write(figureChar)
                    else
                    begin
                        if j > 3 then
                            write(figureChar)
                    end
                end;
                15:
                begin
                    if i <= 2 then
                    begin
                        if j > 3 then
                            write(figureChar)
                    end
                    else
                    begin
                        if j < 7 then
                            write(figureChar)
                    end
                end;
                16:
                begin
                    if i <= 2 then
                        write(figureChar)
                    else
                    begin
                        if j < 4 then
                            write(figureChar)
                    end
                end;
                17:
                begin
                    if i <= 2 then
                    begin
                        if j > 3 then
                            write(figureChar)
                    end
                    else if (i > 2) and (i < 5) then
                        write(figureChar)
                    else
                    begin
                        if j < 4 then
                            write(figureChar)
                    end
                end
            end
        end;
        GotoXY(1, 1);
        figure.position.curX := figure.position.x;
        figure.position.curY := figure.position.curY + 1
    end;
end;

procedure FigureInit(var figure: figure_t; figureTypeId: integer);
begin
    figure.position.x := 0;
    figure.position.y := 0;
    figure.position.curX := 0;
    figure.position.curY := 0;

    case figureTypeId of
        1:
        begin
            figure.ftype := 1;
            figure.size.width := 9;
            figure.size.height := 4
        end;
        2:
        begin
            figure.ftype := 2;
            figure.size.width := 9;
            figure.size.height := 4
        end;
        3:
        begin
            figure.ftype := 3;
            figure.size.width := 6;
            figure.size.height := 6
        end;
        4:
        begin
            figure.ftype := 4;
            figure.size.width := 12;
            figure.size.height := 2
        end;
        5:
        begin
            figure.ftype := 5;
            figure.size.width := 6;
            figure.size.height := 4
        end;
        6:
        begin
            figure.ftype := 6;
            figure.size.width := 9;
            figure.size.height := 4
        end;
        7:
        begin
            figure.ftype := 7;
            figure.size.width := 9;
            figure.size.height := 4
        end;
        8:
        begin
            figure.ftype := 8;
            figure.size.width := 6;
            figure.size.height := 6
        end;
        9:
        begin
            figure.ftype := 9;
            figure.size.width := 3;
            figure.size.height := 9
        end;
        10:
        begin
            figure.ftype := 10;
            figure.size.width := 6;
            figure.size.height := 6
        end;
        11:
        begin
            figure.ftype := 11;
            figure.size.width := 6;
            figure.size.height := 6
        end;
        12:
        begin
            figure.ftype := 12;
            figure.size.width := 9;
            figure.size.height := 4
        end;
        13:
        begin
            figure.ftype := 13;
            figure.size.width := 6;
            figure.size.height := 6
        end;
        14:
        begin
            figure.ftype := 14;
            figure.size.width := 6;
            figure.size.height := 6
        end;
        15:
        begin
            figure.ftype := 15;
            figure.size.width := 9;
            figure.size.height := 4
        end;
        16:
        begin
            figure.ftype := 16;
            figure.size.width := 9;
            figure.size.height := 4
        end;
        17:
        begin
            figure.ftype := 17;
            figure.size.width := 6;
            figure.size.height := 6
        end;
        else
        begin
            figure.ftype := 0;
            figure.size.width := 0;
            figure.size.height := 0
        end
    end
end;

procedure FigureSetPosition(var figure: figure_t; x, y: integer);
begin
    figure.position.x := x;
    figure.position.y := y;
    figure.position.curX := x;
    figure.position.cury := y
end;

procedure WritePlayArea(gs: gameSettings);
var
    startPosX, startPosY: integer;
    i, j: integer;
begin
    startPosX := gs.area.borderLeft;
    startPosY := gs.area.borderTop;
    GotoXY(startPosX, startPosY);

    for i := 1 to gs.area.height do
    begin
        for j := 1 to gs.area.width do
        begin
            GotoXY(startPosX+j-1, startPosY+i-1);

            if (i = 1) or (i = gs.area.height) then
            begin
                if (j = 1) or (j = gs.area.width) then
                    write(gs.area.borderChar)
                else
                    write(gs.area.borderChar)
            end
            else
            begin
                if (j = 1) or (j = gs.area.width) then
                    write(gs.area.borderChar)
            end
        end;

    end;
    GotoXY(1, 1);
    write('area');
end;

procedure InitPlayArea(var gs: gameSettings);
begin
    gs.area.width := 22;
    gs.area.height := 34;
    gs.area.borderTop := 2;
    gs.area.borderLeft := 10;
    gs.area.borderChar := '*';
end;

var
    saveTextAttr: integer;
    keyCode: integer;
    i: integer;
    f1: figure_t;
    gs: gameSettings;
begin
    { init param }
    clrscr;
    saveTextAttr := TextAttr;
    i := 0;
    f1.ftype := 0;

    { game area param }
    InitPlayArea(gs);

    { main game cycle }
    while true do
    begin
        if KeyPressed then
        begin
            GetKey(keyCode);
            case keyCode of
                -75: { left }
                begin
                    f1.ftype := f1.ftype-1;
                    GotoXY(1, 1);
                    ClearArea(gs.area.borderLeft, gs.area.borderTop,
                        12, 12);

                    FigureInit(f1, f1.ftype);
                    FigureSetPosition(f1, gs.area.borderLeft+1, 
                        gs.area.borderTop+1);
                    FigureWrite(f1);
                end;
                -77: { right }
                begin
                    f1.ftype := f1.ftype+1;
                    GotoXY(1, 1);
                    ClearArea(gs.area.borderLeft, gs.area.borderTop,
                        12, 12);

                    FigureInit(f1, f1.ftype);
                    FigureSetPosition(f1, gs.area.borderLeft+1, 
                        gs.area.borderTop+1);
                    FigureWrite(f1);
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
            end;
        end;

        { write area }
        WritePlayArea(gs);
        
        { game info }
        GotoXY(ScreenWidth-25, 1);
        write('Game Info: ');
        GotoXY(ScreenWidth-25, 2);
        write('figure type: ', f1.ftype, '    ');
        GotoXY(ScreenWidth-25, 3);
        write('figure y: ', f1.position.y, '    ');
        GotoXY(ScreenWidth-25, 4);
        write('figure curY: ', f1.position.curY, '    ');
        GotoXY(ScreenWidth-25, 5);
        write('frame counter: ', i, '    ');

        GotoXY(ScreenWidth-25, 7);
        write('?: ', gs.area.borderTop, '    ');

        delay(100);
        GotoXY(1, 1);
        i := i + 1
    end;

    { exit program }
    TextAttr := saveTextAttr;
    clrscr
end.
