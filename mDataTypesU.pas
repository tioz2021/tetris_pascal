unit mDataTypesU;

interface
type
    { Queue }
    TQueuePointer = ^TQueue;
    TQueue = record
        data: integer;
        next: TQueuePointer;
    end;
    TQueueRecord = record
        first, last: TQueuePointer;
    end;

    { Stack }
    TStackPointer = ^TStack;
    TStack = record
        data: integer;
        next: TStackPointer;
    end;

{ Queue }
procedure QInit(var q: TQueueRecord);
procedure QPut(var q: TQueueRecord; n: integer);

{ Stack }
procedure SInit(var stack: TStackPointer);
procedure SPush(var stack: TStackPointer; n: integer);

implementation

{ Queue }
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

{ Stack }
procedure SInit(var stack: TStackPointer);
begin
    stack := nil
end;

procedure SPush(var stack: TStackPointer; n: integer);
var
    tmp: TStackPointer;
begin
    new(tmp);
    tmp^.data := n;
    tmp^.next := stack;
    stack := tmp
end;

end.
