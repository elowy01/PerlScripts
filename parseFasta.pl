use Bio::SeqIO;

#reading in all sequences in a file (in Fasta format)
my $in=Bio::SeqIO->new(-file => "/users/jjaeger/sequencing_analysis/clogmia/results/DNA/non_red.fa",
                       -format => 'Fasta');

my %sort;

while ( my $seq = $in->next_seq() ) {
    push @{$sort{$seq->length}},$seq;
}

my $count=1;
foreach my $length (sort {$b<=>$a} keys %sort) {
    my @seqs=@{$sort{$length}};
    foreach my $seq (@seqs) {
	#print ID
	print ">Clalb$count length=".$seq->length." nts\n";
	print $seq->seq,"\n";
	$count++;
    }
}
