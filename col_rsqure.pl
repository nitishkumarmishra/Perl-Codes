# Program for statistical parameter calculation. Usage: col_corr -i file -a col1 -b col2
# file have values in first and 2nd colomn

use Getopt::Std;
getopts('i:a:b:');

$file1=$opt_i;
$col1=$opt_a;
$col2=$opt_b;

if($file1 ne '' && $col1 ne '' && $col2 ne ''){
open(FP1,"$file1");
$ar1 = 0;
while($t1=<FP1>){
    chomp($t1);
if(index($t1,"#") <= -1){ 
    $ar1++;
    @ti = split(",",$t1);
    $x[$ar1] = $ti[$col1-1];
    $y[$ar1] = $ti[$col2-1];
    
}
}


$sx = 0;
$sy = 0;
$sxx = 0;
$syy = 0;
$sxy = 0;


for($i1=1; $i1<= $ar1; $i1++){
    #print "$x[$i1] $y[$i1]\n";
    $sx = $sx + $x[$i1];
    $sy = $sy + $y[$i1];
    $sxx = $sxx + $x[$i1]* $x[$i1];
    $sxy = $sxy + $x[$i1]* $y[$i1];
    $syy = $syy + $y[$i1]* $y[$i1];
    $d2 += ($x[$i1]- $y[$i1])**2;

}

$num = $sxy - ($sx*$sy)/$ar1;

$den = sqrt(($sxx - ($sx*$sx)/$ar1)*($syy - ($sy*$sy)/$ar1));

$cor = $num/$den;
$rank = (1 - ((6*$d2)/($ar1*($ar1**2-1))));

#print "SSX = $sxx SSY = $syy SXY = $sxy Numerator = $num Denom = $den\n";
# compute R squared and mean absolute error
$mex= ($sx/$ar1);
$mex1=($sy/$ar1);
$var1 = (($sxx/$ar1)- ($mex**2));
$var2 = (($syy/$ar1)- ($mex1**2));
$std1 = sqrt($var1);
$std2 = sqrt($var2);
$sse=$sst=$ssr=0;
for($i1=1; $i1<= $ar1; $i1++){
    
    $mae = $mae + abs($x[$i1] - $y[$i1]);
    $sse = $sse + ($x[$i1] - $y[$i1])*($x[$i1] - $y[$i1]);
    $sst = $sst + (($x[$i1] - $mex)*($x[$i1] - $mex));
    $ssr = $ssr +(($y[$i1] - $mex)*($y[$i1] - $mex));
    
    
}
$mae = $mae/$ar1;
$rmse = sqrt($sse/$ar1);
$r2 = 1 - ($sse/$sst);
$r2_1 = ($ssr/$sst);
$r2_2 = (($sst-$sse)/$sst);


printf("Mean of column$col1 = %-15.3f\nMean of column$col2 = %-15.3f\nVariance of column$col1 = %-6.3f\nVariance of column$col2 = %-6.3f\nStandard deviation of column$col1 = %-6.3f\nStandard deviation of column$col2 = %-6.3f\nMean absolute error (MAE) = %-6.3f\nRoot mean square of error (RMSE) = %-6.3f\nPearson's correlation (R) = %-6.3f\nSpearman's rank correlation (Rrank) = %-6.3f\nCoefficient of determination (R2 = 1- SSE/SST) = %-6.3f\nCoefficient of determination (R2 = ((SST-SSE)/SST) =%-6.3f\nCoefficient of determination (R2 = Explained variation/Total variation) = %-6.3f\n",$mex,$mex1,$var1,$var2,$std1,$std2,$mae,$rmse,$cor,$rank,$r2,$r2_2,$r2_1);

}else{print "Usage: col_rsuare -i col_file -a col_num1 -b col_num2 \n"; }
