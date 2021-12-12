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
    # @printf("contains %d in %s\n", what, lst)
    what in Set(lst)
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
        if ! (x in previous)
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

total = 0
for x in basin
    global total += digits[x] + 1
end
println(total)

basin_sizes = []
additional = []
basin = Set(basin)
seen = Set()

lengths = []

for start in basin
    b = Set([start])
    q = []
    for c in candidates(start, [])
        append!(q, c)
    end
    while 0 < length(q)
        c = popfirst!(q)
        if digits[c] < 9
            ns = candidates(c, b)
            good = true
            for n in ns
                if digits[n] < digits[c]
                    good = false
                end
            end
            if good
                push!(b, c)
                for n in ns
                    append!(q, n)
                end
            end
        end
    end
    append!(lengths, length(b))
end

sorted_lengths = sort(lengths)
# println(sorted_lengths)

println(sorted_lengths[end] * sorted_lengths[end-1] * sorted_lengths[end-2])


