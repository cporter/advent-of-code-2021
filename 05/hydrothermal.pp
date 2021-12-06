
program Hello;

type
    Storage = array [0..999, 0..999] of Integer;
var
    i, j, x1, y1, x2, y2, total, dx, dy : Integer;
    count : Storage;
(*function definition *)
function max(num1, num2: Integer): Integer;
var
   (* local variable declaration *)
   result: Integer;

begin
   if (num1 > num2) then
      result := num1
   
   else
      result := num2;
   max := result;
end;
(*function definition *)
function min(num1, num2: integer): integer;
var
   (* local variable declaration *)
   result: integer;

begin
   if (num1 < num2) then
      result := num1
   
   else
      result := num2;
   min := result;
end;
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
        if x1 = x2 then
            for i := min(y1, y2) to max(y1, y2) do count[x1][i] := count[x1][i] + 1
        else if y1 = y2 then
            for i := min(x1, x2) to max(x1, x2) do count[i][y1] := count[i][y1] + 1
        else 
            begin
                if x1 > x2 then dx := -1 else dx := 1;
                if y1 > y2 then dy := -1 else dy := 1;
                while x1 <> x2
                do
                begin
                    count[x1][y1] += count[x1][y1] + 1;
                    x1 := x1 + dx;
                    y1 := y1 + dy;
                end;
                count[x1][y1] += count[x1][y1] + 1;
            end;
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