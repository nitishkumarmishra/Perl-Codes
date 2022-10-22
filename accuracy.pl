#!/usr/bin/perl
$file1=$ARGV[0];
$file2=$ARGV[1];
$file3=$ARGV[2];

open(CAT,"$file1");
while($line=<CAT>)
{
    chomp($line);
    $aa[$i]=$line;
    $i++;
}
close CAT;
open(GAT,"$file2");
while($bin=<GAT>)
{
    chomp($bin);
    $bb[$j]=$bin;
    $j++;
}
close GAT;
open(DAG,">>$file3");
for($a=0;$a<=1.6;$a=$a+0.1)
{
    
    $tp=$tn=$fp=$fn=0;
    for($b=0;$b<@aa;$b++)
    {
	if(($aa[$b]>=$a) && ($bb[$b]>=$a))
	{
	    $tp++;
	}
	if(($aa[$b]<$a) && ($bb[$b]<$a))
	{
	    $tn++;
	}
	if(($aa[$b]>=$a) && ($bb[$b]<$a))
	{
	    $fn++;
	}
	if(($aa[$b]<$a) && ($bb[$b]>=$a))
	{
	    $fp++;
	}
    
    }
    
    $binder=$tp+$fn;
    $nonb=$tn+$fp;
    print "$binder\t$nonb\n";
    print DAG"$a\t$tp\t$tn\t$fp\t$fn\t";
    
    $total=$tp+$fp+$tn+$fn;
    if($binder!=0)
    {
	$sensitivity=($tp/($tp+$fn))*100;
    }
    else
    {$sensitivity=0;}
    if($nonb!=0)
    {
	$specificity=($tn/($tn+$fp))*100;
    }
    else
    {$specificity=0;}
#$PPV=$tp/($tp+$fp);
#$NPV=$tn/($tn+$fp);
    $accuracy=(($tp+$tn)/$total)*100;
    printf DAG"%4.2f",$sensitivity;
    print DAG"\t";
    printf DAG"%4.2f",$specificity;
    print DAG"\t";
#printf DAG"%4.2f",$PPV;
#print DAG"\t";
#printf DAG"%4.2f",$NPV;
#print DAG"\t";
    printf DAG"%4.2f",$accuracy;
    print DAG"\n";
       
}
print DAG"===================XXXXXX==============\n";
close DAG;
