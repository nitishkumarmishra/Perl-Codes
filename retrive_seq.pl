#!/usr/bin/perl
open(FL,"/home/users/saha/allergen/blast_set/allergen_set/trainset");
while($line=<FL>)
{
    chomp($line);
    @aa=split(/ +/,$line);
    $aler=$aa[0];
    $aler1=$aa[1];
    
    #  print "$aler\n"; 
    open(FO,"/home/users/saha/allergen/blast_set/bin/set5.txt");
    while($line1=<FO>)
    {
	chomp($line1);
	@bb=split(/\:/,$line1);
	$gen=$bb[2];
#	print "**$gen\n";
	if("$aler" eq "$gen")
	{
	    
	    
	    print ">$aler\n";
	    print " $aler1\n"; 
	    
	}
    }
    
    
}
