var readline = require('readline');
var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let count:number = 0;

const NUMBERS = [
    'XXXX',    // zero
    'ab',      // one
    'acdfg',   // two
    'abcdf',   // three
    'abef',    // four
    'bcdef',   // five
    'bcdefg',  // six
    'abd',     // seven
    'abcdefg', // eight
    'abcdef',  // nine
];

// const NUMBER_SETS = NUMBERS.map(function(x : string) { return new Set(x.split('')); });

let can_map = function(x: string): boolean {
    return x.length == 2 // one 
        || x.length == 3 // seven
        || x.length == 4 // four
        || x.length == 7 // eight
}

let mappableDigit = function(x: string) : number {
    if (x.length == 2) { return 1; }
    else if (x.length == 3) { return 7; }
    else if (x.length == 4) { return 4; }
    else if (x.length == 7) { return 8; }
    return -1;
}

let sortStr = function(x: string): string {
    return x.split('').sort().join('');
}

let iSize = function(a: string, b: string): number {
    if (! b) {
        return 0;
    }
    var count : number = 0;
    for(var i = 0; i < a.length; ++i) {
        if (b.includes(a[i])) {
            count += 1;
        }
    }
    return count;
}


let digit = function(x: string, one : string, four : string, seven : string): number {
    const len = x.length;
    var x1 = iSize(x, one);
    var x4 = iSize(x, four);
    var x7 = iSize(x, seven);
    if(5 == len) { // two or five
        if (1 == x1 && 2 == x4 && 2 == x7) {
            return 2;
        }
        if (2 == x1 && 3 == x4 && 3 == x7) {
            return 3;
        }
        if (1 == x1 && 3 == x4 && 2 == x7) {
            return 5;
        }
    } else if (6 == len) { // zero, six or nine
        if (2 == x1 && 3 == x4 && 3 == x7) {
            return 0;
        }
        if (1 == x1 && 3 == x4 && 2 == x7) {
            return 6;
        }
        if (2 == x1 && 4 == x4 && 3 == x7) {
            return 9;
        }
    } else {
        return mappableDigit(x);
    }
    console.log('UNREAACHABLY BAD ', x.length, one, four, seven, x1, x4, x7);
    return -1;
}


rl.on('line', function(line){
    const bars = line.split('|')
    if (0 < bars.length) {
        let mappable = new Set(line.trim().split(/[|\s]+/).filter(can_map).map(sortStr));
        const words = bars[1].trim().split(/\s+/);
        let value = 0;
        var one, four, seven : string;

        for (const word of Array.from(mappable)) {
            if (word.length == 2) {
                one = word;
            } else if (word.length == 3) {
                seven = word;
            } else if (word.length == 4) {
                four = word;
            }
        }

        for (const word of words) {
            value *= 10;
            value += digit(word, one, four, seven)
        }

        console.log(line.trim(), ': ', value);


        count += value;
    }
});



rl.on('close', function() {
    console.log(count);
})