#!/usr/bin/perl
$file1=$ARGV[0];
$file2=$ARGV[1];
$file3=$ARGV[2];
open(FP,"$file1");
@seq=<FP>;
$i1=@seq;
close FP;
$j=0;
#print @seq;
#print "******";
for($i=0;$i<$i1;$i++)
{
    if($seq[$i]!~m/\/\//)
    {
	$k++;
	open(FP1,">>/usr2/users/nitish/GST/proset/TEST/result$m");
	print FP1 "$seq[$i]";
	close FP1;
    }
    if($seq[$i]=~m/\/\//)
    {
	open(FP1,">>/usr2/users/nitish/GST/proset/TEST/result$m");
	print FP1 "$seq[$i]";
	$m++;
	close FP1;
    }
}
  






