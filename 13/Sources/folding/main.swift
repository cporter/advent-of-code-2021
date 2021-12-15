import Foundation

struct Coord { var x, y : Int }
struct Fold { var x, y : Int? }
struct Grid {
    var grid: [Bool]
    var rows, cols: Int
}

var coords : [Coord] = []
var folds : [Fold] = []

let coordMatch = try! NSRegularExpression(pattern: "(\\d+),(\\d+)")
let foldXMatch = try! NSRegularExpression(pattern: "fold along x=(\\d+)")
let foldYMatch = try! NSRegularExpression(pattern: "fold along y=(\\d+)")

while let s = readLine() {
    if let m = coordMatch.firstMatch(
         in: s, range: NSRange(location: 0, length: s.count)),
       let xr = Range(m.range(at: 1), in: s),
       let yr = Range(m.range(at: 2), in: s),
       let x = Int(s[xr]),
       let y = Int(s[yr]) {
        coords.append(Coord(x: x, y: y))
    }
    if let m = foldXMatch.firstMatch(
         in: s, range: NSRange(location: 0, length: s.count)),
       let r = Range(m.range(at: 1), in: s),
       let x = Int(s[r]) {
        folds.append(Fold(x: x))
    }
    if let m = foldYMatch.firstMatch(
          in: s, range: NSRange(location: 0, length: s.count)),
       let r = Range(m.range(at: 1), in: s),
       let y = Int(s[r]) {
        folds.append(Fold(y: y))
    }
}

func makeGrid(coords: [Coord]) -> Grid {
    let maxes = coords.reduce(Coord(x: 0, y : 0)) {
        (accum: Coord, nextVal: Coord) -> Coord in
        return Coord(x: max(accum.x, nextVal.x),
                     y: max(accum.y, nextVal.y))
    }

    var out = Grid(grid: [],
                   rows: 1 + maxes.y,
                   cols: 1 + maxes.x)

    let N = out.rows * out.cols
    for _ in 0...N { out.grid.append(false); }
    coords.forEach { coord in
        let ind = coord.x + coord.y * out.cols
        out.grid[ind] = true
    }

    return out
}

func copy(orig: Grid, rows: Int, cols: Int) -> Grid {
    var out = Grid(grid: [], rows: rows, cols: cols)
    for r in 0...(rows-1) {
        for c in 0...(cols-1) {
            out.grid.append(orig.grid[c + r * orig.cols])
        }
    }
    return out
}

func fold(orig: Grid, fold: Fold) -> Grid {
    if let x = fold.x {
        let newcols = x
        var out = copy(orig: orig, rows: orig.rows, cols : newcols)

        for r in 0...(orig.rows-1) {
            for dc in 1...x {
                let ca = x - dc
                let cb = x + dc
                if cb < orig.cols {
                    out.grid[ca + r * out.cols] =
                      out.grid[ca + r * out.cols] ||
                      orig.grid[cb + r * orig.cols]
                }
            }
        }

        return out
    }
    if let y = fold.y {
        let newcols = orig.cols
        var out = copy(orig: orig, rows: y, cols: orig.cols)

        for dr in 1...y {
            let ra = y - dr
            let rb = y + dr
            if rb < orig.rows {
                for c in 0...(newcols-1) {
                    out.grid[c + ra * out.cols] = out.grid[c + ra * out.cols]
                      || orig.grid[c + rb * orig.cols]
                }
            }
        }
        return out
    }
    return orig
}

func countActive(g: Grid) -> Int {
    return g.grid.reduce(0) {
        (accum: Int, nextval: Bool) in
        if nextval {
            return 1 + accum
        } else {
            return accum
        }
    }
}

func gridSymbol(b: Bool) -> String {
    if (b) {
        return "#"
    } else {
        return "."
    }
}

func dumpGrid(g: Grid) -> () {
    print("G(\(g.cols) x \(g.rows) = \(countActive(g: g)))")
    for r in 0...(g.rows-1) {
        print("\(r)\t", terminator: "")
        for c in 0...(g.cols-1) {
            let ind = c + g.cols * r
            print(gridSymbol(b: g.grid[ind]), terminator: "")
        }
        print()
    }
}


var grid = makeGrid(coords: coords)

if folds.count > 0 {
    let newg = fold(orig: grid, fold: folds[0])
    print(countActive(g: newg))
}
