#!/usr/bin/perl
$test="/home/nitish/manishfa-0.5";
open(MAD,"$test")or die "Error in opening file\n";
while($line=<MAD>)
{
    chomp($line);
    $y=0;
    open(MAK,">>/home/nitish/manishfa-0.5-sin");
    if($line=~/^>/)
    {
	print MAK "\n";
	print "\n";
	#$a++;
	@aa=split(/\|/,$line);
	print MAK ">$aa[2].negat   ";
	print  ">$aa[2].negat   ";

    }
    else
    {
	print  "$line";
	print MAK "$line";
	#print MAK "\n";
    }
    
    close MAK;
    
}

