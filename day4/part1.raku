# my $file = open "example.txt", :r;
my $file = open "input.txt", :r;

my @array-rolls = [];
my $nb-line = 0;

for $file.IO.lines -> $line {
	my @chars-line = $line.comb;
	my $nb-columns = 0;
	@array-rolls.push(@chars-line);

	# for $chars-line -> $char-val {
	# 	@sub-array.push($char-val);
	# 	# $nb-columns ++;
	# }
	# @array-rolls.push(@sub-array);
	# say $chars-line;
	# my $match = Parser.parse($line);
	# say $line;
	# say $match;
	# $nb-line++;
}

my $rolls-nblines = @array-rolls.elems;
my $rolls-nbcolumns = @array-rolls[0].elems;

# say $rolls-nblines;
# say $rolls-nbcolumns;

my $sum = 0;
for 0..^$rolls-nblines -> $i {
	for 0..^$rolls-nbcolumns -> $j {
		# say @array-rolls[$i][$j];
		my $elem = @array-rolls[$i][$j];
		# my $nb-neighbors = 0;
		if $elem eq "@" {
			my @neighbors = [];
			# my @neighbors = [
			# 	@array-rolls[$i - 1][$j],
			# 	@array-rolls[$i + 1][$j],
			# 	@array-rolls[$i][$j - 1],
			# 	@array-rolls[$i][$j + 1],
			# 	@array-rolls[$i - 1][$j - 1],
			# 	@array-rolls[$i - 1][$j + 1],
			# 	@array-rolls[$i + 1][$j - 1],
			# 	@array-rolls[$i + 1][$j + 1],
			# ];
			# say $elem;
			if $i > 0 {
				@neighbors.push(@array-rolls[$i - 1][$j]);
			}
			if $j > 0 {
				@neighbors.push(@array-rolls[$i][$j - 1]);
			}
			if $i < $rolls-nblines {
				@neighbors.push(@array-rolls[$i + 1][$j]);
			}
			if $j < $rolls-nbcolumns {
				@neighbors.push(@array-rolls[$i][$j + 1]);
			}
			if $i > 0 and $j > 0 {
				@neighbors.push(@array-rolls[$i - 1][$j - 1]);
			}
			if $i > 0 and $j < $rolls-nbcolumns {
				@neighbors.push(@array-rolls[$i - 1][$j + 1]);
			}
			if $i < $rolls-nblines and $j > 0 {
				@neighbors.push(@array-rolls[$i + 1][$j - 1]);
			}
			if $i < $rolls-nblines and $j < $rolls-nbcolumns {
				@neighbors.push(@array-rolls[$i + 1][$j + 1]);
			}
			# if x > 0 => check x-1
			# if x < max => check x+1
			# if y > 0 => check y-1
			# if y < max => check y+1
			# if x > 0 and y > 0 => check x-1, y-1
			# if x > 0 and y < max => check x-1, y+1
			# if x < max and y > 0 => check x+1, y-1
			# if x < max and y < max => check x+1, y+1
			if @neighbors.grep('@').elems < 4 {
				$sum++;
			}
		}
	}
}
say $sum;
