#!/usr/bin/perl
use strict; use warnings;

my $input  = $ARGV[0];
my $title = $ARGV[1];
open (INPUT, $input)||die "cannot open input";

my $genocount;
my $counter = 0;
my @names;
my $ref;
my $alt;
my $prevpos = 0;
my $currentpos;
my $fastacounter = 0;

while (my $line = <INPUT>){
	if ($line !~ m/^##/){
		if ($line =~ m/^#/){ ##take names of indvs and put in array where the hash key can call the correct name later.
		@names = split (/\t/ , $line);
		shift @names for (0..8); #get rid of the non-name stuff to make [0] the first name
		chomp(@names);
		$genocount = scalar @names;
		}
		if ($line !~ m/^#/){
			my @temp = split (/\t/ , $line);
			$currentpos = $temp[1];
			$ref = $temp[3];
			$alt = $temp[4];

			if (($prevpos != 0)  &  ($currentpos > ($prevpos + 1))){ #if not first in vcf or not sequential 	
			my $num=(($currentpos-$prevpos)-1);
			my $replace = ("a" x $num); #write stuff missing before the next SNP
			print "$replace";
			}

			my $allele = &allele; #run sub which assigns correct nucleotide/ambiguity code
			print "$allele";
			$prevpos = $currentpos;
		 
		}
	}

}


close INPUT;
close OUTPUT;




###SUBROUTINES###

sub allele
{
		if($ref eq "A" & $alt eq "G" | $ref eq "G" & $alt eq "A"){
			$_ = "R";
		}
		elsif($ref eq "C" & $alt eq "T" | $ref eq "T" & $alt eq "C"){
			$_ = "Y";
		}
		elsif($ref eq "G" & $alt eq "C" | $ref eq "C" & $alt eq "G"){
			$_ = "S";
		}
		elsif($ref eq "A" & $alt eq "T" | $ref eq "T" & $alt eq "A"){
			$_ = "W";
		}
		elsif($ref eq "G" & $alt eq "T" | $ref eq "T" & $alt eq "G"){
			$_ = "K";
		}
		elsif($ref eq "A" & $alt eq "C" | $ref eq "C" & $alt eq "A"){
			$_ = "M";
		}  
	
}
