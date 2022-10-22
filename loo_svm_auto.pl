#!/usr/bin/perl

@value= qw(1 10 25 50 100 150 200);


$f_name=$ARGV[0];
$output=$ARGV[1]; chomp($f_name);
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
	system "svm_learn -z r -t 2 -g 0.001 -c $value[$c] train.pat model1";
	system "svm_classify test.pat model predict1";
	system "cat predict1 >> prediction1";
	print "---\n";

    }
}
open FILE;
while($line=<FILE>)
{
chomp($line);
$count++;
@temp= split(/\s+/,$line);
$first1[$i]= $temp[0];
$i++;
open(MAN,">new.pat")        	
print MAN "$first1[$i]\n";
}
