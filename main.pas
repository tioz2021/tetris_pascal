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
    size_t = record
        width, height: integer;
    end;
    obj_cord_xy = record
        x, y: integer;
    end;
    obj_cord = record
        a, b, c, d: obj_cord_xy;
    end;
    figure_point_t = record
        p1, p2, p3, p4, p5, p6, p7, p8: obj_cord_xy;
    end;
    area_t = record
        borderChar: char;
        borderTop, borderBottom, borderLeft, borderRight: integer;
        size: size_t;
        cord: obj_cord;
    end;
    gameSettings_t = record
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
    figure_t = record
        position: figure_position_t;
        size: size_t;
        ftype: figure_type_t;
        point: figure_point_t;
    end;
    direction_t = (down, left, right);

    qPtr = ^qRecord;
    qRecord = record
        data: figure_t;
        next: qPtr;
    end;
    FigureQueue = record
        first, last: qPtr;
    end;

function RandomizeNumber(n: integer): integer;
var
    randomNumber: integer;
begin
    randomNumber := random(n);

    if randomNumber <> 0 then
        RandomizeNumber := randomNumber
    else
    begin
        randomNumber := random(n);
        RandomizeNumber := randomNumber
    end
end;

procedure FigureHide(x, y, countX, countY: integer);
var
    i, j: integer;
begin
    GotoXY(x, y);

    for i := 1 to countY do
    begin
        for j := 1 to countX do
        begin
            GotoXY(x+j, y+i-1);
            write(' ')
        end
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
            figure.position.curX := figure.position.curX+1;

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
                    {
                    if i <= 4 then
                    begin
                        if j <= 3 then
                            write(figureChar)
                    end
                    else
                    begin
                        write(figureChar)
                    end
                    }
                    if i <= 4 then
                    begin
                        if j > 3 then
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
        figure.position.curX := figure.position.x;
        figure.position.curY := figure.position.curY+1;
        GotoXY(1, 1)
    end
end;

