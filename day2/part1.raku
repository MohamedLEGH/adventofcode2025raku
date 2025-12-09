# my $file = open "example.txt", :r;
my $file = open "input.txt", :r;

my $nb0 = 0;
my $nb = 50;

grammar Parser {
    rule TOP { <range>[','<range>]* }
    rule range { <first-id>'-'<last-id> }
    token first-id { \d+ }
    token last-id { \d+ }
}

for $file.IO.lines -> $line {
	my $match = Parser.parse($line);
	# say "hello";
	# say $match<range>[1];
	my $sum = 0;
	for $match<range> -> $range {
		# say $range;
		# say $range<first-id>.Int, '-', $range<last-id>.Int;
		for $range<first-id>.Int...$range<last-id>.Int -> $val {
			if $val ~~ /^(\d+)$0$/ {
				# say $val;
				$sum += $val;
			}
			# say $val;
		}
	}
	say $sum;
	# say $match<value>;
	# my $add_value = $match<value>;
	# my $nb_new;
	# my $nb_click;
	# if $match<direction> eq 'L' {
	# 	$nb_new = ($nb - $add_value) mod 100;
	# 	$nb_click = abs(($nb - $add_value) div 100);
	# }
	# else {
	# 	$nb_new = ($nb + $add_value) mod 100;
	# 	$nb_click = ($nb + $add_value) div 100;
	# }
	# $nb0 += $nb_click;
	# $nb = $nb_new;
}

# say $nb0;
