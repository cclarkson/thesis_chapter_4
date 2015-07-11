#!/usr/bin/perl

###############################################################################################################
## INPUT1 = intron18_exon19_ref.fasta = reference seq                                                        ##
## INPUT2 = intron19_exon19_variant_positions.txt = list of actual haplotype variant positions on chromosome ##
## INPUT3 = gambiae_haplotypes.txt = fasta style list of PHASE output haplotypes                             ## 
## OUTPUT = consensus sequence - combines reference seq with each haplotypes variants, output is .fasta 	 ##
## chris clarkson csc@liv.ac.uk 05/11/14																     ##
###############################################################################################################

use strict;
use warnings;

my $input  = $ARGV[0];
my $positions = $ARGV[1];
my $haplotypes = $ARGV[2];

open (INPUT, $input) || die "fark";
open (POSITIONS, $positions) || die "fook";
open (HAPLOTYPES, $haplotypes) || die "bleurgh";
open (OUTPUT, ">consensus_gambiae_haplotypes.test")|| die "plonk";

my $linecounter = 1;
my $basecounter = 2417800; #change this to first base
my $hapcounter = 1;
my @variants;
my @temphaps;
my %RefHash; ##hash for reference sequence and position
my %Hash130; my %Hash24; my %Hash114; my %Hash69; my %Hash44; my %Hash1; my %Hash84; ##hash for each haplotype variant and position

while (my $haps = <HAPLOTYPES>){
	if ($haps !~ />/){
	chomp($haps);
	push @temphaps, $haps;
	}
 }

#turn string of each haplotype variant bases into an array to access the position of each base
my @hap130 = split("", $temphaps[0]); my @hap24 = split("", $temphaps[1]); my @hap114 = split("", $temphaps[2]); my @hap69 = split("", $temphaps[3]); my @hap44 = split("", $temphaps[4]); my @hap1 = split("", $temphaps[5]); my @hap84 = split("", $temphaps[6]);
 
while (my $pos = <POSITIONS>){  ##put known variant positions from haplotypes in array
	chomp($pos);
	my @temp = split(" ", $pos);
	push(@variants, $temp[0]);
}

#zip together into a hash the variant positions (@variants) with the bases specific to each haplotype
@Hash130{@variants} = @hap130; @Hash24{@variants} = @hap24; @Hash114{@variants} = @hap114; @Hash69{@variants} = @hap69; @Hash44{@variants} = @hap44; @Hash1{@variants} = @hap1; @Hash84{@variants} = @hap84;

while (my $line = <INPUT>){
	chomp($line);
	my @temp = split("", $line);
		foreach(@temp){
	#			print "$_\t$basecounter\n";
				$RefHash{$basecounter} = $_; #append this base to the hash at correct position
				$basecounter ++;

	}		
}

my $fastacounter = 1;
print OUTPUT ">130_weird_wt\n";
foreach my $key (sort {$a <=> $b} keys %RefHash){
	if ($fastacounter < 60){
			if (exists $Hash130{$key}){
			print OUTPUT $Hash130{$key};
			}
			else{
			print OUTPUT $RefHash{$key};
			}
		$fastacounter ++;
	}
	else{
			if (exists $Hash130{$key}){
			print OUTPUT $Hash130{$key};
			print OUTPUT "\n";
			}
			else{
			print OUTPUT $RefHash{$key};
			print OUTPUT "\n";
			}
		$fastacounter = 1;
	}
}

my $fastacounter1 = 1;
print OUTPUT "\n>24_wt_mid_network\n";
foreach my $key (sort {$a <=> $b} keys %RefHash){
	if ($fastacounter1 < 60){
			if (exists $Hash24{$key}){
			print OUTPUT $Hash24{$key};
			}
			else{
			print OUTPUT $RefHash{$key};
			}
		$fastacounter1 ++;
	}
	else{
			if (exists $Hash24{$key}){
			print OUTPUT $Hash24{$key};
			print OUTPUT "\n";
			}
			else{
			print OUTPUT $RefHash{$key};
			print OUTPUT "\n";
			}
		$fastacounter1 = 1;
	}
}

my $fastacounter2 = 1;
print OUTPUT "\n>114_1014F_Cameroon\n";
foreach my $key (sort {$a <=> $b} keys %RefHash){
	if ($fastacounter2 < 60){
			if (exists $Hash114{$key}){
			print OUTPUT $Hash114{$key};
			}
			else{
			print OUTPUT $RefHash{$key};
			}
		$fastacounter2 ++;
	}
	else{
			if (exists $Hash114{$key}){
			print OUTPUT $Hash114{$key};
			print OUTPUT "\n";
			}
			else{
			print OUTPUT $RefHash{$key};
			print OUTPUT "\n";
			}
		$fastacounter2 = 1;
	}
}


my $fastacounter3 = 1;
print OUTPUT "\n>69_1014S_Uganda\n";
foreach my $key (sort {$a <=> $b} keys %RefHash){
	if ($fastacounter3 < 60){
			if (exists $Hash69{$key}){
			print OUTPUT $Hash69{$key};
			}
			else{
			print OUTPUT $RefHash{$key};
			}
		$fastacounter3 ++;
	}
	else{
			if (exists $Hash69{$key}){
			print OUTPUT $Hash69{$key};
			print OUTPUT "\n";
			}
			else{
			print OUTPUT $RefHash{$key};
			print OUTPUT "\n";
			}
		$fastacounter3 = 1;
	}
}


my $fastacounter4 = 1;
print OUTPUT "\n>44_1014S_Kenya\n";
foreach my $key (sort {$a <=> $b} keys %RefHash){
	if ($fastacounter4 < 60){
			if (exists $Hash44{$key}){
			print OUTPUT $Hash44{$key};
			}
			else{
			print OUTPUT $RefHash{$key};
			}
		$fastacounter4 ++;
	}
	else{
			if (exists $Hash44{$key}){
			print OUTPUT $Hash44{$key};
			print OUTPUT "\n";
			}
			else{
			print OUTPUT $RefHash{$key};
			print OUTPUT "\n";
			}
		$fastacounter4 = 1;
	}
}

my $fastacounter5 = 1;
print OUTPUT "\n>1_1014F_West\n";
foreach my $key (sort {$a <=> $b} keys %RefHash){
	if ($fastacounter5 < 60){
			if (exists $Hash1{$key}){
			print OUTPUT $Hash1{$key};
			}
			else{
			print OUTPUT $RefHash{$key};
			}
		$fastacounter5 ++;
	}
	else{
			if (exists $Hash1{$key}){
			print OUTPUT $Hash1{$key};
			print OUTPUT "\n";
			}
			else{
			print OUTPUT $RefHash{$key};
			print OUTPUT "\n";
			}
		$fastacounter5 = 1;
	}
}

my $fastacounter6 = 1;
print OUTPUT "\n>84_weird_recomb_wt\n";
foreach my $key (sort {$a <=> $b} keys %RefHash){
	if ($fastacounter6 < 60){
			if (exists $Hash84{$key}){
			print OUTPUT $Hash84{$key};
			}
			else{
			print OUTPUT $RefHash{$key};
			}
		$fastacounter6 ++;
	}
	else{
			if (exists $Hash84{$key}){
			print OUTPUT $Hash84{$key};
			print OUTPUT "\n";
			}
			else{
			print OUTPUT $RefHash{$key};
			print OUTPUT "\n";
			}
		$fastacounter6 = 1;
	}
}
close INPUT;
close OUTPUT;
