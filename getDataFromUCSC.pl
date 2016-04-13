#Mon Aug 23 10:19:46 CEST 2010
use DBI;
use strict;
use warnings;

#connect to the USCS database
my $dbh = DBI->connect("dbi:mysql:database=hg18;host=genome-mysql.cse.ucsc.edu;user=genome") or die "Couldn't connect to database: " . DBI->errstr;

#prepare the statement
my $sth = $dbh->prepare('SELECT * FROM snp130;') or die "Couldn't prepare statement: " . $dbh->errstr;

#execute the statement
$sth->execute();

my $header="bin chrom chromStart chromEnd name score strand refNCBI refUCSC observed molType class valid avHet avHetSE func locType weight";
print $header,"\n";

while (my @d=$sth->fetchrow_array()) {
    print join " ",@d;
    print "\n";
}

$sth->finish;

$dbh->disconnect();
