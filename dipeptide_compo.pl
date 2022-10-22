#!/usr/bin/perl
$s1="ACDEFGHIKLMNPQRSTVWY";
@amino=split(//,$s1);
$file1=$ARGV[0];
$file2=$ARGV[1];
$targrt=$ARGV[2];
$str="";
open(FP,"$file1");
while($t1=<FP>)
{
    chomp($t1);
    if($t1=~/\>/)
    {
	if($str ne"")
	{
	    $n=0;
	    # $s=0;
	    $str=uc($str);
	    $len=length($str);
	    $len1=$len-1;
	    $s=0;
	    for($i=0;$i<$len1;$i++)
	    {
		$sub=substr($str,$i,2);
		$seq[$s]=$sub;
		$s++;
	    }
	    open(FP1,">>$file2");
	    print FP1"$target";
	    for($c=0;$c<@amino;$c++)
	    {
		$aa1=$amino[$c];
		for($c1=0;$c1<@amino;$c1++)
		{
		    $n++;
		    $aa2=$amino[$c1];
		    $tot=$aa1.$aa2;
		    $comp=$count=0;
		    for($d=0;$d<@seq;$d++)
		    {
			if($tot eq $seq[$d])
			{
			    $count++;
			}
		    }
		    $comp=($count/$len1)*100;
		    printf FP1" $n : $comp";
		}
	    }
	    print"\n";
	}
	$str="";
    }
    else
    {
	$str.=$t1;
    }
    }    
$n=$s=0;
$str=uc($str);
$len=length($str);
$len1=$len-1;
for($i=0;$i<$len1;$i++)
    {
	$sub=substr($str,$i,2);
	$seq[$s]=$sub;
	$s++;
    }

    print FP1"$target";
for($c=0;$c<@amino;$c++)
{
    $aa1=$amino[$c];
    for($c1=0;$c1<@amino;$c1++)
    {
	$aa2=$amino[$c1];
	$tot=$aa1.$aa2;
	$n++;
	$count=$comp=0;
	for($d=0;$d<@amino;$d++)
	{
	    if($tot eq $seq[$d])
	    {
		$count++;
	    }
	}
	$comp=($count/$len1)*100;
	printf FP1" $n : $comp";
    }
}
print FP1"\n";   

    











