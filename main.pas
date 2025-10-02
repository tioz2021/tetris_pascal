program tetris;
uses crt, get_key;

const
    FIELD_SIZE = 30;
    ACTIVE_FIGURE = '#';

type
    field_t = array[1..FIELD_SIZE, 1..FIELD_SIZE] of char;
    figure_t = array [1..4, 1..4] of char;

procedure WriteField(var field: field_t; ch: char);
var
    i, j: integer;
begin
    for i := 1 to FIELD_SIZE do
    begin
        for j := 1 to FIELD_SIZE do
        begin
            field[i][j] := ch
        end;
    end;

    for i := 1 to FIELD_SIZE do
    begin
        for j := 1 to FIELD_SIZE do
        begin
            write(field[i][j]);
        end;
        writeln
    end
end;

procedure UpdateField(var field: field_t);
var
    i, j: integer;
begin
    for i := 1 to FIELD_SIZE do
    begin
        for j := 1 to FIELD_SIZE do
        begin
            write(field[i][j]);
        end;
        writeln
    end
end;

procedure WriteFigure(
    var figure: figure_t;
    var field: field_t;
    x, y: integer;
    ch: char;
    ftype: integer
);
var
    i, j: integer;
begin
    
    case ftype of
        14: 
        begin
            {
                ######
                ######
                   ###
                   ###
                   ###
                   ###
            }
            
            for i := 1 to 6 do
            begin
                for j := 1 to 6 do
                begin
                    if not (
                        (i >= 3) and (i <= 6) and (j >= 1) and (j <= 3)
                    ) then
                    begin
                        figure[i][j] := ch
                    end
                end
            end;

            for i := 1 to 6 do
            begin
                for j := 1 to 6 do
                begin
                    // Пропускаем пустые ячейки фигуры
                    if figure[i][j] = ' ' then
                        continue;
                        
                    case i of
                        1, 2: 
                        begin
                            if (j = 1) or (j = 6) then
                            begin
                                if (field[y+i-1][x+j-1] = '0') or 
                                    (field[y+i-1][x+j-1] = ACTIVE_FIGURE)
                                then begin
                                    field[y+i-1][x+j-1] := figure[i][j]
                                end
                                else
                                    halt(1)
                            end
                            else
                            begin
                                field[y+i-1][x+j-1] := figure[i][j]
                            end;
                        end;
                        3, 4, 5: 
                        begin
                            if j >= 4 then
                                field[y+i-1][x+j-1] := figure[i][j]
                        end;
                        6: 
                        begin
                            if j >= 4 then
                            begin
                                if (field[y+i-1][x+j-1] = '0') or 
                                    (field[y+i-1][x+j-1] = ACTIVE_FIGURE)
                                then begin
                                    field[y+i-1][x+j-1] := figure[i][j]
                                end
                                else
                                    halt(1)
                            end
                        end
                    end
                end
            end
        end;
        2:
        begin
            
        end;
    end;
end;


var
    field: field_t;
    figure: figure_t;
    i: integer;
    xMove, yMove: integer;
    keyCode: integer;
begin
    clrscr;
    GotoXY(1, 1);

    WriteField(field, '0');
    WriteFigure(figure, field, 1, 15, '1', 14);
    WriteFigure(figure, field, 10, 10, '1', 14);
    UpdateField(field);

    xMove := 0;
    yMove := 0;

    i := 1;
    while true do
    begin
        clrscr;
        GotoXY(1, 1);
        WriteFigure(figure, field, xMove+5, yMove+3, ACTIVE_FIGURE, 14);
        UpdateField(field);
        delay(250);
        WriteFigure(figure, field, xMove+5, yMove+3, '0', 14);

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
                    yMove := yMove-1;
                end;
                -80: { down }
                begin
                    yMove := yMove+1
                end;
                -75: { left }
                begin
                    xMove := xMove-1;
                end;
                -77: { right }
                begin
                    xMove := xMove+1
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
        end;

        i := i + 1;
    end

end.
