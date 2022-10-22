#!/usr/bin/perl
#--program to run hmmpfam 5 fold cross validation ,generating Result_HMM_$thres
#usage of this program  ./run.pl thresholdvalue(for loop may operate)

$thres=$ARGV[0];
#print $thres;
for($i=1;$i<6;$i++){
 open(FT,"/home/nitish/clustalx.linux/HMMER/Test_$i") or die "Error in opening file\n";
    while($line=<FT>){
	chomp($line);
	$y=0;
	@dd=split(/\s+/,$line);
	open(MAK,">/home/nitish/clustalx.linux/HMMER/Temp") or die "Error in opening file\n";
	print MAK"$dd[0]\n";
	print MAK"$dd[1]\n";
	
	#close MAK;
system "hmmpfam -E 1e-4 /home/nitish/clustalx.linux/HMMER/trainingset$i.hmm /home/nitish/clustalx.linux/HMMER/Temp >/home/nitish/clustalx.linux/HMMER/Test.out";
	
	open(FO,"/home/nitish/clustalx.linux/HMMER/Test.out") or die "error in opening file\n";
	while($line2=<FO>){
	    chomp($line2);
	    if(($line2 =~ /Model/)  && ($line2  =~ /Description/)){
		$line1=<FO>;
		$line1=<FO>;
		
	    }
	    
	    chomp($line1);
	    @ff=split(/ +/,$line1);
	}
	print "$ff[2]\n";

 #-------------for loop starts for different value of E-value threshold
	    open(RES,">>/home/nitish/clustalx.linux/HMMER/Result_HMM_$thres");
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


