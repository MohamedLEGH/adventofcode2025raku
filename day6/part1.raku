# my $file = open "example.txt", :r;
my $file = open "input.txt", :r;

grammar Parser {
    rule TOP { \s*<value>[\s <value>]* }
    token value { \d+|"+"|"*" }
}

my @table = [];

for $file.IO.lines -> $line {
	my @table-line = [];
	my $match = Parser.parse($line);
	for $match<value> -> $value {
		# say $value;
		@table-line.push($value);
	}
	@table.push(@table-line);
}

# say @table;

my @table-reverse = [];

my $nb-columns = @table[0].elems;
for 0..$nb-columns - 1 {
	@table-reverse.push([]);
}

for 0..@table.elems - 1 -> $i {
	for 0..$nb-columns - 1 -> $j {
		@table-reverse[$j].push(@table[$i][$j]);
	}
}

# say @table-reverse;

my $sum = 0;

for @table-reverse -> @column {
	my $operator = @column.pop();
	if $operator eq '*' {
		$sum+= [*] @column;
	}
	elsif $operator eq '+' {
		$sum+= [+] @column;
	}
}

say $sum;
