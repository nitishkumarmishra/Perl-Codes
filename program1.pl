#program for correlation calculation#
#!usr/bin/perl
$sumX=0; $sumY=0;@sqX=0; @sqY=0; $sqr_X=0; $sqr_Y=0; $multXY=0;$val1=0;$val2=0; $val3=0; $nominator=0; $denominator=0; $correlation=0;$count=0;$line ="";@amino=0; @first=0;@second=0;
$file1=$ARGV[0];
$file2=$ARGV[1];
$file3=$ARGV[2];
open(FP,"$file1");
while($line=<FP>)
{
    chomp($line);
    $first[$n] = $line;
    $n++;
}
$count=@first;
#print "**@first";
close FP;
open(FP1,"$file2");
while($line1=<FP1>)
{
    chomp($line1);
    $second[$n1]=$line1;
    $n1++;
}
#print "@second";
close FP1;
open (FP2,">>$file3");
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
#printf"%5.4f",$correlation;
#open (FP2,">>result");
#print FP2 "$value\t";
print FP2 "$correlation \n";
#print FP2"$correlation";
#print FP2 "  \n";
#close FP2;
