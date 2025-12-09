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
	my $sum = 0;
	for $match<range> -> $range {
		for $range<first-id>.Int...$range<last-id>.Int -> $val {
			if $val ~~ /^(\d+)$0$/ {
				$sum += $val;
			}
		}
	}
	say $sum;
}
