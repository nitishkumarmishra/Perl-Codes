#!/usr/bin/perl
for($i=1;$i<6;$i++){
    system "rm database*";
    $db="dataset"."$i";
    print "======$db======\n";
    system "/home/nitish/blast-2.2.14/bin/formatdb -i $db -p T -o T -n database";
    $test="testset"."$i".".txt";
    open(MAD,"$test");
    while($line=<MAD>){
	chomp($line);
	$y=0;
	@dd=split(/  +/,$line);
	open(MAK,">Temp");
	print MAK"$dd[0]\n";
	print MAK"$dd[1]\n";
       
	close MAK;
     
 system "/home/nitish/blast-2.2.14/bin/blastpgp -e 1e-4 -j 3 -d database -i Temp -o Test.out";
	open(MA,"Test.out");
	while($lin=<MA>){
	    chomp($lin);
	    if(($lin=~ /significant/) && ($lin=~ /alignments:/)){
		$lin=<MA>;
		$lin=<MA>;
		if($y>0){
		$lin=<MA>;
	    }
		$y++;
		chomp($lin);
		@ff=split(/  +/,$lin);
	    }
	    }
	if($y==0){ 
	    $ff[0]="Zero"; 
	    $ff[2]="Zero";
	    
	}
	open(MAP,">>/home/nitish/PSI-Blast/Result_PSI_1e-4");
	print MAP"$dd[0]\t $ff[0]\t $ff[2]\n";
	close MAP;

    }
    
    
    

    close MAD;
    
}
