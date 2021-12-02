#!/usr/bin/awk -f

BEGIN {
    aim = 0
    vertical = 0
    horizontal = 0
}

{
    if ($1 == "forward") {
        horizontal += $2;
        vertical += (aim * $2)
    } else if ($1 == "down") {
        aim += $2
    } else if ($1 == "up") {
        aim -= $2
    }
}

END {
    print vertical * horizontal
}
