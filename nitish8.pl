#!/usr/bin/perl
#$file = $ARGV[0];
$s1="ACDEFGHIKLMNPQRSTVWY";
@amino=split(//,$s1);
open(FILE,"$temp5.txt");
while($t1=<FILE>)
{
   # $n=length($t1);
   # $t1=uc($t1);
    chomp($t1);
    $n=length($t1);
    $t1=uc($t1);
    if($t1!~/\>/)
    {
	@seq=split(//,$t1);
	for($i1=0;$i1<20;$i1++)
	{
	    $count=0;
	    $compo=0;
	    for($i2=0;$i2<$n;$i2++)
	    {
		if($amino[$i1] eq $seq[$i2])
		{
		    $count++;
		}
	    }
	   
	    $compo=$count/$n*100;
	    print" $amino[$i1]=$compo \n";
	    
	}
   
    }
}
			






