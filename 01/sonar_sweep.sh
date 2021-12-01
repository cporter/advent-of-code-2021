#!/bin/bash

PREVIOUS=''
TOTAL=0
while read number
do
    if test "x" != "x$PREVIOUS"
    then
        if test "$PREVIOUS" -lt "$number"
        then
            TOTAL=$(( 1 + $TOTAL ))
        fi
    fi
    PREVIOUS="$number"
done

echo "$TOTAL"
