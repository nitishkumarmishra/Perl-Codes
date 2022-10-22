#!/usr/bin/perl
$test="/home/nitish/GST-NCBI";
open(MAD,"$test")or die "Error in opening file\n";
while($line=<MAD>)
{
    chomp($line);
    #$a=0;
    open(MAK,">>/home/nitish/redundancy/testset.txt");
    if($line=~/^>/)
    {
	$a++;
	@aa=split(/\|/,$line);
	print MAK "\n";
	print "\n";
#	$dd=$line;
	print MAK ">P$a     ";
	print  ">P$a    ";
    }
    else
    {
	print  "$line";
	print MAK "$line";
    }
    
    close MAK;
    
}

