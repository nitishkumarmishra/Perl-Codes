#!/usr/bin/perl
#calclute the average.
$input='';
$count=0;
$sum=0;
$average=0;
while(){
print"input the number";
chomp($input=<STDIN>);
if($input ne''){
$count++;
$sum+=$input;
}   
else{
last;
}
}
$average=$sum /$count;
print"\n total count of number:$count\n";
print"\n sum of the number:$sum\n";
printf("%.2f average\n",$average)     
