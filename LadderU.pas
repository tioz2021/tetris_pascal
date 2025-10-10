unit LadderU;

interface

procedure ScoresLadder(var score: integer);

implementation
uses crt, QueueU;

const
    FILENAME_FOR_SCORE = 'data_score_ladder';

type
    TFile = file of integer;

procedure OpenFile(var f: TFile);
begin
    assign(f, FILENAME_FOR_SCORE);
    reset(f);
    if IOResult <> 0 then
    begin
        rewrite(f);
    end;
end;

procedure ReadFileAndUploadDataToQueue(
    score: integer;
    var q: TQueueRecord;
    var f: TFile
);
var
    n: integer;
begin
    if score > 0 then
    begin
        QInit(q);
        while not eof(f) do
        begin
            read(f, n);
            QPut(q, n);
        end;
        close(f);
        QPut(q, score)
    end
end;

procedure CreateNewQueueForLadder(var q, q2: TQueueRecord);
var
    tmpNum: integer;
    pp, pp2: ^TQueuePointer;
    q2HaveThisNum: boolean;
begin
    { craete new queue }
    tmpNum := 0;
    QInit(q2);
    QPut(q2, tmpNum);
    pp := @(q.first);
    pp2 := @(q2.first);
    while pp^ <> nil do
    begin
        tmpNum := pp^^.data;

        { check/add unic number } 
        while pp2^ <> nil do
        begin
            if tmpNum = pp2^^.data then
            begin
                q2HaveThisNum := true;
                break
            end
            else
            begin
                q2HaveThisNum  := false;
                pp2 := @(pp2^^.next)
            end
        end;
        if not q2HaveThisNum then
            QPut(q2, tmpNum);
        pp2 := @(q2.first);

        pp := @(pp^^.next)
    end
end;

procedure SortNumbers(var q: TQueueRecord);
var
    i, tmpNum: integer;
    pp: ^TQueuePointer;
begin
    i := 0;
    pp := @(q.first);
    while pp^ <> nil do
    begin
        tmpNum := pp^^.data;
        if (pp^^.next <> nil) and (pp^^.data > pp^^.next^.data) then
        begin
            tmpNum := pp^^.next^.data;
            pp^^.next^.data := pp^^.data;
            pp^^.data := tmpNum
        end;

        GotoXY(10, 30 + i);
        writeln(tmpNum);
        readln;

        i := i + 1;
        pp := @(pp^^.next)
    end;
end;

procedure WriteLadderForDisplay(var q: TQueueRecord);
var
    i: integer;
    pp: ^TQueuePointer;
begin
    i := 6;
    TextColor(Blue);
    GotoXY(1, 5);
    write('TOP 10 score: ');
    pp := @(q.first);
    while pp^ <> nil do
    begin
        if pp^^.data < 1 then
            pp := @(pp^^.next);

        GotoXY(1, i);
        TextColor(Red);
        write(i-5, ': ');
        TextColor(Yellow);
        write(pp^^.data);
        i := i + 1;
        pp := @(pp^^.next)
    end
end;

procedure WriteDataOnFile(var q: TQueueRecord; var f: TFile);
var
    pp: ^TQueuePointer;
begin
    rewrite(f);
    pp := @(q.first);
    while pp^ <> nil do
    begin
        if pp^^.data < 1 then
            pp := @(pp^^.next);

        write(f, pp^^.data);
        pp := @(pp^^.next)
    end;
    close(f);
end;

procedure ScoresLadder(var score: integer);
var
    q, q2: TQueueRecord;
    dataFile: TFile;
begin
    {$I-}

    OpenFile(dataFile);
    ReadFileAndUploadDataToQueue(score, q, dataFile);
    CreateNewQueueForLadder(q, q2);
    SortNumbers(q2);
    WriteLadderForDisplay(q2);
    WriteDataOnFile(q2, dataFile)
end;

end.
