# my $file = open "example.txt", :r;
my $file = open "input.txt", :r;

my @array-rolls = [];
my $nb-line = 0;

for $file.IO.lines -> $line {
	my @chars-line = $line.comb;
	my $nb-columns = 0;
	@array-rolls.push(@chars-line);
}

my $rolls-nblines = @array-rolls.elems;
my $rolls-nbcolumns = @array-rolls[0].elems;

my $sum = 0;
my $still-rolls = True;
while $still-rolls {
	$still-rolls = False;
	for 0..^$rolls-nblines -> $i {
		for 0..^$rolls-nbcolumns -> $j {
			my $elem = @array-rolls[$i][$j];
			if $elem eq "@" {
				my @neighbors = [];
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
				if @neighbors.grep('@').elems < 4 {
					$sum++;
					$still-rolls = True;
					@array-rolls[$i][$j] = '.';
				}
			}
		}
	}
}
say $sum;
