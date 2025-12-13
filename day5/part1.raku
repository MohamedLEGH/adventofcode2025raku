
grammar Parser {
    rule TOP { <min-val>'-'<max-val> }
    token min-val { \d+ }
    token max-val { \d+ }
}

# my $content = "example.txt".IO.slurp; 
my $content = "input.txt".IO.slurp; 

my @split-text = $content.split("\n\n");
my @id-ranges = @split-text[0].split("\n");
my @ingredients = @split-text[1].split("\n");

my $sum = 0;

for @ingredients -> $ingredient {
	my $ingredient-val = $ingredient.Int;
	for @id-ranges -> $id-range {
		my $match = Parser.parse($id-range);
		my $min-val = $match<min-val>.Int;
		my $max-val = $match<max-val>.Int;
		if $min-val <= $ingredient-val <= $max-val {
			$sum++;
			last;
		}
	}
}

say $sum;
