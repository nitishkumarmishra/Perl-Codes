#!/usr/bin/perl
$qw=0;

for($i=0;$i<10;$i++)
{
    $qw[$i]+=$qw[$i]+20;
    @value= $qw[$i];
    $f_name=$ARGV[0];
    chomp($f_name);
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
	    system "svm_learn -z r -t 2 -g 0.001 -c $value[$c] train.pat model";
	    system "svm_classify test.pat model predict";
	    system "cat predict >> prediction";
	    #system "cat prediction\n";
	}
    open (FILE,"$f_name");
    while($line1=<FILE>)
    {
	chomp($line1);
	@amino1 = split(/\s+/,$line1);
	$first1[$i1]=$amino1[0];
	$i1++;
    }
    #print"&*$i1";
    #print"@first\n";
    close FILE;
    for($m=0;$m<$i1;$m++)
	
	
    {
	open(FP2,">>value1");
	print FP2"$first1[$m]\n";
    }
    #print"value1 \n";
    close FP2;
    system "perl program.pl prediction value1 result";
    $r=<STDIN>;
    system "rm prediction";
    system "rm value1";
    }
}

