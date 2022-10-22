#!/usr/bin/perl
## this is the alternate program of psi_output_new.pl for PSSM of 21 amino acid PSSM pattern file generation.This program extract 21 PSSM value from .mtx files.

opendir(DIR,"/home/jagat/Gtp/CD-Hit/Pssm/junk");
while($file=readdir(DIR)){
        chomp($file);
    
	@A= split(/\./,$file);
#	print "$file\n";
    
    if ($A[1] eq "mtx" ){

#	print"$A\n ";
	
	open(FP,"/home/jagat/Gtp/CD-Hit/Pssm/junk/$A[0].mtx");

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

            for($i1=3;$i1<(@num-7);$i1++){
                print "$num[$i1] ";
            }
print "$num[21] ";
            print "; ";
	}
    }
    print "\n";
}
}
