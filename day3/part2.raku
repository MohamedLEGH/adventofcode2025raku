# my $file = open "example.txt", :r;
my $file = open "input.txt", :r;

grammar Parser {
	rule TOP { <digit>* }
	token digit { \d }
}

sub max-digits(@str-list, $nb-elements) {
	return max-digits-acc([], @str-list, $nb-elements); 
}

sub max-digits-acc(@acc, @str-list, $nb-elements) {
	if $nb-elements == 0 {
		return [];
	}
	my $maxval = @str-list.pairs.max(*.value);
	my $maxval_idx = $maxval.key;
	my $maxval_val = $maxval.value;
	if $nb-elements == 1 {
		return [$maxval_val];
	}
	my @right-list;
	if @str-list[$maxval_idx..*-1].elems <= $nb-elements - 1 {
		@right-list = @str-list[$maxval_idx^..*-1];
		my $remaining = $nb-elements - 1 - @right-list.elems; 
		my @left-list = max-digits-acc(@acc, @str-list[0..^$maxval_idx], $remaining);
		return |@left-list, $maxval_val, |@right-list;
	} else {
		@right-list = max-digits-acc(@acc, @str-list[$maxval_idx^..*-1], $nb-elements - 1);
		return $maxval_val, |@right-list;
	}
}

my $sum = 0;

for $file.IO.lines -> $line {
	my $match = Parser.parse($line);
	my @values = $match<digit>.map: *.Int;
	my $size_list = @values.elems;
	my @digits-list = max-digits(@values, 12);
	my $value-digit = @digits-list.reduce: &infix:<~>;
	$sum +=($value-digit);
}
say $sum;
