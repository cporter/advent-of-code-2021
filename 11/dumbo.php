#!/usr/bin/env php
<?php

define("COLS", (int)10);
// COLS = 10;

function toNumber($src)
{
    return (int)(ord($src) - ord('0'));
}

function dump($numbers) {
    for ($i = 0; $i < COLS; ++$i) {
        for ($j = 0; $j < COLS; ++$j) {
            $n = $numbers[$i * COLS + $j];
            if (0 == $n) {
                printf("*0*");
            } else {
                printf(" %d ", $numbers[$i * COLS + $j]);
            }
        }
        print("\n");
    }
    print("\n");
}

function countVals($numbers, $x) {
    $total = 0;
    foreach ($numbers as $n) {
        if ($x == $n) $total++;
    }
    return $total;

}

function countZeros($numbers) { return countVals($numbers, 0); }
function countTens($numbers) { return countVals($numbers, 10); }

function neighbors($n) {
    $ret = array();
    $row = (int)($n / COLS);
    $col = (int)($n % COLS);

    if ($row > 0) {
        if ($col > 0) {
            array_push($ret, $n - COLS - 1);
        }
        array_push($ret, $n - COLS);
        if ($col < 9) {
            array_push($ret, $n - COLS + 1);
        }
    }
    if ($col > 0) {
        array_push($ret, $n - 1);
    }
    array_push($ret, $n);
    if ($col < 9) {
        array_push($ret, $n + 1);
    }
    if ($row < 9) {
        if ($col > 0) {
            array_push($ret, $n + COLS - 1);
        }
        array_push($ret, $n + COLS);
        if ($col < 9) {
            array_push($ret, $n + COLS + 1);
        }
    }
    foreach ($ret as $r) {
        if ($r < 0 || $r > 99) {
            printf("Bad results for %d, %d, %d\n", $n, $row, $col);
            var_dump($ret);
            break;
        }
    }
    return $ret;
}

function flash(&$numbers) {
    for ($i = 0; $i < COLS*COLS; ++$i) $numbers[$i] += 1;
    while (true) {
        $to_flash = array();
        for ($i = 0; $i < COLS*COLS; ++$i) {
            if (10 == $numbers[$i]) {
                $to_flash[] = $i;
            }
        }
        if (0 == count($to_flash)) {
            break;
        }

        foreach($to_flash as $i) {
            $nei = neighbors($i);
            foreach($nei as $j) {
                if ($numbers[$j] < 10) {
                    $numbers[$j] += 1;
                }
            }
            $numbers[$i] += 1;
        }
    }
    for ($i = 0; $i < COLS*COLS; ++$i) {
        if (9 < $numbers[$i]) {
            $numbers[$i] = 0;
        }
    }
}

function main() {
    $numbers = array();
    while($line = fgets(STDIN)) {
        foreach(str_split(trim($line)) as $ch) {
            array_push($numbers, toNumber($ch));
        }
    }
    $flashes = 0;
    dump($numbers);
    $firstAll = -1;
    for ($i = 0; $i < 100 || -1 == $firstAll; $i++) {
        flash($numbers);
        $zeros = countZeros($numbers);
        if ($i < 100) {
            $flashes += $zeros;
        }
        printf("After step %d:\n", $i + 1);
        dump($numbers);
        if ((COLS * COLS) == $zeros) {
            if ($firstAll = -1) {
                $firstAll = $i;
            }
        }
    }
    printf("%d\n", $flashes);
    printf("First zero is at step %d\n", $firstAll + 1);
}

main();

?>