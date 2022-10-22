#!/usr/bin/perl
for($i=0;$i<10;$i++)
{
$qw[$i]+=$qw[$i]+10;
@value= $qw[$i];

$f_name=$ARGV[0];chomp($f_name);
open(FILE,"$f_name") or die "$!";
@patterns=<FILE>;

#close FILE;
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
system "rm "
	system "svm_learn -z r -t 2 -g 0.001 -c $value[$c] train.pat model";
	system "svm_classify test.pat model predict";
	system "cat predict >> prediction";
	print "---\n";
	
    }
}

#$file1=$ARGV[1];
$file2=$ARGV[1];
$file3=$ARGV[2];

open (FILE,"$f_name");
while($line1=<FILE>)
{
chomp($line1);
@amino = split(/\s+/,$line1);
$first[$i1]=$amino[0];
$i1++;
}
close FILE;
$len=@first;
#print"&&$len\n";
open(FP1,"$file2");
while($line=<FP1>)
{
    chomp($line);
    $loopre[$i3]=$line;
    $i3++;
}
close FP1;
$len1=@loopre;
#print"$len1";
#print"==@first";
#print"**@loopre";
for($i2=0;$i2<$len;$i2++)
{
open(FP2,">>$file3");
if($first[$i2] ne "")
{
    print FP2"$first[$i2]  ";
}
if($loopre[$i2] ne "")
{
    print FP2"$loopre[$i2]\n";
}

}
#close FP2;
$sumX=0; $sumY=0;@sqX=0; @sqY=0; $sqr_X=0; $sqr_Y=0; $multXY=0;$val1=0;$val2=0; $val3=0; $nominator=0; $denominator=0; $correlation=0;$count=0;$line ="";@amino=0; @first=0;@second=0;
$file4=$ARGV[4];
open(FP2,"$file3");
while($line=<FP2>)
{
chomp($line);
$count++;
@amino = split(/\s+/,$line);
$first[$i]=$amino[0];
$second[$i]=$amino[1];
$i++;

}
close FP2;
#print"**$count";
for($i=0;$i<$count;$i++)
{
$sumX +=$first[$i];
$sumY += $second[$i];
$sqX[$i] = $first[$i]*$first[$i];
$sqY[$i] = $second[$i] * $second[$i];
$sqr_X += $sqX[$i];
$sqr_Y += $sqY[$i];
$multiple[$i] = $first[$i] * $second[$i];
$multXY +=$multiple[$i];
}
$nominator = ($multXY-($sumX * $sumY)/$count);
$val1=($sqr_X -($sumX * $sumX) / $count);
$val2 = ($sqr_Y -($sumY * $sumY)/ $count);
$val3=$val1 * $val2;
$denominator = sqrt($val3);
$correlation = ($nominator/$denominator);
printf"%5.4f",$correlation;
close FP2;
system "rm prediction";
}
