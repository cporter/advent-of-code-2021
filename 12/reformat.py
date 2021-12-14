import sys

MAX = 20

names = {
    'start': 0,
    'end': MAX,
}

def issmall(x):
    return x == x.lower()

for line in sys.stdin:
    a, b = line.strip().split('-')
    if a not in names:
        if issmall(a):
            names[a] = len(names)
        else:
            names[a] = MAX + len(names)
    if b not in names:
        if issmall(b):
            names[b] = len(names)
        else:
            names[b] = MAX + len(names)
    print(f'{names[a]}\t{names[b]}')
