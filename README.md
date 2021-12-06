# Advent of Code, 2021

## Rules (cp)

You can only use any programming language once. 

## Solutions


* [Sonar Sweep](01/sonar_sweep.sh) (Bash) and part two, the [Sliding Window](01/sliding_window.sh).
  Run `./sliding_window.sh < input.txt | ./sonar_sweep.sh` to get the final answer.
* [Dive](02/dive.awk) (Awk) `./dive.awk < input.txt` (part one is in an earlier commit.)
* [Gamma/Epsilon](03/gamma_epsilon.nim) and [O2/CO2](03/co2_scrubber.nim) (Nim).
  `nim -c -r $sourcefile.nim < input.txt` to run them. First time with Nim. Took a bit
  to get anything done, but the language compiles stupid quickly and it seems like it 
  might really be worth exploring. I'm sure I've done everything incorrect in an ideomatic sense.
* [Bingo](04/bingo.rkt) and [Reverse Bingo](04/reverse-bingo.rkt) (Racket). I was tired after a day of yard work, so I went with something that's at least a little familiar. (Though it's been some time since I've done anything with scheme, thus the ugly.)  
* [Hydrothermal](05/hydrothermal.pp) (Pascal), with the input cleaned up to a more pascal-friendly four numbers instead of be-comma'd pairs with an arrow in between.
* [Lanternfish](06/lanternfish.f90) (FORTRAN). `make ; ./lanternfish` to run. Need to have `gfortran` installed.

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
* SQL

## PL's I've used before, but it's been somewhere between a while and forever

* ~~Awk~~
* BASIC
* C#
* Clojure
* Erlang
* Go
* Lua
* MIX *(If there's an implementatino of this....)*
* Modula 3
* Oberon
* Objective-C
* ~~Pascal~~
* Redcode *(If this is even possible...)*
* Scala
* ~~Scheme~~ (By way of Racket)

## PL's entirely new to me

* ~~Nim~~
* ~~FORTRAN~~