procedure FigureSetCollision(var figure: figure_t);
begin
    figure.point.p5.x := 0;
    figure.point.p6.x := 0;
    figure.point.p7.x := 0;
    figure.point.p8.x := 0;

    case figure.ftype of
        1: 
        begin
            figure.point.p1.x := figure.position.curX;
            figure.point.p1.y := figure.position.curY+2;

            figure.point.p2.x := figure.position.curX;
            figure.point.p2.y := figure.position.curY+3;

            figure.point.p3.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p3.y := figure.position.curY;

            figure.point.p4.x := 
                figure.position.curX + figure.size.width-3;
            figure.point.p4.y := figure.position.curY;

            figure.point.p5.x := 
                figure.position.curX + figure.size.width-4;
            figure.point.p5.y := figure.position.curY+1;

            figure.point.p6.x :=
                figure.position.curX + figure.size.width-1;
            figure.point.p6.y := figure.position.curY+3
        end;
        2:
        begin
            figure.point.p1.x := figure.position.curX+3;
            figure.point.p1.y := figure.position.curY;
            
            figure.point.p2.x := figure.position.curX+5;
            figure.point.p2.y := figure.position.curY;

            figure.point.p3.x := figure.position.curX+2;
            figure.point.p3.y := figure.position.curY+1;

            figure.point.p4.x :=
                figure.position.curX + figure.size.width-3;
            figure.point.p4.y := figure.position.curY+1;

            figure.point.p5.x := figure.position.curX;
            figure.point.p5.y := figure.position.curY+2;

            figure.point.p6.x := figure.position.curX; 
            figure.point.p6.y := figure.position.curY+3;

            figure.point.p7.x :=
                figure.position.curX + figure.size.width-1;
            figure.point.p7.y := figure.position.curY+2;

            figure.point.p8.x :=
                figure.position.curX + figure.size.width-1;
            figure.point.p8.y := figure.position.curY+3;
        end;
        3:
        begin
            figure.point.p1.x := figure.position.curX;
            figure.point.p1.y := figure.position.curY;

            
            figure.point.p2.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p2.y := figure.position.curY;

            figure.point.p3.x := figure.position.curX;
            figure.point.p3.y := figure.position.curY+1;

            figure.point.p4.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p4.y := figure.position.curY+1;

            figure.point.p5.x := figure.position.curX;
            figure.point.p5.y := 
                figure.position.curY + figure.size.height-1;

            figure.point.p6.x := figure.position.curX+2;
            figure.point.p6.y := 
                figure.position.curY + figure.size.height-1;
        end;
        4:
        begin
            figure.point.p1.x := figure.position.curX;
            figure.point.p1.y := figure.position.curY;

            figure.point.p2.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p2.y := figure.position.curY;

            figure.point.p3.x := figure.position.curX; 
            figure.point.p3.y := figure.position.curY+1;

            figure.point.p4.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p4.y := figure.position.curY+1;
        end;
        5:
        begin
            figure.point.p1.x := figure.position.curX;
            figure.point.p1.y := figure.position.curY;

            figure.point.p2.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p2.y := figure.position.curY;

            figure.point.p3.x := figure.position.curX; 
            figure.point.p3.y := 
                figure.position.curY + figure.size.height-1;

            figure.point.p4.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p4.y := 
                figure.position.curY + figure.size.height-1;
        end;
        6:
        begin
            figure.point.p1.x := figure.position.curX;
            figure.point.p1.y := figure.position.curY;

            figure.point.p2.x := 
                figure.position.curX + figure.size.width-4;
            figure.point.p2.y := figure.position.curY;

            figure.point.p3.x := figure.position.curX;
            figure.point.p3.y := figure.position.curY+1;

            figure.point.p4.x := 
                figure.position.curX + figure.size.width-4;
            figure.point.p4.y := figure.position.curY+1;

            figure.point.p5.x := figure.position.curX+3;
            figure.point.p5.y := figure.position.curY+2;

            figure.point.p6.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p6.y := figure.position.curY+2;

            figure.point.p7.x := figure.position.curX+3;
            figure.point.p7.y := figure.position.curY+3;

            figure.point.p8.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p8.y := figure.position.curY+3;
        end;
        7:
        begin
            figure.point.p1.x := figure.position.curX;
            figure.point.p1.y := figure.position.curY;

            figure.point.p2.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p2.y := figure.position.curY;

            figure.point.p3.x := figure.position.curX;
            figure.point.p3.y := figure.position.curY+1;

            figure.point.p4.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p4.y := figure.position.curY+1;

            figure.point.p5.x := figure.position.curX+2;
            figure.point.p5.y := figure.position.curY+2;

            figure.point.p6.x := 
                figure.position.curX + figure.size.width-3;
            figure.point.p6.y := figure.position.curY+2;

            figure.point.p7.x := figure.position.curX+2;
            figure.point.p7.y := figure.position.curY+3;

            figure.point.p8.x := 
                figure.position.curX + figure.size.width-3;
            figure.point.p8.y := figure.position.curY+3;
        end;
        8:
        begin
            figure.point.p1.x := figure.position.curX;
            figure.point.p1.y := figure.position.curY;

            figure.point.p2.x := figure.position.curX+2;
            figure.point.p2.y := figure.position.curY;

            figure.point.p3.x := figure.position.curX;
            figure.point.p3.y := figure.position.curY+3;

            figure.point.p4.x := figure.position.curX+2;
            figure.point.p4.y := figure.position.curY+1;

            figure.point.p5.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p5.y := figure.position.curY+2;

            figure.point.p6.x := 
                figure.position.curX + figure.size.width-3;
            figure.point.p6.y := 
                figure.position.curY + figure.size.height-1;

            figure.point.p7.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p7.y := 
                figure.position.curY + figure.size.height-1;
        end;
        9:
        begin
            figure.point.p1.x := figure.position.curX;
            figure.point.p1.y := figure.position.curY;

            figure.point.p2.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p2.y := figure.position.curY;

            figure.point.p3.x := figure.position.curX;
            figure.point.p3.y :=
                figure.position.curY + figure.size.height-1;

            figure.point.p4.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p4.y :=
                figure.position.curY + figure.size.height-1;
        end;
        10:
        begin
            figure.point.p1.x := figure.position.curX;
            figure.point.p1.y := figure.position.curY;

            figure.point.p2.x := figure.position.curX+2;
            figure.point.p2.y := figure.position.curY;

            figure.point.p3.x := figure.position.curX;
            figure.point.p3.y := 
                figure.position.curY + figure.size.height-1;

            figure.point.p4.x := figure.position.curX+3;
            figure.point.p4.y := figure.position.curY+1;

            figure.point.p5.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p5.y := figure.position.curY+2;

            figure.point.p6.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p6.y := figure.position.curY+3;

            figure.point.p7.x := figure.position.curX+3;
            figure.point.p7.y := figure.position.curY+4;

            figure.point.p8.x := figure.position.curX+2;
            figure.point.p8.y := 
                figure.position.curY + figure.size.height-1;
        end;
        11:
        begin
            figure.point.p1.x := figure.position.curX+3;
            figure.point.p1.y := figure.position.curY;

            figure.point.p2.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p2.y := figure.position.curY;

            figure.point.p3.x := figure.position.curX+2;
            figure.point.p3.y := figure.position.curY+3;

            figure.point.p4.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p4.y := 
                figure.position.curY + figure.size.height-1;

            figure.point.p5.x := figure.position.curX;
            figure.point.p5.y := 
                figure.position.curY + figure.size.height-1;

            figure.point.p6.x := figure.position.curX;
            figure.point.p6.y := 
                figure.position.curY + figure.size.height-2;
        end;
        12:
        begin
            figure.point.p1.x := figure.position.curX;
            figure.point.p1.y := figure.position.curY;

            figure.point.p2.x :=
                figure.position.curX + figure.size.width-1;
            figure.point.p2.y := figure.position.curY;

            figure.point.p3.x := figure.position.curX;
            figure.point.p3.y := figure.position.curY+1;

            figure.point.p4.x :=
                figure.position.curX + figure.size.width-1;
            figure.point.p4.y := figure.position.curY+1;

            figure.point.p5.x :=
                figure.position.curX + figure.size.width-4;
            figure.point.p5.y := figure.position.curY+2;

            figure.point.p6.x :=
                figure.position.curX + figure.size.width-3;
            figure.point.p6.y := 
                figure.position.curY + figure.size.height-1;

            figure.point.p7.x :=
                figure.position.curX + figure.size.width-1;
            figure.point.p7.y := 
                figure.position.curY + figure.size.height-1;
        end;
        13:
        begin
            figure.point.p1.x := figure.position.curX+3;
            figure.point.p1.y := figure.position.curY;

            figure.point.p2.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p2.y := figure.position.curY;

            figure.point.p3.x := figure.position.curX+2;
            figure.point.p3.y := figure.position.curY+1;

            figure.point.p4.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p4.y := 
                figure.position.curY + figure.size.height-1;

            figure.point.p5.x := 
                figure.position.curX + figure.size.width-3;
            figure.point.p5.y := 
                figure.position.curY + figure.size.height-1;

            figure.point.p6.x := figure.position.curX+2;
            figure.point.p6.y := figure.position.curY+4;

            figure.point.p7.x := figure.position.curX;
            figure.point.p7.y := figure.position.curY+2;

            figure.point.p8.x := figure.position.curX;
            figure.point.p8.y := figure.position.curY+3;
        end;
        14:
        begin
            figure.point.p1.x := figure.position.curX;
            figure.point.p1.y := figure.position.curY;

            figure.point.p2.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p2.y := figure.position.curY;

            figure.point.p3.x := figure.position.curX;
            figure.point.p3.y := figure.position.curY+1;

            figure.point.p4.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p4.y := figure.position.curY+1;

            figure.point.p5.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p5.y := 
                figure.position.curY + figure.size.height-1;

            figure.point.p6.x := 
                figure.position.curX + figure.size.width-3;
            figure.point.p6.y := 
                figure.position.curY + figure.size.height-1;

            figure.point.p7.x := figure.position.curX+2;
            figure.point.p7.y := figure.position.curY+2;
        end;
        15:
        begin
            figure.point.p1.x := figure.position.curX+3;
            figure.point.p1.y := figure.position.curY;

            figure.point.p2.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p2.y := figure.position.curY;

            figure.point.p3.x := figure.position.curX+3;
            figure.point.p3.y := figure.position.curY+1;

            figure.point.p4.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p4.y := figure.position.curY+1;

            figure.point.p5.x := figure.position.curX;
            figure.point.p5.y := figure.position.curY+2;

            figure.point.p6.x :=
                figure.position.curX + figure.size.width-3;
            figure.point.p6.y := figure.position.curY+2;

            figure.point.p7.x := figure.position.curX;
            figure.point.p7.y := figure.position.curY+3;
            
            figure.point.p8.x := figure.position.curX;
            figure.point.p8.x :=
                figure.position.curX + figure.size.width-4;
        end;
        16:
        begin
            figure.point.p1.x := figure.position.curX;
            figure.point.p1.y := figure.position.curY;

            figure.point.p2.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p2.y := figure.position.curY;

            figure.point.p3.x := figure.position.curX;
            figure.point.p3.y := 
                figure.position.curY + figure.size.height-1;

            figure.point.p4.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p4.y := figure.position.curY+1;

            figure.point.p5.x := figure.position.curX+3;
            figure.point.p5.y := figure.position.curY+2;

            figure.point.p6.x := figure.position.curX+2;
            figure.point.p6.y := 
                figure.position.curY + figure.size.height-1;
        end;
        17:
        begin
            figure.point.p1.x := figure.position.curX+3;
            figure.point.p1.y := figure.position.curY;

            figure.point.p2.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p2.y := figure.position.curY;

            figure.point.p3.x := figure.position.curX+3;
            figure.point.p3.y := figure.position.curY+1;

            figure.point.p4.x := 
                figure.position.curX + figure.size.width-1;
            figure.point.p4.y :=
                figure.position.curY + figure.size.height-3;

            figure.point.p5.x := figure.position.curX;
            figure.point.p5.y :=
                figure.position.curY + figure.size.height-1;

            figure.point.p6.x := figure.position.curX+3;
            figure.point.p6.y :=
                figure.position.curY + figure.size.height-2;

            figure.point.p7.x := figure.position.curX+2;
            figure.point.p7.y :=
                figure.position.curY + figure.size.height-1;

        end;
    end;
