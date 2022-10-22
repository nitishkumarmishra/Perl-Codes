# Program for correlation coefficeint. Usage: col_corr -i file -a col1 -b col2
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

####################################


$d2=0;
for($i1=1; $i1<= $ar1; $i1++){
        
    #$d1 = ($x[$i1]- $y[$i1]);
    #$d2+=$d1**2;
    $d2 += ($x[$i1]- $y[$i1])**2;

}
$rank = (1 - ((6*$d2)/($ar1*($ar1**2-1))));
# compute coefficient of rank ##


printf("D square = %-15.3f\nCoefficient of rank = %-6.4f\n",$d2,$rank);

}else{print "Usage: col_corr -i col_file -a col_num1 -b col_num2 \n"; }
