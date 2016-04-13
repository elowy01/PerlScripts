use Bio::Seq;
use strict;
use warnings;

my $seqobj=new Bio::Seq->new(-seq=>'NTATCGCGCAACACCAAGTGCAAAGAGGACGTGAAGAGAAAGGAAGTACAGAAAACCTTCACGTAGATCGGAAGAG');

print $seqobj->revcom->seq,"\n";
