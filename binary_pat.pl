#!/usr/bin/perl
#nucleotide composition of PAS
#program.pl input file outputfile(+ve)

$file1=$ARGV[0];
$file2=$ARGV[1];

open(FP1,"$file1");
open(FP2,">>$file2");
while($t1=<FP1>)
{ 
    chomp($t1);
    if($t1!~/\>/)
    {
	while($t1!~/\>/)
	{
	    print FP2 "+1 ";
	    @aa=split(//,$t1);
	    $var1="";
	    for($c=0;$c<@aa;$c++)
	    {
		if($aa[$c] eq "A")
		{
		    $var="1000 ";
		}
		if($aa[$c] eq "C")
		{
		    $var="0100 ";
		}
		if($aa[$c] eq "G")
		{
		    $var="0010 ";
		}
		if($aa[$c] eq "T")
		{
		    $var="0001 ";
		}
		$var1.=$var;
	    }
	    @ab=split(/ /,$var1);
	    $j=0;
	    for($c1=0;$c1<@ab;$c1++)
	    {
		$j++;
		print FP2" $j:$ab[$c1]";
	    }
	    print FP2"\n";
	    
	}    
    }
    
}
