 #!/usr/bin/perl
#SNNS pattern program.
#program to calculate amino acid/dipeptide/tripeptide composition from a fata format sequence tp form an "SNNS pattern". 
#usage ./prog.pl inputfile outputfile target(i.e. +1/-1) value(1=amino,2=dipeptide,3=tripeptide);

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

open(FP1,">>$file2");
print FP1"SNNS pattern definition file V4.2\ngenerated at Mon 21 9:30:00 2005\n\n\n";

$s1="ACDEFGHIKLMNPQRSTVWY";
@amino=split(//,$s1);
$str="";
if($val==1)
{
    print FP1"No. of patterns : $l\nNo.of input units : 20\nNo. of output units : 1\n\n";
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
		    printf FP1"%5.3f ",$compo;
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
    for($s=0;$s<20;$s++)
    {
	$j++;
	$m=0;
	$compo=0;
	for($d=0;$d<$len1;$d++)
	{
	    if($amino[$s] eq $seq1[$d])
	    {
		$m++;
	    }
	}
	$compo=($m/$len1)*100;
	printf FP1"%5.3f",$compo ;
	
    }
    print FP1"\n# Output pattern : $k1\n";
    print FP1"$target\n";
    close FP;
    close FP1;
}


if($val==2)
{
    print FP1"No. of patterns : $l\nNo.of input units : 400\nNo. of output units : 1\n\n";
    open(FP,"$file1");
    while($t1=<FP>)
    {
	chomp($t1);
	if($t1=~/\>/)
	{
	    if($str ne "")
	    {
		$k++;
		print FP1"# Input pattern : $k\n";
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
			printf FP1"%5.3f ",$dicomp;
		    }
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
    
    $n=0;
    $i=0;
    $str=uc($str);
    $len=length($str);
    $len1=$len-1;
    
    for($f=0;$f<$len1;$f++)
    {
	$sub=substr($str,$f,2);
	$seq[$i]=$sub;
	$i++;
    }
    
    for($c1=0;$c1<@amino;$c1++)
    {
	$am1=$amino[$c1];
	for($c2=0;$c2<@amino;$c2++)
	{
	    $n++;
	    $am2=$amino[$c2];
	    $join=$am1.$am2;
	   # print "$join\n";
	    $count=$dicomp=0;
	    for($d=0;$d<@seq;$d++)
	    {
		if($join eq $seq[$d])
		{
		    $count++;
		}
	    }
	    $dicomp=($count/$len1)*100;
	    printf FP1"%5.3f ",$dicomp;
	}
    }
    print FP1"\n# Output pattern : $k1\n";
    print FP1"$target\n";
    close FP1;
    close FP;
}

if($val==3)
{ 
    print FP1"No. of patterns : $l\nNo.of input units : 8000\nNo. of output units : 1\n\n";
    $k=$k1=0;
    open(FP,"$file1");
    while($t1=<FP>)
    {
	chomp($t1);
	
	if($t1=~/\>/)
	{
	    $i=$n=0;
	    $len=length($str);
	    $len1=$len-2;
	    if($str ne "")
	    {
		$k++;
		print FP1"# Input pattern : $k\n";
		#print "$str\n$len1\n";
		for($c=0;$c<$len1;$c++)
		{
		    $sub=substr($str,$c,3);
		    $seq[$i]=$sub;
		    $i++;
		}
		
		for($c1=0;$c1<@amino;$c1++)
		{
		    $am1=$amino[$c1];
		    for($c2=0;$c2<@amino;$c2++)
		    {
			$am2=$amino[$c2];
			for($c3=0;$c3<@amino;$c3++)
			{
			    $n++;
			    $am3=$amino[$c3];
			    $join=$am1.$am2.$am3;
			    $count=$tricomp=0;
			    
			    for($d=0;$d<@seq;$d++)
			    {
				if($join eq $seq[$d])
				{
				    $count++;
				}
			    }
			    $tricomp=($count/$len1)*100;
			    printf FP1"%4.3f ",$tricomp;
			}
		    }
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
    $i=$n=0;
    $len=length($str);
    $len1=$len-2;
    for($f=0;$f<$len1;$f++)
    {
	$sub=substr($str,$f,3);
	$seq[$i]=$sub;
	$i++;
    }
    
    for($c1=0;$c1<@amino;$c1++)
    {
	$am1=$amino[$c1];
	for($c2=0;$c2<@amino;$c2++)
	{
	    $am2=$amino[$c2];
	    for($c3=0;$c3<@amino;$c3++)
	    {
		$n++;
		$am3=$amino[$c3];
		$join=$am1.$am2.$am3;
		$count=$tricomp=0;
		
		for($d=0;$d<@seq;$d++)
		{
		    if($join eq $seq[$d])
		    {
			$count++;
		    }
		}
		$tricomp=($count/$len1)*100;
		printf FP1"%5.3f ",$tricomp;
	    }
	}
    }
    print FP1"\n# Output pattern : $k1\n";
    close FP1;
    close FP;
}    









