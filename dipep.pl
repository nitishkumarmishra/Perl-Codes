#!/usr/bin/perl

$am="ACDEFGHIKLMNPQRSTVWY";
@amino=split(//,$am);

$file1=$ARGV[0];
$file2=$ARGV[1];
$target=$ARGV[2];

$str="";
open(FP,"$file1");
while($t1=<FP>)
{
    chomp($t1);
    if($t1=~/\>/)
    {
	if($str ne "")
	{
	    $n=0;
	    $str=uc($str);
	    $len=length($str);
	    $len1=$len-1;
	    $i=0;
	    for($c=0;$c<$len1;$c++)
	    {
		$sub=substr($str,$c,2);
		$seq[$i]=$sub;
		$i++;
	    }
	    open(FP1,">>$file2");
	    print FP1"$target ";
	    for($c1=0;$c1<@amino;$c1++)
	    {
		$am1=$amino[$c1];
		for($c2=0;$c2<@amino;$c2++)
		{
		    $n++;
		    $am2=$amino[$c2];
		    $join=$am1.$am2;
		    $count=$dicomp=0;
		    for($d=0;$d<@seq;$d++)
		    {
			if($join eq $seq[$d])
			{
			    $count++;
			}
		    }
		    $dicomp=($count/$len1)*100;
		    print FP1"$n:";
		    printf FP1"%5.3f ",$dicomp ;
		   
		}
	    }
	    print FP1"\n";
	}
	$str="";
    }
    else
    {
	$str.=$t1;
    }
}

$n=0;
$i=0;
$str=uc($str);
$len=length($str);
$len1=$len-1;
#print "$str\n$len1\n";
for($f=0;$f<$len1;$f++)
{
    $sub=substr($str,$f,2);
    $seq[$i]=$sub;
    $i++;
}
print FP1"$target ";
for($c1=0;$c1<@amino;$c1++)
{
    $am1=$amino[$c1];
    for($c2=0;$c2<@amino;$c2++)
    {
	$n++;
	$am2=$amino[$c2];
	$join=$am1.$am2;
	#print "$join\n";
	$count=$dicomp=0;
	for($d=0;$d<@seq;$d++)
	{
	    if($join eq $seq[$d])
	    {
		$count++;
	    }
	}
	$dicomp=($count/$len1)*100;
	print FP1"$n:";
	printf FP1"%5.3f ",$dicomp ;
    }
}
print FP1"\n";

















