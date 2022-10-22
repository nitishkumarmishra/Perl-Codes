#!/usr/bin/perl
# perl program for removing new line and make Fasta format file#
#$test="/home/nitish/glucapro-90";
open(FP,"/home/nitish/glucapro-90");
#open(FP1,">/home/nitish/result-seq");
while($line=<FP>)
{
    
    chomp($line);
    print "$line";
    #print FP1 "$line";
   

}
#close FP;
#close FP1;
