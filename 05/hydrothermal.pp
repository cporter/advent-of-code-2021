
program Hello;

type
    Storage = array [0..999, 0..999] of Integer;
var
    i, j, x1, y1, x2, y2, total, tmp : Integer;
    count : Storage;
begin
    total := 0;
    for i := 0 to 999 
    do
    begin
        for j := 0 to 999
        do
        begin
            count[i][j] := 0;
        end;
    end;
    while not Eof() do
    begin
        ReadLn(x1, y1, x2, y2);
        if x1 > x2 then
        begin
            tmp := x1;
            x1 := x2;
            x2 := tmp;
        end;
        if y1 > y2 then
        begin
            tmp := y1;
            y1 := y2;
            y2 := tmp;
        end;
        if x1 = x2 then
            for i := y1 to y2 do count[x1][i] := count[x1][i] + 1
        else 
            if y1 = y2 then
                for i := x1 to x2 do count[i][y1] := count[i][y1] + 1;
    end;

    for i := 0 to 999
    do
    begin
        for j := 0 to 999
        do
        begin
            if count[i][j] > 1
            then
                total := total + 1
        end;
    end;

    Writeln(total);
end.