end;

procedure FigureWriteCollisionPoint(var figure: figure_t);
begin
    GotoXY(figure.point.p1.x, figure.point.p1.y);
    write('1');
    GotoXY(figure.point.p2.x, figure.point.p2.y);
    write('2');
    GotoXY(figure.point.p3.x, figure.point.p3.y);
    write('3');
    GotoXY(figure.point.p4.x, figure.point.p4.y);
    write('4');
    if figure.point.p5.x <> 0 then
    begin
        GotoXY(figure.point.p5.x, figure.point.p5.y);
        write('5')
    end;
    if figure.point.p6.x <> 0 then
    begin
        GotoXY(figure.point.p6.x, figure.point.p6.y);
        write('6')
    end;
    if figure.point.p7.x <> 0 then
    begin
        GotoXY(figure.point.p7.x, figure.point.p7.y);
        write('7')
    end;
    if figure.point.p8.x <> 0 then
    begin
        GotoXY(figure.point.p8.x, figure.point.p8.y);
        write('8')
    end;
end;

procedure FigureInit(var figure: figure_t; figureTypeId: integer);
begin
    case figureTypeId of
        1:
        begin
            figure.ftype := 1;
            figure.size.width := 9;
            figure.size.height := 4;
            
            FigureSetCollision(figure);
        end;
        2:
        begin
            figure.ftype := 2;
            figure.size.width := 9;
            figure.size.height := 4;

            FigureSetCollision(figure);
        end;
        3:
        begin
            figure.ftype := 3;
            figure.size.width := 6;
            figure.size.height := 6;

            FigureSetCollision(figure);
        end;
        4:
        begin
            figure.ftype := 4;
            figure.size.width := 12;
            figure.size.height := 2;

            FigureSetCollision(figure);
        end;
        5:
        begin
            figure.ftype := 5;
            figure.size.width := 6;
            figure.size.height := 4;

            FigureSetCollision(figure);
        end;
        6:
        begin
            figure.ftype := 6;
            figure.size.width := 9;
            figure.size.height := 4;

            FigureSetCollision(figure);
        end;
        7:
        begin
            figure.ftype := 7;
            figure.size.width := 9;
            figure.size.height := 4;

            FigureSetCollision(figure);
        end;
        8:
        begin
            figure.ftype := 8;
            figure.size.width := 6;
            figure.size.height := 6;

            FigureSetCollision(figure);
        end;
        9:
        begin
            figure.ftype := 9;
            figure.size.width := 3;
            figure.size.height := 9;

            FigureSetCollision(figure);
        end;
        10:
        begin
            figure.ftype := 10;
            figure.size.width := 6;
            figure.size.height := 6;

            FigureSetCollision(figure);
        end;
        11:
        begin
            figure.ftype := 11;
            figure.size.width := 6;
            figure.size.height := 6;

            FigureSetCollision(figure);
        end;
        12:
        begin
            figure.ftype := 12;
            figure.size.width := 9;
            figure.size.height := 4;

            FigureSetCollision(figure);
        end;
        13:
        begin
            figure.ftype := 13;
            figure.size.width := 6;
            figure.size.height := 6;

            FigureSetCollision(figure);
        end;
        14:
        begin
            figure.ftype := 14;
            figure.size.width := 6;
            figure.size.height := 6;

            FigureSetCollision(figure);
        end;
        15:
        begin
            figure.ftype := 15;
            figure.size.width := 9;
            figure.size.height := 4;

            FigureSetCollision(figure);
        end;
        16:
        begin
            figure.ftype := 16;
            figure.size.width := 9;
            figure.size.height := 4;

            FigureSetCollision(figure);
        end;
        17:
        begin
            figure.ftype := 17;
            figure.size.width := 6;
            figure.size.height := 6;

            FigureSetCollision(figure);
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
    figure.position.cury := y;
    
    FigureSetCollision(figure);
