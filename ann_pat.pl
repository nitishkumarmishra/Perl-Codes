#!/usr/bin/perl
#program to calculate amino acid/dipeptide/tripeptide composition from a fata format sequence AND NEURAL NETWORK(SNNS). 



$file1=$ARGV[0];
$file2=$ARGV[1];
$target=$ARGV[2];
$val=$ARGV[3];

open(FP,"$file1");
while($line=<FP>)
{
    chomp($line);
    if($line=~/\>/)
    {
	$l++;
    }
}
close FP;
print "$l\n";
open(FP1,">>$file2");
print FP1"SNNS pattern definition file V4.2\ngenerated at Mon 21 9:30:00 2005\n\n\n";
print FP1"No. of patterns : $l\nNo.of input units : 20\nNo. of output units : 1\n\n";
$s1="ACDEFGHIKLMNPQRSTVWY";
@amino=split(//,$s1);

$str="";

open(FP,"$file1"); 
while($t1=<FP>)
{
    chomp($t1);
    if($t1=~/>/)
    {
	if($str ne "")
	{
	    $k++;
	    print FP1"# Input pattern : $k\n";
	    $str=uc($str);
	    @seq=split(//,$str);
	    $len=@seq;
	    $n=0;
	    
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
		
		$compo=($count/$len)*100;
       		printf FP1"%4.3f ",$compo;
		
	    }
	    print FP1"\n";
	    print FP1"# Output pattern : $k\n$target\n";
	    
	}
	$str="";
    }
    else
    {
	$str.=$t1;
    }
   
    
}
$k1=$k+1;
print FP1"# Input pattern : $k1\n";
$str=uc($str);
@seq1=split(//,$str);
$len1=@seq1;
$j=0;

for($f=0;$f<20;$f++)
{
    $j++;
    $m=0;
    $compo=0;
    for($d=0;$d<$len1;$d++)
    {
	if($amino[$f] eq $seq1[$d])
	{
	    $m++;
	}
    }
    $compo=($m/$len1)*100;
    printf FP1"%4.3f ",$compo;
    
}
print FP1"\n# Output pattern : $k1\n";
print FP1"$target\n";
close FP;
close FP1;










