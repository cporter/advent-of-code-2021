#!/bin/bash

a=''
b=''
c=''

while read number
do
    c=$b
    b=$a
    a=$number

    if test "x" != "x$c"
    then
        echo $(($a + $b + $c))
    fi
done
