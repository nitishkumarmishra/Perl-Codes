#!/usr/bin/perl


open(MAD,"$ARGV[0]");
    while($line=<MAD>){
	chomp($line);
	@dd=split(/\ :: /,$line);
	@dd1=split(/\>/,@dd[0]);
	#$dd[0]=~s/\> //g;
	open(MAK,">$dd1[1].fasta");
	print MAK"> $dd1[1]\n";
	print MAK"$dd[2]\n";
	print "$dd[1]\t$dd[2]\n";
close MAK;
	system "./runpsipred $dd1[1].fasta";
	system "mv psitmp.mtx $dd1[1].mtx";
	system  "rm $dd1[1].blast $dd1[1].horiz $dd1[1].fasta *.ss *.ss2 "; 
    }

