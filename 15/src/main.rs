use std::io::stdin;
use std::io::BufRead;
use std::collections::HashSet;
use std::collections::HashMap;

struct Mat {
    pub data : Vec<u32>,
    pub rows : u32,
    pub cols : u32,
}

#[derive(Hash, Eq, PartialEq, Debug, Clone, Copy)]
struct Coord {
    row : u32,
    col : u32,
}

fn neighbors(m : &Mat, x : &Coord) -> Vec<Coord> {
    let mut ret = Vec::new();

    if x.row > 0 {
	ret.push(Coord{ row: x.row - 1, col: x.col });
    }
    if x.col > 0 {
	ret.push(Coord{ row: x.row, col: x.col - 1 });
    }
    if x.row < (m.rows-1) {
	ret.push(Coord{ row: x.row + 1, col: x.col });
    }
    if x.col < (m.cols-1) {
	ret.push(Coord{ row: x.row, col: x.col + 1});
    }

    return ret;
}

fn read_input() -> Mat {
    let mut ret = Vec::new();
    let mut rows : u32 = 0;
    let mut cols : u32 = 0;
    for line in stdin().lock().lines() {
	match line {
	    Ok(s) => {
		rows = 1 + rows;
		cols = s.chars().count() as u32;
		for ch in s.chars() {
		    ret.push(ch.to_digit(10).unwrap() as u32);
		}
	    },
	    Err(_) => continue,
	}
    }
    return Mat {
	data: ret,
	rows: rows,
	cols: cols,
    }
}

fn val(m : &Mat, c: &Coord) -> u32 {
    let ind : usize = (c.row * m.cols + c.col) as usize;
    return m.data[ind];
}

fn astar(g : &Mat, start: &Coord, finish: &Coord) -> Vec<Coord> {
    let mut openset = HashSet::<Coord>::new();
    let mut camefrom = HashMap::<Coord, Coord>::new();
    let inf = std::f32::INFINITY;

    let mut gscore = HashMap::<Coord, f32>::new();
    let mut fscore = HashMap::<Coord, f32>::new();

    for r in 0..(g.rows) {
	for c in 0..(g.cols) {
	    gscore.insert(Coord{row: r, col: c}, inf);
	    fscore.insert(Coord{row: r, col: c}, inf);
	}
    }

    openset.insert(start.clone());
    gscore.insert(start.clone(), 0.0f32);
    fscore.insert(start.clone(), 0.0f32);

    while 0 < openset.len() {
	let mut current : Option<Coord> = None;
	let mut cs : f32 = inf;
	for x in &openset {
	    match fscore.get(&x) {
		Some(score) => {
		    if score < &cs {
			current = Some(x.clone());
			cs = *score;
		    }
		},
		None => continue,
	    }
	}
	let mut current = current.unwrap();
	openset.remove(&current);
	if current == *finish {
	    let mut ret = Vec::new();
	    while current != *start {
		ret.push(current.clone());
		current = *camefrom.get(&current).unwrap();
	    }
	    return ret;
	}

	for n in neighbors(&g, &current) {
	    let tscore = gscore.get(&current).unwrap() + val(&g, &n) as f32;
	    if tscore < *gscore.get(&n).unwrap() {
		camefrom.insert(n.clone(), current.clone());
		gscore.insert(n.clone(), tscore);
		fscore.insert(n.clone(), tscore + 1.0);
		if ! openset.contains(&n) {
		    openset.insert(n.clone());
		}
	    }
	}
    }
    return Vec::new();
}

fn main() {
    let m = read_input();

    let start = Coord { row: 0, col: 0 };
    let finish = Coord { row: m.rows - 1, col: m.cols - 1 };

    let path = astar(&m, &start, &finish);

    let mut score = 0;
    for p in path {
	score = score + val(&m, &p);
    }

    println!("{}", score);
}
