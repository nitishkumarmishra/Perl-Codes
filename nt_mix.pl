#!/usr/bin/perl
#program for generate random sequence for svm#
#./nt_mix.pl positive.txt negative.txt result.txt#
$file1=$ARGV[0];
$file2=$ARGV[1];
$file3=$ARGV[2];
open(FP,"$file1");
while($line=<FP>)
{
    chomp($line);
    $seq[$i]=$line;
    $i++;
}
close FP;
open(FP1,"$file2");
while($t1=<FP1>)
{
    chomp($t1);
    $seq1[$i1]=$t1;
    $i1++;
}
close FP1;
$poslen=@seq;
$neglen=@seq1;
#print "$poslen\t $neglen\n";
if($poslen >= $neglen)
{
    $finlen=$poslen;
}
else
{
    $finlen=$neglen;
    
}
for($c=0;$c<$finlen;$c++)
{
    open(FP2,">>$file3");
    if($seq[$c] ne "")
    {
	print FP2"$seq[$c]\n";
    }
    if($seq1[$c] ne "")
    {
	print FP2"$seq1[$c]\n";
    }
}


close FP2;    





































