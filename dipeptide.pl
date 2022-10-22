#!/usr/bin/perl
# to generate dipeptide composition

$file1=$ARGV[0];
#$file2=$ARGV[1];

open(MAK,"$file1");
while($line=<MAK>)
{
    chomp($line);
    $seq="ARNDCQEGHILKMFPSTWYV";
    @amino=split(//,$seq);
    @ab=split(//,$line);
    $length=@ab;
    for($a=0;$a<$length-1;$a++)
    {
	$sub=substr($line,$a,2);
	$aa[$j]=$sub;
	$j++;
    }
    $n=0;
    open(JAK,">>DIP_COMPOSITION/$file1");
    print JAK"SIXT";
    for($c=0;$c<@amino;$c++)
    {
	$b=$amino[$c];
	for($d=0;$d<@amino;$d++)
	{
	    $k=$amino[$d];
	    $join=$b.$k;
	    $n++;
	    print JAK" $n:";
	    $count=0;
	    
	    for($h=0;$h<@aa;$h++)
	    {
		if($join eq $aa[$h])
		{
		    $count++;		       
		}
	    }
	    $dicomp=$count/($length-1);
	    printf JAK"%6.5f",$dicomp;	
	}
    }
    print JAK"\n";
    #$ASD=<STDIN>;
    @aa="";
    $j=0;
}



