
#!/usr/bin/perl
#--program to run blat 5 fold cross validation ,generating Result_blast_$thres
#usage of this program  ./run.pl thresholdvalue(for loop may operate)
#$thres=$ARGV[0];

for($i=1;$i<6;$i++){
open(FT,"/home/nitish/bin/Kinases_Psiblast/dataset$i") or die "Error in opening file\n";
    while($db=<FT>){
    $db$i="/home/nitish/trainingset$i";
#print "======$db======\n";
    system "formatdb -i $db$i -p T -n database$i";
    open(FT,"/home/nitish/bin/Kinases_Psiblast/Test_$i") or die "Error in opening file\n";
    while($line=<FT>){
	chomp($line);
	$y=0;
	@dd=split(/\s+/,$line);
	open(MAK,">/home/nitish/bin/Kinases_Psiblast/Temp") or die "Error in opening file\n";
	print MAK"$dd[0]\n";
	print MAK"$dd[1]\n";
	
	#close MAK;
	
	system "blastall -p blastp -e 1e-4  -d database$i  -i Temp -o Test.out";
	
	open(FO,"Test.out") or die "error in opening file\n";
	while($line2=<FO>){
	    chomp($line2);
	    if(($line2 =~ /bits/)  && ($line2  =~ /Value/)){
		$line1=<FO>;
		$line1=<FO>;
		
	    }
	    
	    chomp($line1);
	    @ff=split(/ +/,$line1);
	}
	#print "$ff[2]\n";
	
	#-------------for loop starts for different value of E-value threshold
	open(RES,">>/home/nitish/bin/Kinases_Psiblast/Result_blst_$thres");
	if($ff[2] <= $thres){
	    print RES "$dd[0]  \t  $ff[0]  \t  $ff[2]\n";
	    print "$dd[0]  \t  $ff[0]  \t  $ff[2]\n";
	}
	else {
	    print RES "$dd[0]  \t  Zero  \t  $ff[2]\n";
	    print "$dd[0]   \t  Zero  \t  $ff[2]\n";
	    
    }	
#---------------end of for loop	 
	print "hello";
    }
    close MAK;
    close FO;
    close RES;
    close FT;
}