end;

procedure PlayAreaWrite(gs: gameSettings_t);
var
    startPosX, startPosY: integer;
    i, j: integer;
begin
    startPosX := gs.area.borderLeft;
    startPosY := gs.area.borderTop;
    GotoXY(startPosX, startPosY);

    for i := 1 to gs.area.size.height do
    begin
        for j := 1 to gs.area.size.width do
        begin
            GotoXY(startPosX+j-1, startPosY+i-1);

            if (i = 1) or (i = gs.area.size.height) then
            begin
                if (j = 1) or (j = gs.area.size.width) then
                    write(gs.area.borderChar)
                else
                    write(gs.area.borderChar)
            end
            else
            begin
                if (j = 1) or (j = gs.area.size.width) then
                    write(gs.area.borderChar)
            end
        end
    end
end;

procedure PlayAreaInit(var gs: gameSettings_t);
begin
    gs.area.size.width := 36;
    gs.area.size.height := 34;
    gs.area.borderTop := 2;
    gs.area.borderLeft := 10;
    gs.area.borderChar := '*';

    { area cord }
    gs.area.cord.a.y := gs.area.borderTop;
    gs.area.cord.a.x := gs.area.borderLeft-1;

    gs.area.cord.b.y := gs.area.borderTop;
    gs.area.cord.b.x := gs.area.borderLeft + gs.area.size.width;

    gs.area.cord.c.y := gs.area.borderTop + gs.area.size.height-1;
    gs.area.cord.c.x := gs.area.borderLeft + gs.area.size.width;

    gs.area.cord.d.y := gs.area.borderTop + gs.area.size.height-1;
    gs.area.cord.d.x := gs.area.borderLeft-1;
