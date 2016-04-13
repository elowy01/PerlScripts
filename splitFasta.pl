use strict;
use warnings;
use Bio::SeqIO;

my $ifile=$ARGV[0];
my $chsize=$ARGV[1]; #size of chunks
my $prefix=$ARGV[2]; #prefix for output

die("USAGE: perl splitFasta.pl <ifile.fasta> 100 <prefix>\n") if scalar(@ARGV)<3;

#reading in all sequences in a file (in Fasta format)
my $in=Bio::SeqIO->new(-file => $ifile,
                       -format => 'Fasta');

my $count=0;
my $chunk_no=1;
while ( my $seq = $in->next_seq() ) {
    $count++;
    if ($count<=$chsize) {
	my $outfile=$prefix."_".$chunk_no.".fasta";
	my $out;
	if ($count==1) {
	    $out=Bio::SeqIO->new(-file => ">$outfile",
				-format => 'Fasta');
	} else {
	    $out=Bio::SeqIO->new(-file => ">>$outfile",
				-format => 'Fasta');
	}
	$out->write_seq($seq);
    } elsif ($count>$chsize) {
	$count=1;
	$chunk_no++;
	my $outfile=$prefix."_".$chunk_no.".fasta";
	my $out=Bio::SeqIO->new(-file => ">$outfile",
				 -format => 'Fasta');
	$out->write_seq($seq);
    }
}

