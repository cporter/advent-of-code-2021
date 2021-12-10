# Advent of Code, 2021

[Advent of Code, 2021](https://adventofcode.com/).

## Rules (cp)

You can only use any programming language once.

## Solutions

For any of these I may have beome lazy in documenting how to run, assume it's something like

    $RELEVANT_INTERPRETER $source_file < input.txt

* [Sonar Sweep](01/sonar_sweep.sh) (Bash) and part two, the [Sliding Window](01/sliding_window.sh).
  Run `./sliding_window.sh < input.txt | ./sonar_sweep.sh` to get the final answer.
* [Dive](02/dive.awk) (Awk) `./dive.awk < input.txt` (part one is in an earlier commit.)
* [Gamma/Epsilon](03/gamma_epsilon.nim) and [O2/CO2](03/co2_scrubber.nim) (Nim).
  `nim -c -r $sourcefile.nim < input.txt` to run them. First time with Nim. Took a bit
  to get anything done, but the language compiles stupid quickly and it seems like it
  might really be worth exploring. I'm sure I've done everything incorrect in an ideomatic sense.
* [Bingo](04/bingo.rkt) and [Reverse Bingo](04/reverse-bingo.rkt) (Racket). I was tired after a day of yard work, so I went with something that's at least a little familiar. (Though it's been some time since I've done anything with scheme, thus the ugly.)
* [Hydrothermal](05/hydrothermal.pp) (Pascal), with the input cleaned up to a more pascal-friendly four numbers instead of be-comma'd pairs with an arrow in between.
* [Lanternfish](06/lanternfish.f90) (FORTRAN). `make ; ./lanternfish` to run. Need to have `gfortran` installed. You'll also need to convert the original input -- one line, comma delimited numbers -- to one number/line, and call it `input-fortran.txt`. I'm going to go ahead and say that preprocessing the input to get around 50's sensibilities about text processing isn't cheating.
* [Crabs part 1](07/part1.r) and [part 2](07/part2.r) (R). Busy day. No time to learn anything complicated, or use a non-crap solution.
* [Seven Segment](08/app.ts) (Typescript). What an ugly solution. Typescipt is still a whole bunch of Java\*\*\*\*. Do not like.
* [Basin](09/basin.jl) (Julia). Just part one works correctly for now. Might come back to this later. I remember a lot of excitement around Julia. Maybe it's more fun in a notebook for more domain-specific work. Anyway, the long litany of learning how to read from `STDIN` in new languages is starting to wear a bit. I think I only need five or six more before I'm back in to familiar territory.

## PL's I'm comfortable enough working with on day 1

* ~~Bash~~
* C
* C++ *(Should C and C++ count separately?)*
* D
* Haskell
* Java
* Java\*\*\*\*\*\*
* Perl
* Python
* Ruby

## PL's I've used before, but it's been somewhere between a while and forever

* ~~Awk~~
* BASIC
* C#
* Clojure
* Erlang
* Go
* Kotlin
* Lua
* Objective-C
* ~~Pascal~~
* Scala
* ~~Scheme~~ (By way of Racket)

## PL's entirely new to me

* ~~Nim~~
* ~~FORTRAN~~
* ~~R~~
* ~~Typescript~~
* ~~Julia~~
