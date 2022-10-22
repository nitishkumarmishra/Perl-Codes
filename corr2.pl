#!/usr/bin/perl
# Program for correlation coefficeint, r square  and mean absolute error. and q squared q2 if observed file is provided
# Usage: corr1.pl file1 (actual values)  file2 (predicted values) file3 (optional for calculating q2)
# file 1 and file2 have values in first colomn

$file1=$ARGV[0];
$file2=$ARGV[1];
$file3=$ARGV[2];


open(FP1,"$file1");
$ar1 = 0;
while($t1=<FP1>){
    chomp($t1);
    $ar1++;
    @ti = split(" ",$t1);
    $x[$ar1] = $ti[0];
}
close FP1;

open(FP2,"$file2");
$ar2 = 0;
while($t2=<FP2>){
    chomp($t2);
    $ar2++;
    @ti = split(" ",$t2);
    $y[$ar2] = $ti[0];
}
close FP2;

if( $ar1 > $ar2){$ar1 = $ar2;}
if( $ar1 < $ar2){$ar2 = $ar1;}


$sx = 0;
$sy = 0;
$sxx = 0;
$syy = 0;
$sxy = 0;


for($i1=1; $i1<= $ar1; $i1++){
    print "$x[$i1] $y[$i1]\n";
    $sx = $sx + $x[$i1];
    $sy = $sy + $y[$i1];
    $sxx = $sxx + $x[$i1]* $x[$i1];
    $sxy = $sxy + $x[$i1]* $y[$i1];
    $syy = $syy + $y[$i1]* $y[$i1];

}

$num = $sxy - ($sx*$sy)/$ar1;

$den = sqrt(($sxx - ($sx*$sx)/$ar1)*($syy - ($sy*$sy)/$ar1));

$cor = $num/$den;


# compute R squared and mean absolute error
$ssr = 0;
$sse = 0;
$sst = 0;
$mae = 0;
$mex = $sx/$ar1;
for($i1=1; $i1<= $ar1; $i1++){
    $mae = $mae + abs($x[$i1] - $y[$i1]);
    $sse = $sse + ($x[$i1] - $y[$i1])*($x[$i1] - $y[$i1]);
    $sst = $sst + ($x[$i1] - $mex)*($x[$i1] - $mex);
    $ssr = $ssr + ($y[$i1] - $mex)*($y[$i1] - $mex);
}
$sst1 = $ssr+$sse;
$mae = $mae/$ar1;
$r2 = 1 - ($sse/$sst);
$rmse = sqrt($sse/$ar1);
$r2a = $ssr/$sst;
$r2b = $ssr/$sst1;
$r2c = (($sst-$sse)/$sst);
$r2d = (($sst1-$sse)/$sst1);
$r2e = 1 - ($sse/$sst1);
# compute q2
$dim = $#ARGV;
#print "$dim\n";
if($#ARGV == 2){
    $tot = 0;
    $sum = 0;
open(FP3,"$file3");
while($t2=<FP3>){
    chomp($t2);
    $tot++;
    @ti = split(" ",$t2);
    $sum = $sum + $ti[0];
}
close FP3;
$sse = 0;
$sst = 0;
    $avrg = $sum/$tot;
for($i1=1; $i1<= $ar1; $i1++){
    $sse = $sse + ($x[$i1] - $y[$i1])*($x[$i1] - $y[$i1]);
    $sst = $sst + ($x[$i1] - $avrg)*($x[$i1] - $avrg);
}
$q2 = 1 - ($sse/$sst);

}else{$q2 = 0;
}




#printf("r =%-6.3f r2=%-6.3f r2a=%-6.3f r2b=%-6.3f r2c=%-6.3f r2d=%-6.3f  r2e=%-6.3f  mae=%-6.3f rmse=%-6.3f q2=%-6.3f\n",$cor,$r2,$r2a,$r2b,$r2c,$r2d,$r2e,$mae,$rmse,$q2);


open (FP2,">>RESULT");
#print FP2 "$value\t";
print FP2 "---------------> $cor\t$mae\t$r2\t$q2\n";
