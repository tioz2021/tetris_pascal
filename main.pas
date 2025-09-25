program main; uses crt, get_key;

const
    figureBg = '#';
    figuresCount = 17;

type
    figure_type_t = 1..figuresCount;
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

procedure FigureMove(var figure: figure_t; direction: direction_t);
begin
    if direction = down then
    begin
        writeln('direction: ', direction);
        figure.position.curY := figure.position.curY+1;
    end
end;

procedure FigureClear();
var
    i, j: integer;
    x, y: integer;
begin
    GotoXY(1, 1);
    x := 1;
    y := 1;
    for i := 1 to 20 do
    begin
        for j := 1 to 20 do
        begin
            GotoXY(x, y);
            write(' ');
            x := x+1;
        end;
        y := y+1;
        x := 1;
    end;
end;

procedure FigureWrite(var figure: figure_t);
var
    i, j: integer;
begin

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
                            write(figureBg)
                    end
                    else
                        write(figureBg)
                end;
                2:
                begin
                    if i <= 2 then
                    begin
                        if (j > 3) and (j < 7) then 
                            write(figureBg)
                    end
                    else
                        write(figureBg)
                end;
                3:
                begin
                    if i <= 2 then
                        write(figureBg)
                    else
                    begin
                        if j < 4 then
                            write(figureBg)
                    end
                end;
                4, 5, 9:
                begin
                    write(figureBg)
                end;
                6:
                begin
                    if i <= 2 then
                    begin
                        if j < 7 then 
                            write(figureBg)
                    end
                    else
                    begin
                        if j > 3 then
                            write(figureBg)
                    end
                end;
                7:
                begin
                    if i <= 2 then
                        write(figureBg)
                    else
                    begin
                        if (j > 3) and (j < 7) then
                            write(figureBg)
                    end
                end;
                8:
                begin
                    if i <= 2 then
                    begin
                        if j <= 3 then
                            write(figureBg)
                    end
                    else if (i > 2) and (i < 5) then
                        write(figureBg)
                    else
                    begin
                        if j > 3 then
                            write(figureBg)
                    end
                end;
                10:
                begin
                    if i <= 2 then
                    begin
                        if j <= 3 then
                            write(figureBg)
                    end
                    else if (i > 2) and (i < 5) then
                        write(figureBg)
                    else
                    begin
                        if j <= 3 then
                            write(figureBg)
                    end
                end;
                11:
                begin
                    if i <= 4 then
                    begin
                        if j <= 3 then
                            write(figureBg)
                    end
                    else
                    begin
                        write(figureBg)
                    end
                end;
                12:
                begin
                    if i <= 2 then
                        write(figureBg)
                    else
                    begin
                        if j > 6 then
                            write(figureBg)
                    end
                end;
                13:
                begin
                    if i <= 2 then
                    begin
                        if j > 3 then
                            write(figureBg)
                    end
                    else if (i > 2) and (i < 5) then
                        write(figureBg)
                    else
                    begin
                        if j > 3 then
                            write(figureBg)
                    end
                end;
                14:
                begin
                    if i <= 2 then
                        write(figureBg)
                    else
                    begin
                        if j > 3 then
                            write(figureBg)
                    end
                end;
                15:
                begin
                    if i <= 2 then
                    begin
                        if j > 3 then
                            write(figureBg)
                    end
                    else
                    begin
                        if j < 7 then
                            write(figureBg)
                    end
                end;
                16:
                begin
                    if i <= 2 then
                        write(figureBg)
                    else
                    begin
                        if j < 4 then
                            write(figureBg)
                    end
                end;
                17:
                begin
                    if i <= 2 then
                    begin
                        if j > 3 then
                            write(figureBg)
                    end
                    else if (i > 2) and (i < 5) then
                        write(figureBg)
                    else
                    begin
                        if j < 4 then
                            write(figureBg)
                    end
                end;
            end
        end;
        figure.position.curX := figure.position.x;
        figure.position.curY := figure.position.curY + 1;
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

procedure MainProcedure(var f1: figure_t);
var
    x, y: integer;
    curX, curY: integer;
begin
    x := ScreenWidth div 2;
    y := ScreenHeight div 2;
    curX := 1;
    curY := 1;
    GotoXY(x, y);
end;

var
    saveTextAttr: integer;
    x, y: integer;
    keyCode: integer;
    i, tmp: integer;
    f1: figure_t;
begin
    { init param }
    clrscr;
    saveTextAttr := TextAttr;
    i := 0;

    f1.ftype := 0;

    { main procedure }
    while true do
    begin
        if KeyPressed then
        begin
            GetKey(keyCode);
            case keyCode of
                -75: { left }
                begin
                    FigureClear();

                    f1.ftype := f1.ftype-1;

                    FigureInit(f1, f1.ftype);
                    FigureSetPosition(f1, 1, 1);
                    FigureWrite(f1);
                end;
                -77: { right }
                begin
                    FigureClear();

                    f1.ftype := f1.ftype+1;

                    FigureInit(f1, f1.ftype);
                    FigureSetPosition(f1, 1, 1);
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

        GotoXY(ScreenWidth-25, 1);
        write('figure type: ', f1.ftype, '    ');

        FigureMove(f1, down);
        FigureClear();
        FigureWrite(f1);
    end;

    { exit program }
    TextAttr := saveTextAttr;
    clrscr
end.
