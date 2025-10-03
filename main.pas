program Tetris;

uses crt;

const
    FIELD_WIDTH = 10;
    FIELD_HEIGHT = 20;
    FIELD_OFFSET_TOP = 2;
    FIELD_OFFSET_LEFT = 5;
    FIGURE_COUNT = 7;
    FIGURE_WIDTH = 4;
    FIGURE_HEIGHT = 4;

    FIGURES: array [
        1..FIGURE_COUNT, 1..FIGURE_HEIGHT, 1..FIGURE_WIDTH
    ] of byte = (
        { I }
        ((0,0,0,0), (1,1,1,1), (0,0,0,0), (0,0,0,0)),
        { O }
        ((0,0,0,0), (0,1,1,0), (0,1,1,0), (0,0,0,0)),
        { T }
        ((0,0,0,0), (0,1,0,0), (1,1,1,0), (0,0,0,0)),
        { S }
        ((0,0,0,0), (0,1,1,0), (1,1,0,0), (0,0,0,0)),
        { Z }
        ((0,0,0,0), (1,1,0,0), (0,1,1,0), (0,0,0,0)),
        { J }
        ((0,0,0,0), (1,0,0,0), (1,1,1,0), (0,0,0,0)),
        { L }
        ((0,0,0,0), (0,0,1,0), (1,1,1,0), (0,0,0,0))
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
    for i := 1 to FIGURE_WIDTH do
    begin
        for j := 1 to FIGURE_HEIGHT do 
        begin
            fig.body[i][j] := FIGURES[random(FIGURE_COUNT)+1, i, j]
        end
    end
end;

procedure DrawFigure(var fig: TFigure; var field: TField);
var
    i, j: byte;
begin
    for i := 1 to FIGURE_WIDTH do
    begin
        for j := 1 to FIGURE_HEIGHT do
        begin
            if field[fig.x+i][fig.y+j] = 0 then
                field[fig.x+i][fig.y+j] := fig.body[i][j]
            else
                exit
        end
    end
end;

var
    field: TField;
    curFigure, fig2: TFigure;
    i: integer;
begin
    clrscr;
    randomize;

    InitFigure(curFigure);

    i := 1;
    while i < 10 do
    begin
        clrscr;
        GotoXY(1, 1);
        curFigure.x := random(FIELD_WIDTH)+1;
        curFigure.y := random(FIELD_HEIGHT)+1;

        DrawFigure(curFigure, field);
        DrawField(field);

        i := i + 1;
        delay(250)
    end

end.
