# my $file = open "example.txt", :r;
my $file = open "input.txt", :r;

grammar Symbols-Parser {
	rule TOP { \s*<symbol>[\s <symbol>]* }
	token symbol { '+' | '*' }
}

my @table = [];

my $nb-tables = $file.IO.lines[0].split("").elems;
for 0..$nb-tables - 1 {
	@table.push([]);
}

my @symbols = [];

for $file.IO.lines -> $line {
	if $line eq $file.IO.lines[*-1] {
		my $match = Symbols-Parser.parse($line);
		for $match<symbol> -> $symbol {
			@symbols.push($symbol);
		}
	}
	else {
		my @all-chars = $line.split("");
		my $i = 0;
		for @all-chars -> $char {
			@table[$i].push($char);
			$i++;
		}
	}
}

for @table -> @column {
	@column = [~] @column;
	@column = @column.trim();
}

my @table-numbers = [];
for @table -> @elem {
	if @elem eq [] {
		@table-numbers.push([]);
	}
	else {
		@table-numbers[*-1].append(@elem);
	}
}

@table-numbers.pop(); #remove the last empty array [] 

my $sum = 0;
my $nb-operators = @symbols.elems;
for 0..$nb-operators - 1 -> $i {
	my $operator = @symbols[$i];
	my @list-numbers = @table-numbers[$i].flat().map: *.Int;
	if $operator eq '*' {
		$sum+= [*] @list-numbers;
	}
	elsif $operator eq '+' {
		$sum+= [+] @list-numbers;
	}
}

say $sum;
