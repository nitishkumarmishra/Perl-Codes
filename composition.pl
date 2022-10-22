#!/usr/bin/perl
#program to calculate amino acid/dipeptide/tripeptide composition from a fata format sequence. 
#usage ./prog.pl inputfile outputfile target(i.e. +1/-1) value(1=amino,2=dipeptide,3=tripeptide);
$s1="ACDEFGHIKLMNPQRSTVWY";
@amino=split(//,$s1);
$file1=$ARGV[0];
$file2=$ARGV[1];
$target=$ARGV[2];
$val=$ARGV[3];
$str="";
if($val==1)
{
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
	#	print "@seq\n";
		$len=@seq;
	#	print"$len\n";
		$n=0;
		open(FP1,">>$file2");
		print FP1"$target";
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
		    
		    $compo=(($count/$len)*100);
		    print FP1" $n:";
		    printf FP1"%5.3f",$compo;
		    
		}
#----------------------
		#@seq=();
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
 #   print "@seq1\n";
    $len1=@seq1;
  #  print "$len1\n";
    print FP1"$target";
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
	$compo=(($m/$len1)*100);
	print FP1" $j:";
	printf FP1"%5.3f",$compo;
	
    }
    print FP1"\n";
    close FP;
    close FP1;
}


if($val==2)
{
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
		#print "###@seq\n";
		open(FP1,">>$file2");
		print FP1"$target";
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
			print FP1" $n:";
			printf FP1"%5.3f",$dicomp;
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
    
    for($f=0;$f<$len1;$f++)
    {
	$sub=substr($str,$f,2);
	$seq[$i]=$sub;
	$i++;
    }
    print FP1"$target";
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
	    print FP1" $n:";
	    printf FP1"%5.3f",$dicomp;
	}
    }
    print FP1"\n";
    close FP1;
    close FP;
}

if($val==3)
{ 
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
		#print "$str\n$len1\n";
		for($c=0;$c<$len1;$c++)
		{
		    $sub=substr($str,$c,3);
		    $seq[$i]=$sub;
		    $i++;
		}
		open(FP1,"$file2");
		print FP1"$target";
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
			    print FP1" $n:";
			    printf FP1"%5.3f",$tricomp;
			}
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
    
    $i=$n=0;
    $len=length($str);
    $len1=$len-2;
    for($f=0;$f<$len1;$f++)
    {
	$sub=substr($str,$f,3);
	$seq[$i]=$sub;
	$i++;
    }
    
    print FP1"$target";
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
		print FP1" $n:";
		printf FP1"%5.3f",$tricomp;
	    }
	}
    }
    print FP1"\n";
    close FP1;
    close FP;
}    








