import sequtils, sugar

const
    N = 12

var 
    poscount = @[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

proc toBits(xs: seq[int]): seq[int] =
    var output = newSeq[int]()
    for x in xs:
        if x > 0: 
            output.add(1)
        else: 
            output.add(0)
    return output

proc notBits(xs: seq[int]): seq[int] = 
    var output = newSeq[int]()
    for x in xs:
        if x == 1:
            output.add(0)
        else:
            output.add(1)
    return output

proc toNumber(x: seq[int], invert : bool): int =
    var result = 0
    for i in toBits(x):
        result = 2 * result
        if invert:
            if i == 0:
                result += 1
        else:
            if i == 1:
                result += 1
    return result

var all = toSeq(lines stdin)


for line in all:
    for i in low(line)..high(line):
        if line[i] == '0':
            poscount[i] -= 1
        else:
            poscount[i] += 1

echo toNumber(poscount, true) * toNumber(poscount, false)