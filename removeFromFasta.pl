#utility to generate a Fasta files that contains just a subset of the sequences in the original file
use strict;
use warnings;
use Getopt::Long;
use Bio::SeqIO;
use Bio::Seq;

my ($file,$ids,$output,$help);

my $usage = "
  [--help]          this menu
   --file           Original Fasta file
   --ids            File with the Fasta sequences ids that will be removed from the original Fasta file. Eeach ID should go in a new line
   --output         Name of output file
   [USAGE] perl $0 --file file.fa --ids ids.txt --output subfile.fa
";

&GetOptions(
    'file=s'              => \$file,
    'ids=s'           => \$ids,
    'output=s'            => \$output,
    'help'               => \$help
    );

if ($help || !$file || !$ids || !$output) {
    print $usage;
    exit 0;
}


#create SeqIO object from file.fa
my $in=Bio::SeqIO->new(-file => "$file",
                       -format => 'Fasta');

my $out = Bio::SeqIO->new(-file => ">$output",
			  -format => 'Fasta');

my $id_hash=parseIds($ids);


while (my $seq = $in->next_seq) {
    next unless !exists($id_hash->{$seq->id});
    $out->write_seq($seq);
}

sub parseIds {
    my $ids=shift;

    my %hash;
    open FH,"<$ids" or die("Can't open $ids:$!\n");
    while(<FH>) {
	chomp;
        my $line=$_;
        $hash{$line}=0;
    }
    close FH;

    return \%hash;
}
