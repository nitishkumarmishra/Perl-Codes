#!/usr/bin/perl
#a program for calculation of amino acid composition developed by ni30#
$s1="ACDEFGHIKLMNPQRSTVWY";
@amino=split(//,$s1);
$file1=$ARGV[0];
$file2=$ARGV[1];
$target=$ARGV[2];
$str="";
open(FP,"$file1");
while($line=<FP>)
{
    chomp($line);
    if($line=~/\>/)
    {
	$k++;
	if($str ne "")
	{
	   # $i=0;
	    $str=uc($str);
	    $s=0;
	    @sa=split(//,$str);
	    $len=@sa;
	    open(FP1,">>$file2");
	    print FP1"$target";
	    for($c1=0;$c1<@amino;$c1++)
	    {
		$s++;
		$count=$comp=0;
		for($c2=0;$c2<$len;$c2++)
		{
		    if( $amino[$c1] eq $sa[$c2])
		    {
			$count++;
		    }
		    
		}
		$comp=($count/$len)*100;
	    }
	    print "$comp[$c1]";
	}
	print "\n";
	
    }
    else
    {
	$str.=$line;
    }
}






