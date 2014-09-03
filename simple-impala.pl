#!/usr/bin/perl -w
use strict;
my $myDSN="Imp64";
use DBI;

my $dbh = DBI->connect("dbi:ODBC:$myDSN");
my $sth = $dbh->prepare("show tables");
$sth->execute;

my @row;

while (@row = $sth->fetchrow_array) {
        print "@row\n";
}


my $prodquery = "select * from sensor";

my $sth2 = $dbh->prepare($prodquery);
$sth2->execute;
my @row2;
while (@row2 = $sth2->fetchrow_array) {
        print "@row2\n";
}