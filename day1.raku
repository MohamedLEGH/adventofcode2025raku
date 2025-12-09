# my $file = open "example.txt", :r;
my $file = open "input.txt", :r;

my $nb0 = 0;
my $nb = 50;

grammar Parser {
    rule TOP { <direction><value> }
    token direction { 'L' | 'R' }
    token value { \d+ }
}
# say $nb;
for $file.IO.lines -> $line {
	my $match = Parser.parse($line);
	my $add_value = $match<value>;
	# $nb0 += $match<value>;
	# say $match<direction>.Str, $match<value>.Str;
	if $match<direction> eq 'L' {
		$nb -= $add_value;
		$nb = $nb mod 100;
	}
	else {
		$nb += $add_value;
		$nb = $nb mod 100;
	}
	if $nb == 0 {
		$nb0++;
	}
	# say $nb;
}

say $nb0;
