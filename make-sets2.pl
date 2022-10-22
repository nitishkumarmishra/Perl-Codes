#!/usr/bin/perl

$dir=$ARGV[0];$c=0;
opendir(DIR,"$dir");
while($file=readdir(DIR))
{
    if($c>115)
    {
	$c=0;
    }  
    
    chomp($file);
    @A=split(/\./,$file);	
    $str=substr($A[0],0,1);
    if (($A[1] eq "sort") && ($str eq "P"))
    {
	open(FP,"/home/nitish/blast-2.2.14/bin/cluster/$A[0].sort");
	while($line=<FP>)
	{
	    chomp($line);
	    $c++;
	    if ($c<=115)
	    {
		print "$c:$A[0]:$line\n";  
	    }		  
	    elsif($c>115)
	    {
		#last;
		print "$c:$A[0]:$line\n";
		
	    }
	    
	    
	}
	
	
	
    }

}
