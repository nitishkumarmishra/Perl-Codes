#!/usr/bin/perl
system "rm database*";
$db="/home/nitish/redundancy/testformat.txt";
print "======$db======\n";
system "/home/nitish/blast-2.2.14/bin/formatdb -i $db -p T -n database";
$test="/home/nitish/redundancy/testset.txt";
open(MAD,"$test");
while($line=<MAD>)
{
    chomp($line);
    $y=0;
    @dd=split(/  +/,$line);
    open(MAK,">Temp");
    print MAK"$dd[0]\n";
    print MAK"$dd[1]\n";
    
    close MAK;
    
    system "/home/nitish/blast-2.2.14/bin/blastall -p blastp -e 8e-4  -d database  -i Temp -o Test.out";
 #print"/home/nitish/blast-2.2.14/bin/blastall -p blastp -e 8e-4  -d database  -i TEST -o Test.out\n\n";
    
    $c=0;
    open(FO,">>/home/nitish/redunadancy/Result_8e-4");
    open(MA,"Test.out");
    
    print FO "$dd[0]::";
    while($line=<MA>)
    {
	
	chomp($line);
	$c++;
	if($c>19)
	{
	    
	    if($line=~/^>/)
	    {
		last;
	    }
	    @ff=split(/  +/,$line);
	    print FO "$ff[0],";
	    
	    
	}
    }
    print FO "\n";
    
}


close MAD;


