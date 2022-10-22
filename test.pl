#!/usr/bin/perl

for($i=1;$i<=5;$i++){
    $test="/home/users/saha/allergen/blast_set/testing$i\.set";
    open(MAD,"$test")or die "Error in opening file\n";
    while($line=<MAD>){
	chomp($line);
	$y=0;
	open(MAK,">>/home/users/saha/allergen/blast_set/psiblast/testset$i\.txt");
	if($line=~/^>/){
	    print MAK "\n";
	    print "\n";
	    $dd=$line;
	    print MAK "$dd     ";
	    print  "$dd     ";
	}
	else {
	    print  "$line";
	    print MAK "$line";
	}
	
	close MAK;
    
    }
}
