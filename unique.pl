#!/usr/bin/perl

@seq="";
$i=0;
$file=$ARGV[0];
open(FP,"$file");
while($line=<FP>)
{
    chomp($line);
    @A=split(/\ ::/,$line);
    if ($A[1]=~/\,/)
    {
	@seq=split(/\,/,$A[1]);
	
	@name=split(/\_/,$A[0]);	
	open(FP1,">P_$name[1].clustal");
	for ($i=0;$i<@seq;$i++)
	{
	    if ($seq[$i] eq "")
	    {
		$seq[$i]=~s/ +//g;
	    }
	    else
	    {
		
		print FP1 "$seq[$i]\n";
	    }
	}
    }
}
