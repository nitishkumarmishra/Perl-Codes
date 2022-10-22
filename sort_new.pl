#!/usr/bin/perl

$dir=$ARGV[0];
opendir(DIR, "$dir") or die "error in opening directory\n";
while($file=readdir(DIR)){
    chomp($file);
    @A=split(/\./,$file);
   # print "$A[0] **$A[1]^^\n"; #$R=<STDIN>;
    if ($A[1]=~/clustal/){

 #print "$A[0] **$A[1]^^\n";# $R=<STDIN>;
 open (FP,"/home/nitish/blast-2.2.14/bin/cluster/$A[0].clustal") or die "Error in opening file\n";
	system " sort -u /home/nitish/blast-2.2.14/bin/cluster/$A[0].clustal >/home/nitish/blast-2.2.14/bin/cluster/$A[0].sort";
    }
    close FP;
}
close DIR;
