#!/usr/bin/awk -f

BEGIN {
    vertical = 0
    horizontal = 0
}

{
    if ($1 == "forward") {
        horizontal += $2;
    } else if ($1 == "down") {
        vertical += $2;
    } else if ($1 == "up") {
        vertical -= $2;
    }
}

END {
    print vertical * horizontal
}
