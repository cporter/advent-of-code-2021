const
    N = 12

var 
    poscount = @[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

proc toNumber(x: seq[int], invert : bool): int =
    var result = 0
    for i in low(x)..high(x):
        result = 2 * result
        if invert:
            if x[i] <= 0:
                result += 1
        else:
            if x[i] > 0:
                result += 1
    return result

for line in lines stdin:
    for i in low(line)..high(line):
        if line[i] == '0':
            poscount[i] -= 1
        else:
            poscount[i] += 1

echo toNumber(poscount, true) * toNumber(poscount, false)