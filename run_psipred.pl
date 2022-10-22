#!/usr/bin/perl

opendir(DIR,"/home/nitish/Nitish/PSSM_programs");
while($file=readdir(DIR)){
    chomp($file);
    @F=split(/\./,$file);
    if ($F[1] eq "fasta"){

	system "./runpsipred1 $F[0].fasta";
	system "mv psitmp.mtx $F[0].mtx";
	system  "rm $F[0].blast"; 
    }
}
