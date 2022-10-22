#!/usr/bin/perl
$thres=$ARGV[0];
$tp=$total=$precall=0;
open(FP,"Result_Blast_1e-10");
while($line=<FP>){
    chomp($line);
    @A=split(/\ +/,$line);
    $real=$A[0];
    $pred=$A[2];
    
    if($pred < $thres )
    {
	$tp++;
    }
    $total++;
    print "$real       $pred\n";
}
print "$total  $tp\n";
$precall=($tp/$total)*100;
printf "Precentage coverage:%6.3f",$precall% \n;
print "\n";
close FP;
