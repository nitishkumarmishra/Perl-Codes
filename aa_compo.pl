#!/usr/bin/perl
#program to calculate amino acid/dipeptide/tripeptide composition from a fata format sequence. 
#usage ./prog.pl inputfile outputfile target value(1=amino,2=dipeptide,3=tripeptide);


$s1="ACDEFGHIKLMNPQRSTVWY";
@amino=split(//,$s1);

$file1=$ARGV[0];
$file2=$ARGV[1];
$target=$ARGV[2];
$val=$ARGV[3];
$str="";

open(FP,"$file1"); 
while($t1=<FP>)
{
    chomp($t1);
    if($t1=~/>/)
    {
	$k++;
	if($str ne "")
	{
	    $str=uc($str);
	    @seq=split(//,$str);
	    $len=@seq;
	    $n=0;
	    open(FP1,">>$file2");
	    print FP1"$target ";
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
		
		$compo=$count/$len;
		print FP1"$n:";
		printf FP1"%4.3f ",$compo;
		
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

$str=uc($str);
@seq1=split(//,$str);
$len1=@seq1;
$j=0;
print "$str\n$len1\n";
print FP1"$target ";
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
    $compo=$m/$len1;
    print FP1"$j:";
    printf FP1"%6.5f ",$compo;
    
}
print FP1"\n";
close FP;
close FP1;










