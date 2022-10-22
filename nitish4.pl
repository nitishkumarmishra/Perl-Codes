#!/usr/bin/perl
$s1="#ACDEFGHIKLMNPQRSTVWY";
for($i1=0;$i1<=20;$i1++){
    $aa[$i1]=0;}
$var ne" ";
$count=0;
open(FILE4,"temp4.txt");
while($t1=<FILE4>){
    chomp($t1);
    $n1=length($t1);
    $t1=uc($t1);
    print"$n1\n $t1\n";
    if(($t1=~/>/)&&($t1=~s/ //g)){
	next ;
        $count++;}
    else {
	$var=~s/\s//g;
	$var=$t1;
	print"$var";}
	for($i1=0;$i1<$n1;$i1++){
	    $c1=substr($t1,$i1,1);
	    $n3=index($s1,$c1);
            $aa[$n3]++;
	    print"  $c1 $n3 $aa[$n3] \n";
	}
   $var.=$t1; }
print"$var";
$tot=0;
for($i1=0;$i1<20;$i1++){
    $tot =$tot + $aa[$i1];
}
print"\n $tot \n";
for($i1=0;$i1<20;$i1++){
    $comp=$aa[$i1]*100/$tot;
    $c1=substr($s1,$i1,1);
    print"$c1  $aa[$i1] $i1 $comp\n";
}



