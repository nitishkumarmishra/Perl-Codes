#!/usr/bin/perl

$file1=$ARGV[0];
$numb=$ARGV[1];
$file2=$ARGV[2];

chomp($numb);
chomp($file1);
open(MAT,">>$file2");
open(MAN,"$file1");
while($line=<MAN>)
{
    chomp($line); 
    @aa=split(/ /,$line);
    if($aa[0]==$numb)
    {
	$target="+1";
    }
    else
    {
	$target="-1";
    }
        
    print MAT"$target";
    for($c=1;$c<@aa;$c++)
    {
	print MAT" $aa[$c]";
    }
    print MAT"\n";
}
close MAN;
close MAT;
