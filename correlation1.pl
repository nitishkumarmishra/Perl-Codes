#program for correlation calculation#
#!usr/bin/perl
$sumX=0; $sumY=0;@sqX=0; @sqY=0; $sqr_X=0; $sqr_Y=0; $multXY=0;$val1=0;$val2=0; $val3=0; $nominator=0; $denominator=0; $correlation=0;$count=0;$line ="";@amino=0; @first=0;@second=0;
$file1=$ARGV[0];
open(FP,"$file1");
while($line=<FP>)
{
chomp($line);
$count++;
@amino = split(//,$line);
$first[$i]=$amino[0];
$second[$i]=$amino[1];
open(MAP,">>$file2");
open(MAT,">>$file3");
print MAP"**$aa[0]\n";
$i++;
}
close FP;
for($i=0;$i<$count;$i++)
{
$sumX += $first[$i];
$sumY += $second[$i];
@sqX = $first[$i]*$first[$i];
@sqY = $second[$i] * $second[$i];
$sqr_X += $sqX[$i];
$sqr_Y += $sqY[$i];
@multiple = $first[$i] * $second[$i];
$multXY +=$multiple[$i];
}
$nominator = ($multXY-$sumX * $sumY/$count);
$val1=($sqr_X -($sumX * $sumX / $count));
$val2 = ($sqr_Y -($sumY * $sumY / $count));
$val3 = $val1 * $val2;
#print"$val3";
$denominator = sqrt($val3);
$correlation = $nominator/$denominator;
#printf"%5.4f",$correlation;

