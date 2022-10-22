#!/usr/bin/perl
open(FO,"/home/nitish/blast-2.2.14/bin/cluster/P_10.clustal");

while($line=<FO>){
    chomp($line);
    print "$line\n";
}
