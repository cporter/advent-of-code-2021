using Printf

a = readlines()

ROWS = lastindex(a)
COLS = lastindex(a[begin])

digits = []
for row in 1:ROWS
    for col in 1:COLS
        append!(digits, parse(Int, a[row][col]))
    end
end

total = 0

for row in 0:(ROWS-1)
    for col in 1:COLS
        digit = digits[row * COLS + col]
        low = true
        if col > 1
            if digits[row * COLS + col - 1] <= digit
                low = false
            end
        end
        if col < COLS
            if digits[row * COLS + col + 1] <= digit
                low = false
            end
        end
        if row > 0
            if digits[(row-1) * COLS + col] <= digit
                low = false
            end
        end
        if row < (ROWS-1)
            if digits[(row+1) * COLS + col] <= digit
                low = false
            end
        end
        if low
            global total += 1 + digit
        end
    end
end

println(total)
