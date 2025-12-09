# my $file = open "example.txt", :r;
my $file = open "input.txt", :r;

my $nb0 = 0;
my $nb = 50;

grammar Parser {
    rule TOP { <direction><value> }
    token direction { 'L' | 'R' }
    token value { \d+ }
}

for $file.IO.lines -> $line {
	my $match = Parser.parse($line);
	my $add_value = $match<value>;
	my $nb_new;
	my $nb_click;
	if $match<direction> eq 'L' {
		$nb_new = ($nb - $add_value) mod 100;
		$nb_click = abs(($nb - $add_value) div 100);
	}
	else {
		$nb_new = ($nb + $add_value) mod 100;
		$nb_click = ($nb + $add_value) div 100;
	}
	$nb0 += $nb_click;
	$nb = $nb_new;
}

say $nb0;
