program main; 

uses 
    crt,
    get_key,
    figure_api;

const
    speed = 500;
    areaHeight = 34;
    areaWidth = 36;

type
    sizeT = record
        width, height: integer;
    end;
    objCordXY = record
        x, y: integer;
    end;
    objCordT = record
        a, b, c, d: objCordXY;
    end;
    areaT = record
        borderChar: char;
        borderTop, borderBottom, borderLeft, borderRight: integer;
        size: sizeT;
        cord: objCordT;
        mArr: array [1..areaHeight, 1..areaWidth] of char;
    end;
    gameSettings_t = record
        speed: integer;
        lvl: integer;
        area: areaT;
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

procedure PlayAreaCreateMatrix(gs: gameSettings_t);
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
            gs.area.mArr[i][j] := '0';
        end
    end;

    for i := 1 to gs.area.size.height do
    begin
        for j := 1 to gs.area.size.width do
        begin
            GotoXY(startPosX+j-1, startPosY+i-1);
            write(gs.area.mArr[i][j]);
        end
    end
end;

procedure PlayAreaInit(var gs: gameSettings_t);
begin
    gs.area.size.width := areaWidth;
    gs.area.size.height := areaHeight;
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

procedure GameStatusDebug(fig: figureT;
    gs: gameSettings_t; gameLoopCounter: integer);
begin
    GotoXY(ScreenWidth-25, 1);
    write('Game Info: ');
    GotoXY(ScreenWidth-25, 2);
    write('figure type: ', fig.ftype, '    ');
    GotoXY(ScreenWidth-25, 3);
    write('fig pos curX: ', fig.position.curX, '    ');
    GotoXY(ScreenWidth-25, 4);
    write('fig pos curY: ', fig.position.curY, '    ');

    GotoXY(ScreenWidth-25, 8);
    write('GameLoopCounter: ', gameLoopCounter, '    ')
end;

procedure QueuePutElment(var fq: FigureQueue; var fig: figureT);
begin
    if fq.first = nil then
    begin
        new(fq.first);
        fq.last := fq.first;
    end
    else
    begin
        new(fq.last^.next);
        fq.last := fq.last^.next;
    end;
    fq.last^.data := fig;
    fq.last^.next := nil
end;

var
    saveTextAttr: integer;
    keyCode: integer;
    xMove, yMove: integer;
    gs: gameSettings_t;
    fig: figureT;
    fq: FigureQueue;
    pp1, pp2: ^qPtr;
    gameLoopCounter: integer;
    i, j, tmpInt: integer;
    tmpBoolX, tmpBoolY: boolean;
begin
    { base }
    clrscr;
    saveTextAttr := TextAttr;
    xMove := 0;
    yMove := 0;
    gameLoopCounter := 0;
    tmpBoolX := false;
    tmpBoolY := false;
    tmpInt := 0;

    { spawn random figure }
    randomize;
    { # ftype }
    {fig.ftype := RandomizeNumber(figuresCount);}
    fig.ftype := 5;

    { game area param }
    PlayAreaInit(gs);

    FigureInit(fig, fig.ftype, 0);
    FigureSetPosition(fig, gs.area.borderLeft+1, gs.area.borderTop+1);

    { init FigureQueue }
    fq.first := nil;
    fq.last := nil;

    pp1 := @(fq.first);
    pp2 := @(fq.first);

    { # write area }
    PlayAreaWrite(gs);
    PlayAreaCreateMatrix(gs);

    { main game cycle }
    while gameLoopCounter <> 3 do
    begin
        if KeyPressed then
        begin
            GetKey(keyCode);

            case keyCode of
                122: { z  change figure type - }
                begin
                    fig.ftype := fig.ftype-1
                end;
                120: { x  change figure type + }
                begin
                    fig.ftype := fig.ftype+1
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
                    if fig.position.curX > gs.area.cord.a.x+2 then
                    begin
                        xMove := xMove-1
                    end
                end;
                -77: { right }
                begin
                    if fig.position.curX < 
                        gs.area.cord.b.x - fig.size.width-1 then 
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

        { # check area for move figure }
        while pp1^ <> nil do
        begin
            {
            GotoXY(5, 1);
            write('figure id: ', pp1^^.data.id, '    ');
            }

            {GotoXY(5, 1);}
            {tmpInt := pp1^^.data.point.pArr[3].x;}

            {
            write('fig.x: ', fig.point.pArr[3].x, '    ');
            write('fig.y: ', fig.point.pArr[3].y);

            }
            {fig.point.pArr[1].y}

            {
            for i := 1 to gs.area.size.height do
            begin
                for j := 1 to gs.area.size.width do
                begin
                    gs.area.mArr[j][i] := '0';
                end
            end;
            }

            pp1 := @(pp1^^.next)
        end;
        pp1 := pp2;

        { # write figure }
        FigureInit(fig, fig.ftype, gameLoopCounter+1);
        FigureSetPosition(
            fig,
            gs.area.borderLeft + 1 + xMove,
            gs.area.borderTop + 1 + yMove
        );
        FigureWrite(fig);
        FigureWriteCollisionPoint(fig);
        {FigureCheckCollision();}
        
        {readln;}
            
        delay(200);

        if fig.position.curY < gs.area.size.height+1 then
        begin
            FigureHide(
                gs.area.borderLeft + xMove,
                gs.area.borderTop + 1 + yMove,          
                fig.size.width,
                fig.size.height 
            );
            yMove := yMove+1
        end
        else if fig.position.curY = gs.area.size.height+1 then
        begin
            yMove := 0;

            { spawn random figure }
            {fig.ftype := RandomizeNumber(figuresCount);}
            xMove := RandomizeNumber(
                gs.area.size.width - fig.size.width);
            
            { add fig to queue }
            QueuePutElment(fq, fig);

            { change matrix }

            gameLoopCounter := gameLoopCounter+1;
            readln
        end;

        { # game info }
        GameStatusDebug(fig, gs, gameLoopCounter);
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

    clrscr;
    GotoXY(1, 1);
    
    { check figures }
    while fq.first <> nil do
    begin
        writeln('figure.id: ', fq.first^.data.id);
        writeln;
        fq.first := fq.first^.next
    end;

    { exit program }
    TextAttr := saveTextAttr;
    clrscr
end.
