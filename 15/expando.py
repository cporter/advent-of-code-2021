import itertools
import sys

def incroll(x):
    x = 1 + x
    if x > 9:
        x = 1
    return x

def expand(row):
    ret = [row]
    for i in range(4):
        ret.append([incroll(x) for x in ret[-1]])
    return list(itertools.chain(*ret))

M = [expand([int(x) for x in line.strip()]) for line in sys.stdin]
N = len(M)
for _ in range(4 * N):
    M.append([incroll(x) for x in M[-N]])

for row in M:
    print(''.join(f'{x}' for x in row))