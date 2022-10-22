#!/usr/bin/perl
$thres=$ARGV[0];
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
     
	system "/home/nitish/blast-2.2.14/bin/blastall -p blastp -e $thres  -d database -i Temp -o Test.out";
	system "cat Test.out >> Blast-out1";
	open(MA,"Test.out");
	while($lin=<MA>){
	    chomp($lin);
	    if(($lin=~ /significant/) && ($lin=~ /alignments:/)){
		$lin=<MA>;
		$lin=<MA>;
		#$lin=<MA>;
		if($y>0){
		    #$y++;
		    $lin=<MA>;
		    $lin=<MA>;
		    
		}
		$y++;
		chomp($lin);
		@ff=split(/  +/,$lin);
		
	
		if($y==0){ 
		    $ff[0]="Zero"; 
		    $ff[2]="1";
		}
	    }
	}
	open(MAP,">>Result_Blast_$thres");
	print MAP"$dd[0]\t $ff[0]\t $ff[2]\n";
#	$y=0;
	
	close MAP;
	
    }	    
    close MAD;
}
