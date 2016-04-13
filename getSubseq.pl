#utility to get a subseq from a fasta file containing a unique fasta sequence
use strict;
use warnings;
use Bio::SeqIO;
use Bio::Seq;

die("usage: getSubseq.pl <file.fa> <start> <end> <output>\n") if scalar(@ARGV<3);

my $file=$ARGV[0];
my $start=$ARGV[1];
my $end=$ARGV[2];
my $output=$ARGV[3];

my $prefix=$1 if $file=~/(.+)\.fa/;

#create SeqIO object from file.fa
my $in=Bio::SeqIO->new(-file => "$file",
                       -format => 'Fasta');

my $out = Bio::SeqIO->new(-file => ">$output",
                       -format => 'Fasta');

while (my $seq = $in->next_seq) {
    my $subseq=$seq->subseq($start,$end);
    my $subseqOb=Bio::Seq->new(-display_id=>"$prefix:$start-$end",
			       -seq=>$subseq);
    $out->write_seq($subseqOb);
}

