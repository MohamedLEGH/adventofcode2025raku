#####
# NOT WORKING FOR INPUT
# RANGE ARE TOO LARGE
#####

use Math::Interval;

grammar Parser {
    rule TOP { <min-val>'-'<max-val> }
    token min-val { \d+ }
    token max-val { \d+ }
}

# my $content = "example.txt".IO.slurp; 
my $content = "input.txt".IO.slurp; 

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
	# say $match;
}

my $combined-interval = @intervals.reduce: &infix:<∪>; # Union
say $combined-interval.elems;

# my $sum = 0;

# say $sum;
