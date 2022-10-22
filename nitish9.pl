#!/usr/bin/perl
$s1="ACDEFGHIKLMNPQRSTVWY";
@amino=split(//,$s1);
open(FILE1,"temp5.txt");
while($line=<FILE1>)
{
    chomp($line);
    $n=length($line);
    $line=uc($line);
   # $tot=0;
   # chomp($line);
    $tot ne"";
    if($line!~/\>/)
    {
	@seq=split(//,$tot);
	for($i1=0;$i1<20;$i1++)
	{
	    $tot ne " ";
	    $count=0;
	    $compo=0;
	    for($i2=0;$i2<$n;$i2++)
	    {
		if($amino[$i1] eq $seq[$i2])
		{
		    $count++ ;
		}
	    }
	    $compo=$count/$n*100;
	    print"$amino[$i1]=$compo \n";
	}
	$tot.=$line;
        print"$tot \n";
	
    }
}
