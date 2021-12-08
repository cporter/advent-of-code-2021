var readline = require('readline');
var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let count:number = 0;

rl.on('line', function(line){
    const bars = line.split('|')
    if (0 < bars.length) {
        const words = bars[1].split(/\s+/);
        for (const word of words) {
            if(word.length == 2
                || word.length == 3
                || word.length == 4
                || word.length == 7) {
                    count += 1;
                }
        }
    }
});

rl.on('close', function() {
    console.log(count);
})