use strict;
use warnings;

my $ifile=$ARGV[0];

die("[ERROR] perl $0 <id_file>\n") if !$ifile;

my @lines;

open FH,"<$ifile" or die("Cant open $ifile:$!\n");
while(<FH>) {
  chomp;
  my $line=$_;
  $line=~s/^\s//;
  my $newline= "'".$line."',";
  push @lines,$newline;
}
close FH;

for (my $i=0;$i<scalar(@lines);$i++) {
  if ($i==(scalar(@lines))-1) {
    $lines[$i]=~s/\,//;
  }
  if (!$lines[$i]) {
    print "h\n";
  } else {
    print $lines[$i];
  }
}

print "\n";
