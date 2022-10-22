#!/usr/bin/perl
##program to convert  single line  sequence in original Fasta format###
$file1=$ARGV[0];
$file2=$ARGV[1];
open(FP,"$file1");
open(FP1,">>$file2");
while($line=<FP>)
{
    chomp($line);
    @sep=split(/    /,$line);
    print FP1 "$sep[0]\n";
    print FP1 "$sep[1]\n";
}
close FP;
close FP1;


 
