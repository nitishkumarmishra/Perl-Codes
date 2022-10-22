#!/usr/bin/perl
$qw[0]=50;
for($i=0;$i<10;$i++)
{
$qw[$i]+=$qw[$i]+10;
@value= $qw[$i];

$f_name=$ARGV[0];chomp($f_name);
open(FILE,"$f_name") or die "$!";
@patterns=<FILE>;
close FILE;
for($c=0;$c<=$#value;$c++)
{
    for($a=0;$a<=$#patterns;$a++)
    {
	open(TRAIN,">train.pat") or die "$!";
	for($b=0;$b<=$#patterns;$b++)
	{
	    chomp($patterns[$b]);
	    if($a == $b)
	    {
		open(TEST,">test.pat") or die "$!";
		print TEST "$patterns[$b]\n";
		close TEST;
	    }
	    else
	    {
		
		print TRAIN "$patterns[$b]\n";
	    }
	}
	close TRAIN;
	system "svm_learn -z r -t 2 -g 0.0001 -c $value[$c] train.pat model";
	system "svm_classify test.pat model predict";
	system "cat predict >> prediction";
	print "---\n";
	
    }
}
}
