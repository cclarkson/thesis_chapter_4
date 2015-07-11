#!/usr/bin/perl
use strict; #use warnings;

my $input  = $ARGV[0];
my $title = $ARGV[1];
open (INPUT, $input)||die "cannot open input";
open (OUTPUT, ">$title".".inp")||die "cannot open output";

my %Fasta;
my $genocount;
my $counter = 0;
my @names;
my $ref;
my $alt;
my $fastacounter = 0;
my $variantcounter = 0;
my @positions;

while (my $line = <INPUT>){
	if ($line !~ m/^##/){
		if ($line =~ m/^#/){ ##take names of indvs and put in array where the hash key can call the correct name later.
		@names = split (/\t/ , $line);
		shift @names for (0..8); #get rid of the non-name stuff to make [0] the first name
		chomp(@names);
		$genocount = scalar @names;
		}
		if ($line !~ m/^#/){
		$variantcounter ++;
		my @temp = split (/\t/ , $line);
		my $currentpos = $temp[1];
		push (@positions, $currentpos);
		$ref = $temp[3];
		$alt = $temp[4];

			foreach(@temp){
	                        if($_ =~ /^0\/0|^0\/1|^1\/0|^1\/1|^\.\/\./){ #for each genotype type
				my @gen = split (/:/ , $_);
				my @splitgen = split(/\//, $gen[0]);
				my $geno1;
				my $geno2;
				if ($splitgen[0] == 0){
				$geno1 = $ref;
				}
				if ($splitgen[0] == 1){
				$geno1 = $alt;
				}
				if ($splitgen[0] eq ".") {
				$geno1 = "?";
				}
				if ($splitgen[1] == 0){
				$geno2 = $ref;
				}
				if ($splitgen[1] == 1){
				$geno2 = $alt;
				}
				if ($splitgen[1] eq ".") {
				$geno2 = "?";
				}
	
				$Fasta{$counter} .= $geno1; #append this genotype to the hash
			
				$Fasta{$counter} .= $geno2; #append this genotype to the hash
				

	                       		if ($counter < $genocount) { #if there are still more columns (indvs) left in this row ++
					$counter ++;
					}
					if ($counter == $genocount) { #if this is the last column (indv), reset the counter
					$counter = 0;
					}		
	                        }  
	                }
		
		 
		}
	}

}

print "$genocount\n";
print OUTPUT "$genocount\n";
print "$variantcounter\n";
print OUTPUT "$variantcounter\n";
print "P "."@positions\n";
print OUTPUT "P "."@positions\n";
my $alleles = "S" x $variantcounter ;
print "$alleles\n";
print OUTPUT "$alleles\n";





foreach my $name (sort keys %Fasta) {	#sort and print the fasta containing hash
	print "$names[$name]\n";
	print OUTPUT "$names[$name]\n";
	my @split = split(undef,$Fasta{$name});
	my @evens = @split[grep !($_ % 2), 0..$#split];    # even-index elements
	my @odds  = @split[grep $_ % 2, 0..$#split];  	
	print "@evens\n";
	print OUTPUT "@evens\n";
	print "@odds\n";
	print OUTPUT "@odds\n";
}
 
close INPUT;
close OUTPUT;

