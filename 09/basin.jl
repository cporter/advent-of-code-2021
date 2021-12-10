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

basin = []

function contains(what, lst)
    ret = false
    for x in lst
        if x == what
            ret = true
        end
    end
    ret
end

function candidates(i, previous)
    out = []

    col = (i - 1) % COLS
    row = div((i - 1), COLS)

    if col > 0
        append!(out, i - 1)
    end
    if col < (COLS-1)
        append!(out, i + 1)
    end
    if row > 0
        append!(out, i - COLS)
    end
    if row < (ROWS-1)
        append!(out, i + COLS)
    end
    ret = []
    for x in out
        if ! contains(x, previous)
            append!(ret, x)
        end
    end
    ret
end

for i = 1:lastindex(digits)
    digit = digits[i]
    cands = candidates(i, [])
    low = true
    for c in cands
        if digit >= digits[c]
            low = false
        end
    end
    if low
        append!(basin, i)
    end
end

begin
    total = 0
    for i in basin
        global total += digits[i] + 1
    end
    println(total)
end

