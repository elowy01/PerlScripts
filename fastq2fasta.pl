#utility to covert from fastq to fasta
use strict;
use warnings;

my $file=$ARGV[0];

die("usage: convertFastq.pl <file.fastq> >stdout\n") if !$file;

 my $count = 0;
 open FH,"<$file";
while(<FH>) {
    chomp;
    $count++;
    my $line=$_;
    if ($count==1) {
	#id
	my $id=$1 if $line=~/\@(.+)/;
	print ">$id\n";
    } elsif ($count==2) {
	#read
	print $line,"\n";
    } elsif ($count==4) {
	$count=0;
    }
    
}
close FH;
