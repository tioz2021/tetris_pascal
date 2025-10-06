program Tetris;

uses crt, get_key;

const
    FIELD_WIDTH = 20;
    FIELD_HEIGHT = 30;
    FIELD_OFFSET_TOP = 2;
    FIELD_OFFSET_LEFT = 5;
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
    TField = array [1..FIELD_HEIGHT, 1..FIELD_HEIGHT] of byte;
    TFigureBody = array [1..FIGURE_HEIGHT, 1..FIGURE_WIDTH] of byte;
    TPoint = record
        x, y: byte;
    end;
    TFigure = record
        size: TPoint;
        body: TFigureBody;
        fpos: TPoint;
        ftype: byte;
        rotate: byte;
        cantPlace: boolean;
    end;

procedure InitField(var field: TField);
var
    i, j: byte;
begin
    for i := 1 to FIELD_HEIGHT do
    begin
        for j := 1 to FIELD_WIDTH do
        begin
            field[i][j] := 0
        end
    end
end;

procedure DrawField(var field: TField);
var
    i, j: byte;
begin
    for i := 1 to FIELD_HEIGHT do
    begin
        for j := 1 to FIELD_WIDTH do
        begin
            if field[i][j] > 0 then
            begin
                write('#')
            end
            else
                write('0')
            { delay(10) }
        end;
        writeln
    end
end;

procedure LoadFigure(var fig: TFigure);
var
    i, j: byte;
begin
    for i := 1 to fig.size.y do
    begin
        for j := 1 to fig.size.x do 
        begin
            fig.body[i][j] := FIGURES[fig.ftype, i, j]
        end
    end
end;

procedure
CantPlaceFigure(var fig: TFigure; var field: TField; x, y: byte);
var
    i, j: byte;
begin
    fig.cantPlace := true;

    for i := 1 to fig.size.y do
    begin
        for j := 1 to fig.size.x do
        begin
            {
            if (y+i-1 > FIELD_HEIGHT) or (x+j-1 < 1) or
                (x+j-1 > FIELD_WIDTH) or (y+i-1 < 1) then
            begin
                fig.cantPlace := false;
                exit
            end;
            }

            GotoXY(35, 1);
            write('y: ', y+i+1, ' | ', 'x: ', x+j-1, ' | ', fig.cantPlace);
            GotoXY(1, 1);
            if field[y+i+1, x+j-1] > 0 then
            begin
                fig.cantPlace := false;
                exit
            end
        end
    end
end;

procedure DrawFigure(var fig: TFigure; var field: TField);
var
    i, j: byte;
begin
    for i := 1 to fig.size.y do
    begin
        for j := 1 to fig.size.x do
        begin
            if fig.cantPlace then
            begin
                if (i = 1) or (fig.body[i][j] > 0) then
                    field[fig.fpos.y+i-2][fig.fpos.x+j-1] := fig.body[i][j];
            end
        end
    end
end;

var
    field: TField;
    curFigure, fig2: TFigure;
    xMove, yMove: byte;
    keyCode: integer;
begin
    clrscr;
    randomize;
    {curFigure.ftype := random(FIGURE_COUNT)+1;}

    curFigure.fpos.x := 1;
    curFigure.fpos.y := 1;
    curFigure.size.x := 8;
    curFigure.size.y := 5;
    curFigure.ftype := 4;
    curFigure.cantPlace := true;
    LoadFigure(curFigure);
    
    {
    fig2.x := 1;
    fig2.y := 10;
    fig2.ftype := 1;
    fig2.size.x := 8;
    fig2.size.y := 2;
    LoadFigure(fig2);
    CantPlaceFigure(fig2, field, fig2.x, fig2.y);
    DrawFigure(fig2, field);
    }

    yMove := 1;
    while true do
    begin
        clrscr;
        GotoXY(1, 1);

        if KeyPressed then
        begin
            GetKey(keyCode);
            case keyCode of 
                -80: { down }
                begin
                    GotoXY(40, 2);
                    write('cp: ', curFigure.cantPlace);
                    GotoXY(1, 1);
                    readln;
                    if curFigure.cantPlace then
                    begin
                        curFigure.fpos.y := curFigure.fpos.y+1;
                    end
                end;
                27: 
                begin
                    GotoXY(1, 1);
                    clrscr;
                    halt(1)
                end
            end
        end;

        CantPlaceFigure(curFigure, field, curFigure.fpos.x, curFigure.fpos.y);
        DrawFigure(curFigure, field);

        DrawField(field);
        delay(30);
    end

end.
