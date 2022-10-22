#!/usr/bin/perl
$input='';
@nums=();
$count=0;
$sum=0;
$avg=0;
$med=0;
while(){
print"enter a number:\n";
chomp($input=<STDIN>);
if($ input ne ''){
    $nums[$count]=$input;
    $count++;
    $sum +=$input;
}
else{last ;}
}
@nums={ $ a <=> $ b } @nums;
$avg=$sum/$count;
$med=$nums[$count/2];
print"\n total count of number:$count\n";
print"sum of num:$sum\n";
printf("average:%.2f\n",$gav);
print"median:$med \n";
