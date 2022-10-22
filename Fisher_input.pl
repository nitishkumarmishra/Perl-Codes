#!/usr/bin/perl
#Date 2nd August 2011
#This is the program for making input file for Fisher's test.
#Here I am using the List of MotifIDs & Dpe_motif as input file
#perl Fisher_input.pl TransfacMotifList Dpe_motif
#Output directly append in FisherTestInput
open(FP,"$ARGV[0]");
open(FP2,">FisherTestInput");
print FP2"TransFac ID\tMatch\tMismatch\tTotal\n";
while($motif=<FP>)
{
    chomp($motif);
    $pos=$neg=$tot=0;
    open(FP1,"$ARGV[1]");
    while($line1=<FP1>)
    {
	
	chomp($line1);
	
	if($line1 =~ $motif)
	{
	    @ab=split(/\s+/,$line1);
	    #print "$ab[0]\t$ab[5]\n";
	    if($ab[5] =~ /0/)
	    {
		$neg++;
	    }
	    else
	    {
		$pos++;
	    }
	}
	
    }
    $tot=$pos+$neg;
    print FP2"$motif\t$pos\t$neg\t$tot\n";
    #print "$motif\n";
    
    close FP1;
}
close FP2;
close FP;
    
		
