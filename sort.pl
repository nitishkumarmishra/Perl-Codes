#!/usr/bin/perl

$dir="/home/nitish/blast-2.2.14/bin/Cluster";
opendir(DIR, "$dir");
while($file=readdir(DIR))
{
   # print "$file";
    chomp($file);
    
    @A=split(/\./,$file);
    print "$A[0].$A[1]\n";
    if($A[1] eq "clustal")
    {
	open("/home/nitish/blast-2.2.14/bin/cluster/$A[0].clustal") or die "error in opening file\n";
	system "sort -u $A[0].clustal >$A[0].sort";
    }
}

