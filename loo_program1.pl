#usr/bin/perl
# proram for the calculation of correlation. this is semi automatic program $ file1 is the input file and $file is the prediction file#
$file1=$ARGV[0];
$file2=$ARGV[1];
$file3=$ARGV[2];

open(FP,"$file1");
while($line=<FP>)
{
    chomp($line);
    $loopre[$i1]=$line;
    $i1++;
}
close FP;
$len1=@loopre;
print "@loopre\n";


open(FP1,"$file2");
while($line1=<FP1>)
{
chomp($line1);
@amino = split(/\s+/,$line1);
$first[$i1]=$amino[0];
$i1++;
}
close FP1;
$len=@first;
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
close FP2;
