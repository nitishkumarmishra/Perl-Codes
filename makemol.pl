#!/usr/bin/perl
$file1=$ARGV[0];
#$file2=$ARGV[2];
open(FP,"$file1");
while($line=<FP>)
{
    chomp($line);
    if($line=~m/\$$$$/)
    {
	$k++;
	open(FP1,">>/home/nitish/check/TEST/result");
	print FP1 "$line\n";
	close FP1;
	}
    if($line!~m/\M  END|>/)
    {
	open(FP1,">>/home/nitish/check/TEST/result");
	print FP1 "$line\n";
	$m++;
	close FP1;
    }
   if($line=~m/\M  END|>/)
    {
	
	next;
    }
}

close FP;
