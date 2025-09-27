unit figure_api;

interface
const
    figureBg = '#';
    figuresCount = 17;

type
    sizeT = record
        width, height: integer;
    end;
    positionT = record
        x, y, curX, curY: integer;
    end;
    figureTypeNumberT = 0..figuresCount;
    cordXY = record
        x, y: integer;
    end;
    pointT = record
        p1, p2, p3, p4, p5, p6, p7, p8: cordXY;
    end;
    figureT = record
        position: positionT;
        size: sizeT;
        ftype: figureTypeNumberT;
        point: pointT;
    end;

procedure FigureHide(x, y, countX, countY: integer);
procedure FigureWrite(var figure: figureT);
procedure FigureSetCollision(var figure: figureT);
procedure FigureWriteCollisionPoint(var figure: figureT);
procedure FigureInit(var figure: figureT; figureTypeId: integer);
procedure FigureSetPosition(var figure: figureT; x, y: integer);
{
procedure FigureCheckCollision();
procedure FigureRotation();
}


implementation
uses crt;

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

procedure FigureWrite(var figure: figureT);
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

procedure FigureSetCollision(var figure: figureT);
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

procedure FigureWriteCollisionPoint(var figure: figureT);
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

procedure FigureInit(var figure: figureT; figureTypeId: integer);
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

procedure FigureSetPosition(var figure: figureT; x, y: integer);
begin
    figure.position.x := x;
    figure.position.y := y;
    figure.position.curX := x;
    figure.position.cury := y;
    
    FigureSetCollision(figure);
end;

end.
