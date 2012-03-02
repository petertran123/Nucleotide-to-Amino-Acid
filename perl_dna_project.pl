#!/usr/bin/perl
#This program involves DNA which is made up of sequences of nucleotides.
#There are 4 nucleotides: Adenine, Cytosine, Thymine, and Guanine. They are represented by A, C, T, and G.
#Every set of 3 nucleotides can produce one of twenty amino acids.
#Users will type in a nucleotide chain and the program will return amino acids.

use strict;

#hash that lists Nucleotide triplet with their respective amino acid in three letter form
my %acid_hash = qw(
TTT Phe
TCT Ser
TGT Cys
TAT Tyr
TTC Phe

TCC Ser
TGC Cys
TAC Tyr
TTG Leu
TCG Ser

TGG Trp
TAG ***
TTA Leu
TCA Ser
TGA ***

TAA ***
CTT Leu
CCT Pro
CGT Arg
CAT His
CTC Leu

CCC Pro
CGC Arg
CAC His
CTG Leu
CCG Pro

CGG Arg
CAG Gln
CTA Leu
CCA Pro
CGA Arg

CAA Gln
GTT Val
GCT Ala
GGT Gly
GAT Asp
GTC Val

GCC Ala
GGC Gly
GAC Asp
GTG Val
GCG Ala

GGG Gly
GAG Glu
GTA Val
GCA Ala
GGA Gly

GAA Glu
ATT Ile
ACT Thr
AGT Ser
AAT Asn
ATC Ile

ACC Thr
AGC Ser
AAC Asn
ATG Met
ACG Thr

AGG Arg
AAG Lys
ATA Ile
ACA Thr
AGA Arg

AAA Lys
);

#hash of single letter amino acids with their three letter versions
my %singles_hash = qw(
A Ala
C Cys
D Asp
E Glu
F Phe
G Gly
H His
I Ile
K Lys
L Leu
M Met
N Asn
P Pro
Q Gln
R Arg
S Ser
T Thr
V Val
W Trp
Y Tyr
* ***
);
my %reverse_hash = reverse (%singles_hash); #reversed the singles_hash to have three letter amino acid first.
#later on this hash is used to show the amino acid's single letter abbreviation as well.
my @abbreviation;
my $max_len = 0;
my $one_letter_codes = "";
my $amino_acid = "";
my $n;

print("Enter a nucleotide sequence, or press ENTER to quit: ");
chomp(my $sequence = <STDIN>);
while ($sequence ne "")
	{
		$sequence = uc($sequence);   	# convert to uppercase
		$sequence =~ s/[^A-Z]//g;    	# remove non-letters
		my $n_chars = length $sequence;	# use this for error checking
		my @triples = $sequence =~ m/(...)/ig;  # separate into triples
		
		if ($n_chars % 3 == 0) #Verify the user is inputting triples
		{
			foreach my $item (@triples) 
			{
				if($acid_hash{$item}) 
				{
					print($item, "   ", $acid_hash{$item}, "\n");
					chomp ($amino_acid = $acid_hash{$item});
					
					if($reverse_hash{$amino_acid})
					{
						push @abbreviation, $reverse_hash{$amino_acid};
						$one_letter_codes = join("", @abbreviation);
					}
				}
				else
				{
					print($item, "   Invalid sequence", "\n");
					push @abbreviation, "?";
					$one_letter_codes = join("", @abbreviation);
				}
			}
			print("One-letter abbreviations: ", $one_letter_codes, "\n");
			@abbreviation = ();
		}
	else
	{
		print("Error: You did not give complete triples. \n"); #in event user does not enter a nucleotide chain divisible by 3
	}
	print("Enter next sequence or ENTER to quit: ");
	chomp($sequence = <STDIN>);
}
