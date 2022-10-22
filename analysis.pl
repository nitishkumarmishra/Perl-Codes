#!/usr/bin/perl
#-------------------------------input is Result_HMM file(each time modify path)
#---usage ./analysis.pl $var
$var=$ARGV[0];
open(FP,"/home/mamoon/HMMER/data/miscellaneous/Result_HMM_50") or die "error in opening file\n";
while($line=<FP>){
    chomp($line);
    @A=split(/\ +/,$line);

    $real=$A[0];
    $pred=$A[2];
    print "$real  $pred\n";
  
   # <STDIN>; 
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
print "ACC:$sen\t \n";
print "TP:$tp\t FN:$fn\t FP:$fp\t TN:$tn\t TZ:$TZ\t NZ:$NZ\t\n";
