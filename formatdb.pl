#!/usr/bin/perl
$test="/home/nitish/GST-NCBI";
open(MAD,"$test")or die "Error in opening file\n";
while($line=<MAD>)
{
    chomp($line);
    $y=0;
    open(MAK,">>/home/nitish/redundancy/testformat.txt");
    if($line=~/^>/)
    {
	@aa=split(/\|/,$line);
	print MAK "\n";
	print "\n";
#	$dd=$line;
	print MAK "$aa[0]|$aa[1]\n";
	print  "$aa[0]|$aa[1]\n ";
    }
    else
    {
	print  "$line";
	print MAK "$line";
    }
    
    close MAK;
    
}

