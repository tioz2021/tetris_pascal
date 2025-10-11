unit LadderU;

interface

procedure ScoresLadder(var score: integer; posX, posY: integer);

implementation
uses crt, mDataTypesU;

const
    FILENAME_FOR_SCORE = 'data_score_ladder';
    MAX_RESULTS_FOR_LADDER = 10;

type
    TFile = file of integer;

procedure OpenFile(var f: TFile);
begin
    {$I-}
    assign(f, FILENAME_FOR_SCORE);
    reset(f);
    if IOResult <> 0 then
        rewrite(f);
end;

procedure ReadFileAndUploadDataToQueue(
    score: integer;
    var q: TQueueRecord;
    var f: TFile
);
var
    n: integer;
begin
    QInit(q);
    while not eof(f) do
    begin
        read(f, n);
        QPut(q, n)
    end;
    close(f);
    QPut(q, score)
end;

procedure
CreateNewQueueForLadder(var q: TQueueRecord; var stack: TStackPointer);
var
    tmpNum: integer;
    pp: ^TQueuePointer;
    pp2: ^TStackPointer;
    stackHaveThisNum: boolean;
begin
    { craete new queue }
    tmpNum := 0;
    SInit(stack);
    SPush(stack, tmpNum);
    pp := @(q.first);
    pp2 := @(stack);
    while pp^ <> nil do
    begin
        tmpNum := pp^^.data;

        { check/add unic number } 
        while pp2^ <> nil do
        begin
            if tmpNum = pp2^^.data then
            begin
                stackHaveThisNum := true;
                break
            end
            else
            begin
                stackHaveThisNum  := false;
                pp2 := @(pp2^^.next)
            end
        end;
        if not stackHaveThisNum then
            SPush(stack, tmpNum);
        pp2 := @(stack);

        pp := @(pp^^.next)
    end
end;

procedure SortNumbers(var stack: TStackPointer);
var
    i, tmpNum: integer;
    pp: ^TStackPointer;
    swapped: boolean;
begin
    i := 0;
    repeat
        swapped := false;
        pp := @(stack);

        while (pp^ <> nil) and (pp^^.next <> nil) do
        begin
            if pp^^.data < pp^^.next^.data then
            begin
                tmpNum := pp^^.data;
                pp^^.data := pp^^.next^.data;
                pp^^.next^.data := tmpNum;
                swapped := true
            end;

            i := i + 1;
            pp := @(pp^^.next)
        end

    until not swapped
end;

procedure
WriteLadderForDisplay(var stack: TStackPointer; posX, posY: integer);
var
    i, topCounter: integer;
    pp: ^TStackPointer;
begin
    topCounter := 1;
    i := posY+1;
    TextColor(Blue);
    GotoXY(1, posY);
    write('TOP 10 score: ');
    pp := @(stack);
    while pp^ <> nil do
    begin
        if (pp^^.data > 1) and (topCounter <= MAX_RESULTS_FOR_LADDER) then
        begin
            GotoXY(PosX, i);
            TextColor(Red);
            write(i-PosY, ': ');
            TextColor(Yellow);
            write(pp^^.data);
            i := i + 1;
            topCounter := topCounter + 1
        end;
        pp := @(pp^^.next)
    end
end;

procedure WriteDataOnFile(var stack: TStackPointer; var f: TFile);
var
    pp: ^TStackPointer;
    topCounter: integer;
begin
    rewrite(f);
    pp := @(stack);
    topCounter := 1;
    while (pp^^.next <> nil) and (topCounter <= MAX_RESULTS_FOR_LADDER) do
    begin
        if pp^^.data < 1 then
            pp := @(pp^^.next);

        write(f, pp^^.data);
        topCounter := topCounter + 1;
        pp := @(pp^^.next)
    end;
    close(f)
end;

procedure ScoresLadder(var score: integer; posX, posY: integer);
var
    queue: TQueueRecord;
    stack: TStackPointer;
    dataFile: TFile;
begin
    OpenFile(dataFile);
    ReadFileAndUploadDataToQueue(score, queue, dataFile);
    CreateNewQueueForLadder(queue, stack);
    SortNumbers(stack);
    WriteLadderForDisplay(stack, posX, posY);
    WriteDataOnFile(stack, dataFile)
end;

end.
