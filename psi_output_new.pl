#!/usr/bin/perl


opendir(DIR,"/home/nitish/Nitish/PSSM_programs/temp");
while($file=readdir(DIR)){
        chomp($file);
    
	@A= split(/\./,$file);
#	print "$file\n";
    
    if ($A[1] eq "mtx" ){

#	print"$A\n ";
	
	open(FP,"/home/nitish/Nitish/PSSM_programs/temp/$A[0].mtx");
	print "> $A[0] :: ";
	while($line=<FP>){
	    chomp($line);  
	   
	    
      	if ($line=~/[A-Z]/){
        @p=split("",$line);
	    print "@p :: ";
	}
	@A=split(" ",$line);

	if($A[0] eq "-32768"){
            @num=split(" ",$line);
            shift(@num);
            print "$num[0] ";
            print "$num[2] ";

#for($i1=3;$i1<21;$i1++){

            for($i1=3;$i1<(@num-6);$i1++){
                print "$num[$i1] ";
            }
            print "; ";
	}
    }
    print "\n";
}
}
