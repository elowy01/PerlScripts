#utility to get a subseq from a fasta file containing a unique fasta sequence
use strict;
use warnings;
use Getopt::Long;
use Bio::SeqIO;
use Bio::Seq;

my ($file,$coords,$output,$help);

my $usage = "
  [--help]          this menu
   --file           Fasta file with sequences to be sliced
   --coords         Coords for fragment to be extracted. Ex: chr4:100000-102000
   --output         Name of output file
   [USAGE] perl $0 --file file.fa --coords chr4:100000-102000 --output subfile.fa
";

&GetOptions(
    'file=s'              => \$file,
    'coords=s'           => \$coords,
    'output=s'            => \$output,
    'help'               => \$help
    );

if ($help || !$file || !$coords || !$output) {
    print $usage;
    exit 0;
}


#create SeqIO object from file.fa
my $in=Bio::SeqIO->new(-file => "$file",
                       -format => 'Fasta');

my $out = Bio::SeqIO->new(-file => ">$output",
                       -format => 'Fasta');

my ($chr,$start,$end)=($1,$2,$3) if $coords=~/(.+)\:(\d+)-(\d+)/;
die("[ERROR] $coords coords are not valid") unless $chr && $start && $end;

while (my $seq = $in->next_seq) {
    next unless $seq->id eq $chr;
    my $subseq=$seq->subseq($start,$end);
    my $subseqOb=Bio::Seq->new(-display_id=>$coords,
			       -seq=>$subseq);
    $out->write_seq($subseqOb);
    last;
}

