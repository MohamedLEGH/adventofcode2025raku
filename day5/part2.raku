# my $content = "example.txt".IO.slurp; 
my $content = "input.txt".IO.slurp; 

grammar Parser {
    rule TOP { <min-val>'-'<max-val> }
    token min-val { \d+ }
    token max-val { \d+ }
}

# if list-interval is empty
# add interval
# else
# compare with all interval
# if can fuse
# fuse
# else add new interval in list

sub fuse-interval($inter1, $inter2) {
	# if $inter1 in $inter2
	if $inter1 ~~ $inter2 {
		return $inter2;
	}
	if $inter2 ~~ $inter1 {
		return $inter1
	}
	if $inter1.max >= $inter2.min and $inter1.min <= $inter2.min and $inter1.max <= $inter2.max {
		return $inter1.min..$inter2.max;
	}
	if $inter2.max >= $inter1.min and $inter2.min <= $inter1.min and $inter2.max <= $inter1.max {
		return $inter2.min..$inter1.max;
	}
	return False;
}

my @split-text = $content.split("\n\n");
my @id-ranges = @split-text[0].split("\n");

my @intervals = [];

for @id-ranges -> $id-range {
	my $match = Parser.parse($id-range);
	my $interval = $match<min-val>.Int..$match<max-val>.Int;
	@intervals.push($interval);
}

# remove if 2 list are overlapping
# add new list if overlap
# do it again until the list of interval don't change

sub fusing-intervals(@intervals) {
	my @new-list-intervals = @intervals.clone(); # memory copy

	LOOP-LABEL:
	for 0..@intervals.elems -> $i {
		for $i..@intervals.elems -> $j {
			if $i != $j {
				my $new-interval = fuse-interval(@intervals[$i], @intervals[$j]);
				if $new-interval {
					@new-list-intervals.splice($i, 1);
					@new-list-intervals.splice($j - 1, 1);
					@new-list-intervals.push($new-interval);
					last LOOP-LABEL;
				}
			}
		}
	}
	return @new-list-intervals;
}

my @new-list-intervals = fusing-intervals(@intervals);
while @new-list-intervals.elems < @intervals.elems {
	@intervals = @new-list-intervals;
	@new-list-intervals = fusing-intervals(@intervals);
}

my $sum = 0;
for @new-list-intervals -> $interval {
	$sum += $interval.elems;
}

say $sum;
