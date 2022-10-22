#!/usr/bin/perl
$am="ACDEFGHIKLMNPQRSTVWY";
@amino=split(//,$am);
$file1=$ARGV[0];
$file2=$ARGV[1];
open(FP,"$file1");
while($t1=<FP>)
{
    chomp($t1);
    if($t1=~/>/)
    {
	
	$n=0;
	$str=$t1;
	$str=uc($str);
	@seq=split(//,$str);
	$len=@seq;
	print "LENGTH:$len\n";
	open(FP1,">>$file2");
	#print FP1"+1   ";
	for($c1=0;$c1<20;$c1++)
	{
	    $n++;
	    #$am1=$amino[$c1];
	    $count=$comp=0;
	    for($d=2;$d<$len;$d++)
	    {
		if($amino[$c1] eq $seq[$d])
		{
		    $count++;
		    
		}
	    }
	    $comp=(($count/107)*100);
	    
	    print FP1"$amino[$c1]:";
	    printf FP1"%5.3f ",$comp ;
	    
	}
	
	print FP1 "\n";
    }
}