end;

procedure GameStatusDebug(f1: figure_t;
    gs: gameSettings_t; gameLoopCounter: integer);
begin
    GotoXY(ScreenWidth-25, 1);
    write('Game Info: ');
    GotoXY(ScreenWidth-25, 2);
    write('figure type: ', f1.ftype, '    ');
    GotoXY(ScreenWidth-25, 3);
    write('f1 pos curX: ', f1.position.curX, '    ');
    GotoXY(ScreenWidth-25, 4);
    write('f1 pos curY: ', f1.position.curY, '    ');

    GotoXY(ScreenWidth-25, 8);
    write('GameLoopCounter: ', gameLoopCounter, '    ')
end;

var
    saveTextAttr: integer;
    keyCode: integer;
    xMove, yMove: integer;
    gs: gameSettings_t;
    f1: figure_t;
    fq: FigureQueue;
    gameLoopCounter: integer;
begin
    { base }
    clrscr;
    saveTextAttr := TextAttr;
    xMove := 0;
    yMove := 0;
    gameLoopCounter := 0;

    { spawn random figure }
    randomize;
    { # ftype }
    f1.ftype := RandomizeNumber(figuresCount);
    {f1.ftype := 1;}

    { game area param }
    PlayAreaInit(gs);

    FigureInit(f1, f1.ftype);
    FigureSetPosition(f1, gs.area.borderLeft+1, gs.area.borderTop+1);

    { init FigureQueue }
    fq.first := nil;
    fq.last := nil;
    new(fq.first);
    fq.first^.data := f1;
    fq.first^.next := nil;
    fq.last := fq.first;

    { main game cycle }
    while gameLoopCounter < 15 do
    begin
        if KeyPressed then
        begin
            GetKey(keyCode);
            write(keyCode);

            case keyCode of
                122: { z  change figure type - }
                begin
                    f1.ftype := f1.ftype-1
                end;
                120: { x  change figure type + }
                begin
                    f1.ftype := f1.ftype+1
                end;
                -72: { up }
                begin
                    yMove := yMove-1
                end;
                -80: { down }
                begin
                    yMove := yMove+1
                end;
                -75: { left }
                begin
                    {11}
                    if f1.position.curX > gs.area.cord.a.x+2 then
                    begin
                        xMove := xMove-1
                    end
                end;
                -77: { right }
                begin
                    if f1.position.curX < 
                        gs.area.cord.b.x - f1.size.width-1 then 
                    begin
                        xMove := xMove+1
                    end
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

        { # write area }
        PlayAreaWrite(gs);

        { # write }
        FigureInit(f1, f1.ftype);
        FigureSetPosition(
            f1,
            gs.area.borderLeft + 1 + xMove,
            gs.area.borderTop + 1 + yMove
        );
        FigureWrite(f1);

        FigureWriteCollisionPoint(f1);
        
        {readln;}
            
        delay(200);

        if f1.position.curY < gs.area.size.height+1 then
        begin
            FigureHide(
                gs.area.borderLeft + xMove,
                gs.area.borderTop + 1 + yMove,          
                f1.size.width,
                f1.size.height 
            );
            yMove := yMove+1
        end
        else if f1.position.curY = gs.area.size.height+1 then
        begin
            yMove := 0;

            { spawn random figure }
            f1.ftype := RandomizeNumber(figuresCount);
            xMove := RandomizeNumber(
                gs.area.size.width - f1.size.width);
            
            { add f1 to queue }
            new(fq.last^.next);
            fq.last^.data := f1;
            fq.last := fq.last^.next;

            gameLoopCounter := gameLoopCounter+1
        end;

        { # game info }
        GameStatusDebug(f1, gs, gameLoopCounter);
        GotoXY(1, 1);

        GotoXY(gs.area.cord.a.x, gs.area.cord.a.y);
        write('a');

        GotoXY(gs.area.cord.b.x, gs.area.cord.b.y);
        write('b');

        GotoXY(gs.area.cord.c.x, gs.area.cord.c.y);
        write('c');

        GotoXY(gs.area.cord.d.x, gs.area.cord.d.y);
        write('d');
    end;

    {
    clrscr;
    GotoXY(1, 1);
    }

    { check figures }
    while fq.first^.next <> nil do
    begin
        writeln('fType: ', fq.first^.data.ftype);
        writeln('fHeight: ', fq.first^.data.size.height);
        writeln('fWidth: ', fq.first^.data.size.width);
        writeln;
        fq.first := fq.first^.next
    end;

    { exit program }
    TextAttr := saveTextAttr;
    clrscr
end.
