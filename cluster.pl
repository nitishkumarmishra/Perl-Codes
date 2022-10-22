#!/usr/bin/perl
$file1=$ARGV[0];
#$file2=$ARGV[1];
#$file3=$ARGV[2];
open(FP,"$file1");
while($line1=<FP>)
{
    chomp $line1;
    @seq=split(/>/,$line1);
    open (FP1,">>Result_1");
    print FP1 "$seq[1]\n";
    $k++;
}
