#!/usr/bin/perl
#./prog.pl  mix(random RNA)
$file1=$ARGV[0];
open(MAN,"$file1");
while($t1=<MAN>)
{
    chomp($t1);
    $n++;
    $i=$n%5;
    if($i==1)
    {
	open(FP1,">>set1");
	print FP1"$t1\n"; 
	close FP1;
    }
    if($i==2)
    {
        open(FP1,">>set2");
        print FP1"$t1\n";
	close FP1;
    }
    if($i==3)
    {
        open(FP1,">>set3");
        print FP1"$t1\n";
	close FP1;
    }
    if($i==4)
    {
        open(FP1,">>set4");
        print FP1"$t1\n";
	close FP1;
    }
    if($i==0)
    {
        open(FP1,">>set5");
        print FP1"$t1\n";
	close FP1;
    }
}
