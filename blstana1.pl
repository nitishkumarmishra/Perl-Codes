#!/usr/bin/perl

$var=$ARGV[0];
open(FP,"Result_Blast_1e-15");
while($line=<FP>){
    chomp($line);
    @A=split(/\ +/,$line);

    $real=$A[0];
    $pred=$A[1];
    print "$real       $pred\n";
    if (($real=~/$var/) && ($pred=~/$var/)){
	$tp++;
    
    }
    if (($real=~/$var/) && ($pred !~/$var/) && ($pred !~/Zero/)){
	$fn++;
    }
    if (($real !~/$var/) && ($pred =~/$var/)){
	$fp++;
    }
    if (($real !~/$var/) && ($pred !~/$var/) && ($pred !~/Zero/)){
	$tn++;
    }
    if (($real=~/$var/) && ($pred=~/Zero/)){
	$TZ++;
    }
    if (($real!~/$var/) && ($pred=~/Zero/)){
	$NZ++;
    }
}
$tob=$tp+$fn;
$ton=$tn+$fp;
$total=$tp+$fn+$TZ;
print "$total\n";
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
print "Total hit:$tot\n";
print "ACC:$sen\t \n";
print "Correct-Hit:$tp\t Incorrect Hit:$fn\t Negative-as-Positive:$fp\t TN:$tn\t No-Hit:$TZ\t NZ:$NZ\t\n";
