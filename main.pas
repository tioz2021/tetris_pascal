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

procedure PrintFigure(var figure: figure_t; 
    width, height, yOffset, xFirstOffset, xLastOffset: integer);
var
    i, j: integer;
begin
    { init figure size }
    figure.size.width := width;
    figure.size.height := height;

    { print figure id 1}
    for i := 1 to figure.size.height do
    begin
        for j := 1 to figure.size.width do
        begin
            GotoXY(figure.position.curX, figure.position.curY);
            figure.position.curX := figure.position.curX + 1;

            { print logic }
            if i < yOffset then
            begin
                if (j > xFirstOffset) and  (j <= xLastOffset) then
                    write(figureBg)
            end
            else
                write(figureBg)

        end;
        figure.position.curX := figure.position.x;
        figure.position.curY := figure.position.curY + 1;
    end
end;
procedure InitFigure(var figure: figure_t);
begin
    case figure.ftype of
        1:
        begin
            PrintFigure(figure, 9, 4, 3, 3, 6)
        end;
        2:
        begin
            PrintFigure(figure, 9, 4, 3, 6, 9)
        end;
        3:
        begin
            PrintFigure(figure, 12, 2, 0, 0, 0)
        end;
        4:
        begin
            PrintFigure(figure, 6, 6, 3, 1, 3)
        end;

    end;
end;

procedure MainProcedure();
var
    x, y: integer;
    curX, curY: integer;
    figure: figure_t;
begin
    x := ScreenWidth div 2;
    y := ScreenHeight div 2;
    curX := 1;
    curY := 1;
    GotoXY(x, y);


    { init figure position }
    figure.position.x := curX;
    figure.position.y := curY;
    figure.position.curX := figure.position.x;
    figure.position.curY := figure.position.y;
    figure.fType := 4;

    InitFigure(figure);
end;

var
    saveTextAttr: integer;
    x, y: integer;
    keyCode: integer;
    i: integer;
begin
    { init param }
    clrscr;
    saveTextAttr := TextAttr;
    i := 0;

    { main procedure }
    while true do
    begin
        if KeyPressed then
        begin
            GetKey(keyCode);
            case keyCode of
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

        MainProcedure()
    end;

    { exit program }
    TextAttr := saveTextAttr;
    clrscr
end.
