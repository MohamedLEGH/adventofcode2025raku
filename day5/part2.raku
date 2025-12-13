use Math::Interval;

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
	return "No overlap";
	# > return $inter2
	# if $inter2 in $inter1
	# > return $inter1
	# if $inter1.max >= $inter2.min
	# AND $inter1.min <= $inter2.min
	# some overlap
	# return ($inter1.min, $inter2.max)
	# if $inter1.max >= $inter2.max
	# AND $inter1.min >= $inter2.min
	# some overlap
	# return ($inter2.min, $inter1.max)
	# Else no overlap
	# return "No overlap"
}

my $content = "example.txt".IO.slurp; 
# my $content = "input.txt".IO.slurp; 

my @split-text = $content.split("\n\n");
my @id-ranges = @split-text[0].split("\n");
# my @ingredients = @split-text[1].split("\n");

my @intervals = [];

for @id-ranges -> $id-range {
	# say "hello";
	# say $interval;
	my $match = Parser.parse($id-range);
	my $interval = $match<min-val>.Int..$match<max-val>.Int;
	@intervals.push($interval);
	# say $interval;
}

my @final-list-intervals = [];

for @intervals -> $interval {
	# my $new-interval;
	my $fused = False;
	if @final-list-intervals eq [] {
		@final-list-intervals.push($interval)
	} else {
		for 0..@final-list-intervals.elems -> $i {
			say @final-list-intervals[$i];
			my $matching-interval = fuse-interval(@final-list-intervals[$i], $interval);
			if $matching-interval !eq "No overlap" {
				@final-list-intervals[$i] = $matching-interval;
				$fused = True;
				last;
			} else {
				say "hello no match";
			}
		}
		if !$fused {
			@final-list-intervals.push($interval);
		}
	}
	# say @final-list-intervals
}

# say @final-list-intervals[0].elems;

# my $combined-interval = @intervals.reduce: &infix:<∪>; # Union
# say $combined-interval.elems;

# my $sum = 0;

# say $sum;
