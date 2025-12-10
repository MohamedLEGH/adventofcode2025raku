# my $file = open "example.txt", :r;
my $file = open "input.txt", :r;

grammar Parser {
	rule TOP { <digit>* }
	token digit { \d }
}

my $sum = 0;

for $file.IO.lines -> $line {
	my $match = Parser.parse($line);
	my @values = $match<digit>.map: *.Int;
	my $size_list = @values.elems;
	my $maxval = @values.pairs.max(*.value).value;
	my $maxval_idx = @values.pairs.max(*.value).key;
	my $maxval1;
	my $maxval2;
	if $maxval_idx < $size_list - 1 {
		my @other_values = @values[$maxval_idx^..*-1];
		$maxval1 = $maxval;
		$maxval2 = @other_values.pairs.max(*.value).value;
	}
	else {
		$maxval1 = @values[0..^*-1].pairs.max(*.value).value;
		$maxval2 = $maxval;
	}
	my $val = $maxval1 ~ $maxval2;
	$sum += $val;
}
say $sum;
