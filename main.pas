program Tetris;

uses crt;

const
    FIELD_WIDTH = 10;
    FIELD_HEIGHT = 20;
    FIELD_OFFSET_TOP = 2;
    FIELD_OFFSET_LEFT = 5;
    FIGURES: array [1..7, 1..4, 1..4] of byte = (
        { I }
        ((0, 0, 0, 0), (1, 1, 1, 1), (0, 0, 0, 0), (0, 0, 0, 0)),
        { O }
        ((0, 0, 0, 0), (0, 1, 1, 0), (0, 1, 1, 0), (0, 0, 0, 0)),
        { T }
        ((0, 0, 0, 0), (0, 1, 0, 0), (1, 1, 1, 0), (0, 0, 0, 0)),
        { S }
        ((0, 0, 0, 0), (0, 1, 1, 0), (1, 1, 0, 0), (0, 0, 0, 0)),
        { Z }
        ((0, 0, 0, 0), (1, 1, 0, 0), (0, 1, 1, 0), (0, 0, 0, 0)),
        { J }
        ((0, 0, 0, 0), (1, 0, 0, 0), (1, 1, 1, 0), (0, 0, 0, 0)),
        { L }
        ((0, 0, 0, 0), (0, 0, 1, 0), (1, 1, 1, 0), (0, 0, 0, 0))
    );

type
    TField = array [1..FIELD_HEIGHT, 1..FIELD_HEIGHT] of byte;
    TFigureBody = array [1..4, 1..4] of byte;
    TFigure = record
        size: TFigureBody;
        x, y: integer;
        ftype: integer;
        rotate: integer;
    end;

{ #global var }
var
    field: TField;
    score, level: integer;
    gameOver: boolean;
    ch: char;

procedure InitField;
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

procedure DrawFieldBorder;
var
    i, j: byte;
begin
    for i := 1 to FIELD_HEIGHT do
    begin
        for j := 1 to FIELD_WIDTH do
    end;

end;

procedure DrawField;
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

begin
    clrscr;

    InitField;
    DrawFieldBorder;
    DrawField;

end.
