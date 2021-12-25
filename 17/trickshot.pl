#!/usr/bin/perl -w

use strict;

my ($x0, $x1, $y0, $y1);

while(<>) {
    if(m/x=(-?\d+)\.\.(-?\d+), y=(-?\d+)\.\.(-?\d+)/) {
	($x0, $x1, $y0, $y1) = ($1, $2, $3, $4);
	last;
    }
}


sub inside {
    my ($x, $y) = @_;
    return $x >= $x0 && $x <= $x1 && $y >= $y0 && $y <= $y1;
}

sub past {
    my ($x, $y) = @_;
    return $x > $x1 || $y < $y0;
}

sub xpos {
    my ($xv) = @_;
    my $total = 0;
    while ($xv > 0) {
	$total += $xv;
	$xv -= 1;
    }
    return $total;
}

sub x_extents {
    my ($xmin, $xmax) = (-1, -1);
    for (my $i = 0;; $i++) {
	if (xpos($i) >= $x0 && ($xmin == -1)) {
	    $xmin = $i;
	}
	if (xpos($i) <= $x1 && ($xmin != -1)) {
	    $xmax = $i;
	}
	if (xpos($i) > $x1) {
	    last;
	}
    }
    return ($xmin, $xmax);
}

my ($xmin, $xmax) = x_extents();

my ($highest, $velocity) = (0, -1, -1);

for (my $_yv = -$y0; $_yv > 0; $_yv--) {

    for (my $_xv = $xmin; $_xv <= $xmax; $_xv++) {
	my ($xv, $yv) = ($_xv, $_yv);
	my ($x, $y) = (0, 0);
	my $max_y = $y;
	while (! past($x, $y)) {
	    if ($y > $max_y) {
		$max_y = $y;
	    }
	    if (inside($x, $y)) {
		if ($max_y > $highest) {
		    $highest = $max_y;
		    $velocity = [$_xv, $_yv];
		}
		last;
	    }
	    $x += $xv;
	    $y += $yv;
	    if ($xv > 0) { $xv -= 1; }
	    $yv -= 1;
	}
    }
}

print "highest: $highest\n";
