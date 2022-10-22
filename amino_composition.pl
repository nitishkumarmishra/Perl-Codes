#!/usr/bin/perl
$s1="ACDEFGHIKLMNPQRSTVWY";
@amino=split(//,$s1);
$file1=$ARGV[0];
#$file2=$ARGV[1];
$cond=0;
$str="";
open(FP,"$file1");
while($t1=<FP>)
{
    chomp($t1);
    if($t1=~/>/)
    {
	if($str ne "")
	{
	    $str=uc($str);
	    @seq=split(//,$str);
	    $len=@seq;
	   # print "$len";
	    $n=0;
	    print "+1 ";
	    for($c=0;$c<20;$c++)
	    {
		$n++;
		$count=0;
		$compo=0;
		for($d=0;$d<$len;$d++)
		{
		    if($amino[$c] eq $seq[$d])
		    {
			$count++;
		    }
		}
		
		$compo=$count/$len*100;
		print"$n:";
		printf"%5.3f ",$compo;
	    }
	    print "\n";
	}
	#print "$t1\n";
	$str="";
    }
    else
    {
	$str.=$t1;
    }
}
#print "$str\n";
$str=uc($str);
@seq1=split(//,$str);
$len1=@seq1;
print "+1 ";
for($c=0;$c<20;$c++)
{
   $j++;
    $count=0;
    $compo=0;
    for($d=0;$d<$len;$d++)
    {
	if($amino[$c] eq $seq[$d])
	{
	    $count++;
	}
    }
    
    $compo=$count/$len1*100;
    print"$j:$compo ";
    
}
print "\n";







