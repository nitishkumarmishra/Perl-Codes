#!/usr/bin/perl

$c=0;
@name="";
@pred="";
@pred1="";
$i1=0;
@seq="";
$c=0;$m=0;$z=0;
system "rm CHECK";
open(FP,"Result_1e-4");
while($line=<FP>)
{
    
    chomp($line);
    $c++;
    @A=split(/\::/,$line);
    $name[$m]=$A[0];
    $m++;
    $seq[$z]=$A[1];
    $z++;
}	


for ($j=0;$j<@seq;$j++)
{
    if ($j==0)
    {
	print "clustal_$j ::";
	open(FP1, ">>CHECK");
	@pred=split(/\,/,$seq[$j]);
	
	for ($a=0;$a<@pred;$a++)
	{
	    
	    for ($i=0;$i<@name;$i++)
	    {
		$name[$i]=~s/ //g;
		
		if ($pred[$a] eq "$name[$i]")
		{
		    @DD=split(/\,/,$seq[$i]);
		    for ($f=0;$f<@DD;$f++)
		    {		    
			
			
			print FP1 "$DD[$f]\n";
		    }
		    print "$seq[$i],";
		    
		}
	    }	
	    
	}
	print "\n";
	
    }
    
    
    
    if ($j>0)
    {
	print "clustal_$j ::";
	$e=0;
	@pred1=split(/\,/,$seq[$j]);
	open(FP1,"CHECK");
	while($line=<FP1>)
	{
	    chomp($line);
	    
	    if ($pred1[0] eq "$line")
	    {
		$e++;
	    }
	}
	if ($e==0)
	{
	    
	    print "$pred1[0],";
	}
	open(FP1,">>CHECK");
	print FP1 "$pred1[0]\n";
	close FP1;
	for ($s=1;$s<@pred1;$s++)
	{ 	
	    
	    $d=0;
	    
	    open(FP1,"CHECK");
	    while($line=<FP1>)
	    {
		chomp($line);	   
		
		if ($pred1[$s] eq "$line")
		{
		    #print "******$pred1[$s]\n";
		    $d++;
		    
		    
		    }
		
	    }
	    close FP1;
	    if ($d==0){
		
		#print "=======$pred1[$s]\n";
		
		for ($i1=0;$i1<@name;$i1++)
		{
		    
		    if ($pred1[$s] eq "$name[$i1]")
		    {
			@H=split(/\,/,$seq[$i1]);
			for ($c=0;$c<@H;$c++)
			{
			    #print "$H[$c]\n";
			    $x=0;
			    open(FP1,"CHECK");
			    while($line=<FP1>)
			    {
				chomp($line);	   
				
				if ($H[$c] eq "$line")
				{
				    #print "$H[$c]=========$line\n";
				    $x++;
				    
				}
			    }
			    if ($x==0)
			    {
				print "$H[$c],";
			    }
			}
			
			#print "\n";
			#print "**********$seq[$i1],";
			@DD1=split(/\,/,$seq[$i1]);
			$len=@DD1;
			#print "$len\n";
			for ($g=0;$g<@DD1;$g++)
			{		    
			    # print ">>>>>>>>.$DD1[$g]\n";
			    open(FP1, ">>CHECK");		    
			    print FP1 "$DD1[$g]\n";
#print "\n*********$DD1[$f1]\n";
			    
			}
			 
			
			
		    }
		}
	    }
	    
	}
	
	
    }
 
    print "\n";
    
}
