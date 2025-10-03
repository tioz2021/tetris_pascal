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
        { I }
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
        { O }
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
        { T }
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
        { S }
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
        { Z }
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
        { J }
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
        { L }
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
        {((0,0,0,0), (0,0,1,0), (1,1,1,0), (0,0,0,0))}
    );

type
    TField = array [1..FIELD_HEIGHT, 1..FIELD_HEIGHT] of byte;
    TFigureBody = array [1..FIGURE_HEIGHT, 1..FIGURE_WIDTH] of byte;
    TFigure = record
        body: TFigureBody;
        x, y: integer;
        ftype: byte;
        rotate: integer;
    end;

{ #global var }
var
    score, level: integer;
    gameOver: boolean;
    ch: char;

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
        end;
        writeln
    end
end;

procedure InitFigure(var fig: TFigure);
var
    i, j: byte;
begin
    for i := 1 to FIGURE_HEIGHT do
    begin
        for j := 1 to FIGURE_WIDTH do 
        begin
            fig.body[i][j] := FIGURES[fig.ftype, i, j]
            {fig.body[i][j] := FIGURES[7, i, j]}
        end
    end
end;

procedure DrawFigure(var fig: TFigure; var field: TField);
var
    i, j: byte;
begin
    for i := 1 to FIGURE_HEIGHT do
    begin
        for j := 1 to FIGURE_WIDTH do
        begin
            {if field[fig.y+i-2][fig.x+j] = 0 then}
                field[fig.y+i-2][fig.x+j] := fig.body[i][j]
            {
            else
                exit
            }
        end
    end
end;

var
    field: TField;
    curFigure, fig2: TFigure;
    i: integer;
    xMove, yMove: integer;
    keyCode: integer;
begin
    clrscr;
    randomize;

    curFigure.x := 1;
    curFigure.y := 1;
    curFigure.ftype := random(FIGURE_COUNT)+1;

    InitFigure(curFigure);

    yMove := 1;
    i := 1;
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
                    curFigure.y := curFigure.y+1;
                end;
                27: 
                begin
                    GotoXY(1, 1);
                    clrscr;
                    halt(1)
                end
            end
        end;

        DrawFigure(curFigure, field);
        DrawField(field);

        i := i + 1;
        delay(500)
    end

end.
