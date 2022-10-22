#!/usr/bin/perl
$s1="ACDEFGHIKLMNPQRSTVWY";
@amino=split(//,$s1);
$str="";
$file1=$ARGV[0];
$file2=$ARGV[1];
$target=$ARGV[2];
open(FP,"$file1");
while($line=<FP>)
{
    chomp($line);
    if($line=~/\>/)
    {
	#$s++;
	$i=0;
	$str=uc($str);
	@seq=split(//,$str);
	$len=@seq;
	$len=length($str);
	#open(FP1,">>$file2");
	#print FP1"$target";
	if($str ne "")
	{
	    open(FP1,">>$file2");
	    print FP1"$target";
		for($c=0;$c<20;$c++)
		{
		    $i++;
		    $count=$comp=0;
		    for($c1=0;$c1<$len;$c1++)
		    {
			if($amino[$c] eq $seq[$c1])
			{
			    $count++;
			}
		    }
		    $comp=($count/$len)*100;
		    print FP1" $i:";
		    printf FP1"%5.3f",$comp;
		}
	    print FP1 "\n";
	    
	}
	$str="";
    }
    else
    {
	$str.=$line;
    }
}
$i=0;
$str=uc($str);
$len=length($str);
@seq=split(//,$str);
print FP1"$target";
for($c=0;$c<20;$c++)
{
    $i++;
    $count=$comp=0;
    for($c1=0;$c1<$len;$c1++)
    {
	if($amino[$c] eq $seq[$c1])
	{
	    $count++;
	}
    }
    $compo=($count/$len)*100;
    print FP1" $i:";
    printf FP1"%5.3f",$compo;
}
print FP1 "\n";
    

