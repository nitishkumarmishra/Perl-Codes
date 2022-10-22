#!/usr/bin/perl
$s1="#ACDEFGHIKLMNPQRSTVWY";
for($i1=0;$i1<=20;$i1++){
    $aa[$i1]=0;
}
open(FILE,"temp2.pl");
while($t1=<FILE>){
    chomp($t1);
	$t1=uc($t1);
	$n1=length($t1);
    print"$t1\n $n1 \n";
    for($i1=0;$i1<$n1;$i1++){
	$c1=substr($t1,$i1,1);
	$n3=index($s1,$c1);
	$aa[$n3]++;
	print"$c1 $n3 $aa[$n3]\n";
   }
}
$tot=0;
for($i1=0;$i1<=20;$i1++){
    $tot=$tot+$aa[$i1];
}
    print"$tot \n";
for($i1=0;$i1<20;$i1++){
    $comp=$aa[$i1]*100 / $tot;
    $c1=substr($s1,$i1,1);
print"$c1 $i1  $aa[$i1]  $comp \n";
}

