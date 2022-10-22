## Program for the F-test, Z-test, P-test, t-test, Chai-square test, Yate's correction, test, student t-test, testing of hypothesis##

#####-------------------------------------######
use Getopt::Std;
getopts('i:a:b:');

$file1=$opt_i;
$col1=$opt_a;
$col2=$opt_b;

############### Read input file ################

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

######### Calculate E(X), E(Y), E(X^2) etc #######

for($i1=1; $i1<= $ar1; $i1++){
    #print "$x[$i1] $y[$i1]\n";
    $sx = $sx + $x[$i1];
    $sy = $sy + $y[$i1];
    $sxx = $sxx + $x[$i1]**2;
    $sxy = $sxy + $x[$i1]**2;
    $syy = $syy + $y[$i1]**2;
    $d2 += ($x[$i1]- $y[$i1])**2;

}
######### Caculate Mean, SD, Variance ############

$mex= ($sx/$ar1);
$mex1=($sy/$ar1);
$var1 = (($sxx/$ar1)- ($mex**2));
$var2 = (($syy/$ar1)- ($mex1**2));
$std1 = sqrt($var1);
$std2 = sqrt($var2);

####### Calculate correlation ####################

$num = $sxy - ($sx*$sy)/$ar1;
$den = sqrt(($sxx - ($sx**2)/$ar1)*($syy - ($sy**2)/$ar1));
$cor = $num/$den;
$rank = (1 - ((6*$d2)/($ar1*($ar1**2-1))));


# compute R squared and mean absolute error


#print "Mean1=$mex Mean2=$mex1 Var1=$var1 Var2=$var2 SD1=$std1 SD2=$std2\n";
}

###################################################
else{print "Usage: col_rsuare -i col_file -a col_num1 -b col_num2 \n"; }
