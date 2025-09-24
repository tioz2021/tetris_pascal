program main;
uses crt, get_key;

const
    figureBg = '#';

procedure PrintFigure(figureId: integer; curX, curY: integer);
var
    i: integer;
begin
    for i := 1 to 9 do
    begin
        write(figureBg);
        {delay(100);}
        curX := curX + 1;
        GotoXY(curX, curY);
    end
end;

procedure MainProcedure();
var
    x, y: integer;
    curX, curY: integer;
begin
    x := ScreenWidth div 2;
    y := ScreenHeight div 2;
    curX := x;
    curY := y;
    GotoXY(x, y);

    PrintFigure(1, curX, curY);
end;

var
    saveTextAttr: integer;
    x, y: integer;
    keyCode: integer;
begin
    { init param }
    clrscr;
    saveTextAttr := TextAttr;

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
