#!/usr/bin/perl

$var=$ARGV[0];
$file1=$ARGV[1];
open(FP,"Result_Blast_15");
open(FP1,">>$file1");
while($line=<FP>){
    chomp($line);
    @A=split(/\ +/,$line);

    $real=$A[0];
    $pred=$A[1];
   # print "$real       $pred\n";
    if (($real=~/$var/) && ($pred=~/$var/)){
	$tp++;
	print FP1 "$real\t $pred\t TP\n";
    }
    if (($real=~/$var/) && ($pred !~/$var/) && ($pred !~/Zero/)){
	$fn++;
	print FP1 "$real\t $pred\t FN\n";
    }
    if (($real !~/$var/) && ($pred =~/$var/)){
	$fp++;
	print FP1 "$real\t $pred\t FP\n";
    }
    if (($real !~/$var/) && ($pred !~/$var/) && ($pred !~/Zero/)){
	$tn++;
	print FP1 "$real\t $pred\t TN\n";
    }
    if (($real=~/$var/) && ($pred=~/Zero/)){
	$TZ++;
	print FP1 "$real\t $pred\t NO-HIT\n";
    }
    if (($real!~/$var/) && ($pred=~/Zero/)){
	$NZ++;
	print FP1 "$real\t $pred\t Neg-No-Hit\n";
    }
closeFP1;
}
$tob=$tp+$fn;
$ton=$tn+$fp;
$total=$tp+$fn+$TZ;
#print "$total\n";
$np=$tn+$fn;
$tot=$tp+$fn;
$pp=$tp+$fp;
$sen=($tp/$total)*100;
$nnum=($tp*$tn)-($fp*$fn);
$dnum=sqrt($tob*$ton*$pp*$np);
if($dnum != 0){
    $cc=$nnum/$dnum;
}
else{
    $cc=0;
}
$cc= sprintf "%6.2f", $cc;
$sen= sprintf "%6.2f", $sen;
#print "Total hit:$tot\n";
#print "ACC:$sen\t \n";
#print "Correct-Hit:$tp\t Incorrect Hit:$fn\t Negative-as-Positive:$fp\t TN:$tn\t No-Hit:$TZ\t NZ:$NZ\t\n";
