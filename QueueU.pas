unit QueueU;

interface
type
    TQueuePointer = ^TQueue;
    TQueue = record
        data: integer;
        next: TQueuePointer;
    end;
    TQueueRecord = record
        first, last: TQueuePointer;
    end;

procedure QInit(var q: TQueueRecord);
procedure QPut(var q: TQueueRecord; n: integer);

implementation

procedure QInit(var q: TQueueRecord);
begin
    q.first := nil;
    q.last := nil
end;

procedure QPut(var q: TQueueRecord; n: integer);
begin
    if q.first = nil then
    begin
        new(q.first);
        q.last := q.first
    end
    else
    begin
        new(q.last^.next);
        q.last := q.last^.next
    end;
    q.last^.data := n;
    q.last^.next := nil
end;

end.
