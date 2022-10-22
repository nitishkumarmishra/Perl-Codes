#!/usr/bin/perl -w
$s1="#ACDEFGHIKLMNPQRSTVWY";
# $var ne" ";
for($i1=0;$i1<=20;$i1++){
    $aa[$i1]=0;}
open(FILE5,"temp4.txt");
while($t1=<FILE5>){
    if($t1!~/\>/)
    {
    chomp($t1);
    $n1=length($t1);
    $t1=uc($t1);
    print"$t1 $n1\n";
    for($i1=0;$i1<$n1;$i1++){
	$c1=substr($t1,$i1,1);
	$n3=index($s1,$c1);
	$aa[$n3]++;
	print"$c1 $n3  $aa[$n3] \n";
    }
}
}
$tot=0;
for($i1=0;$i1<20;$i1++){
    $tot=$tot+$aa[$i1];}
print"$tot";
for($i1=0;$i1<20;$i1++){
    $comp=$aa[$i1]*100/$tot;
    $c1=substr($s1,$i1,1);
    print"$c1 $i1\n $aa[$i1] $comp \n";
}
