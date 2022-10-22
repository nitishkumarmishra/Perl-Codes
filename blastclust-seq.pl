#!/usr/bin/perl
## program for coppy the first sequence in file##
$file1=$ARGV[0];
#$file2=$ARGV[2];
#$file3=$ARGV[3];
open(FP,"result");
while($line=<FP>)
{
    chomp($line);
    print "$line  ";
    open(FP2,">>sequence");
    open(FP1,"/home/nitish/gst-1708-sin");
    while($line1=<FP1>)
    {
	if($line1 =~/>$line-/)
	{
	    printf FP2 "$line1";
	}
    }
}
close FP;
close FP1;
close FP2;
