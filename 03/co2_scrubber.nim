import sequtils

proc lineToBits(line: string): seq[int] =
    var output = newSeq[int]()
    for ch in line.items:
        if ch == '1':
            output.add(1)
        elif ch == '0':
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

proc toNumber(bits: seq[int]): int =
    var ret = 0
    for i in bits:
        ret = 2 * ret
        if i == 1:
            ret += 1
    return ret

var allbits = map(toSeq(lines stdin), lineToBits)

var
    N = high(allbits[0])

proc preponderanceAt(idx: int, bts: seq[seq[int]]): int =
    var count = 0
    for bt in bts:
        if bt[idx] == 1:
            count += 1
        else:
            count -= 1
    if count > 0:
        return 1
    elif count == 0:
        echo ("zero found")
        return -1
    else:
        return 0

proc o2(all: seq[seq[int]], N: int): int =
    var internal = all
    echo("o2 start ", high(internal))    
    for idx in 0..N:
        var p = preponderanceAt(idx, internal)
        if -1 == p:
            internal = filter(internal, proc(bt: seq[int]): bool = bt[idx] == 1)
        else:
            internal = filter(internal, proc(bt: seq[int]): bool = bt[idx] == p)
        echo(idx, " ", high(internal))
        if 0 == high(internal):
            break
    return toNumber(internal[0])

proc co2(all: seq[seq[int]], N: int): int =
    var internal = all
    echo("co2 start ", high(internal))    
    for idx in 0..N:
        var p = preponderanceAt(idx, internal)
        if -1 == p:
            internal = filter(internal, proc(bt: seq[int]): bool = bt[idx] == 0)
        else:
            internal = filter(internal, proc(bt: seq[int]): bool = bt[idx] != p)
        echo(idx, " ", high(internal))
        if 0 == high(internal):
            break
    return toNumber(internal[0])

echo(o2(allbits, N) * co2(allbits, N))