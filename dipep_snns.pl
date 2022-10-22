#!/usr/bin/perl
$file1=$ARGV[0];
$file2=$ARGV[1];
#$am="ACDEFGHIKLMNPQRSTVWY";
#@amino=split(//,$am);

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
#print "$l\n";
#open(FP1,">>$file2");
print "SNNS pattern definition file V4.2\ngenerated at Tue 22 9:30:00 2005\n\n\n";
print "No. of patterns : $l\nNo.of input units : 400\nNo. of output units : 1\n\n";
$s1="ACDEFGHIKLMNPQRSTVWY";
@amino=split(//,$s1);
$am="ACDEFGHIKLMNPQRSTVWY";
@amino=split(//,$am);
$str="";
open(FP,"$file1");
while($line=<FP>)
{
    chomp($line);
    if($line=~/\>/)
    {
	if($str ne "")
	{
	    
	    $k++;
	    print "# Input pattern : $k\n";
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
	   # print "$target ";

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
		    printf " %4.3f",$dicomp ;
		}
	    }
	    print "\n";
	    print "# Output pattern : $k\n$target\n";
	}
	$str="";
    }
    else
    {
	$str.=$line;
    }
}
$k1=$k+1;
print "\n# Input pattern : $k1\n";
$n=0;
$i=0;
$str=uc($str);
$len=length($str);
$len1=$len-1;
#print "$str\n";
for($f=0;$f<$len1;$f++)
{
    $sub=substr($str,$f,2);
    $seq[$i]=$sub;
    $i++;
}
print "$target ";
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
	printf " %4.3f",$dicomp ;
    }
}
print "\n# Output pattern : $k1\n";
print "$target\n";
close FP;
close FP1;








