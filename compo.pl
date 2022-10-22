#!/usr/bin/perl
$s1="#ACDEFGHIKLMNPQRSTVWY";
for($i1=0;$i1<=20;$i1++)
{
    $aa[$i1]=0;
}
open(FILE,"tempo.txt");
while($t1=<FILE>){
    chomp($t1);
    $count=0;
    if(($t1=~/>/)&&($count==0)){
	print"$t1 $n1 \n";
	$t1=uc($t1);
	$n1=length($t1);
	for($i1=0;$i1<$n1;$i1++){
	    $c1=substr($t1,$i1,1);
	    $n3=index($s1, $c1); 
	    $aa[$n3]++;
	    $count+1;
	    print"$c1 $n3 $aa[$n3] \n";
	}
    }
}    
