#!/usr/bin/perl
# perl program for binary pattern of nucleotide#
$flle1=$ARGV[0];
$file2=$ARGV[1];
open(FP,"/home/nitish/trial.txt");
open(FP1,">>$file2");
while($t1=<FP>)
{
    chomp($t1);
    #print "$t1";
    if($t1!~/\>/)
    {
	
       	print FP1 "+1";
	@amino=split(//,$t1);
	$var1="";
	for($i=0;$i<@amino;$i++)
	{
	    if($amino[$i] eq "A")
	    {
		$var="10000000000000000000 ";
	    }
	    if($amino[$i] eq "C")
	    {
		$var="01000000000000000000 ";
	    }
	    if($amino[$i] eq "D")
	    {
		$var="00100000000000000000 ";
	    }
	    if($amino[$i] eq "E")
	    {
		$var="00010000000000000000 ";
	    }
	    if($amino[$i] eq "F")
	    {
		$var="00001000000000000000 ";
	    }
	    if($amino[$i] eq "G")
	    {
		$var="00000100000000000000 ";
	    }
	    
	    if($amino[$i] eq "H")
	    {
		$var="00000010000000000000 ";
	    }
	    if($amino[$i] eq "I")
	    {
		$var="00000001000000000000 ";
	    }
	    if($amino[$i] eq "K")
	    {
		$var="00000000100000000000 ";
	    }
	    if($amino[$i] eq "L")
	    {
		$var="00000000010000000000 ";
	    }
	    if($amino[$i] eq "M")
	    {
		$var="00000000001000000000 ";
	    }
	    if($amino[$i] eq "N")
	    {
		$var="00000000000100000000 ";
	    }
	    if($amino[$i] eq "P")
	    {
			$var="00000000000010000000 ";
		    }
	    if($amino[$i] eq "Q")
	    {
		$var="00000000000001000000 ";
	    }
	    if($amino[$i] eq "R")
	    {
		$var="00000000000000100000 ";
	    }
	    if($amino[$i] eq "S")
	    {
		$var="00000000000000010000 ";
	    }
	    if($amino[$i] eq "T")
	    {
		$var="00000000000000001000 ";
	    }
	    if($amino[$i] eq "V")
	    {
		$var="00000000000000000100 ";
	    }
	    if($amino[$i] eq "W")
	    {
		$var="00000000000000000010 ";
	    }
	    if($amino[$i] eq "Y")
	    {
		$var="00000000000000000010 ";
	    }
	    if($amino[$i] eq "W")
	    {
		$var="00000000000000000010 ";
	    }
	    if($amino[$i] eq "W")
	    {
		$var="00000000000000000010 ";
	    }
	    if($amino[$i] eq "W")
	    {
		$var="00000000000000000010 ";
	    }
	    if($amino[$i] eq "W")
	    {
		$var="00000000000000000010 ";
	    }
	    if($amino[$i] eq "W")
	    {
		$var="00000000000000000010 ";
	    }
	    $var1.=$var;
	    # print "$var1";
	}
	@amino1=split(/ /,$var1);
	$m=0;
	for($i1=0;$i1<@amino1;$i1++)
	{
	    $m++;
	    print FP1 " $m:$amino1[$i1]";
	}
	print FP1 "\n";
   
    }
}

