#!/usr/bin/perl
##perl program for taking first sequence from each cluster result##
$file1=$ARGV[0];
$file2=$ARGV[1];
#$file3=$ARGV[2];
open(FP1,">>result");
open(FP,"$file1");
while($line=<FP>)
{
    chomp($line1);
    @aa=split(/ /,$line);
    
    printf FP1 "$aa[0]\n";
}
close FP;
close FP1;
