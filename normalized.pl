#!/usr/bin/perl

open(FP,"Ki-value");
while($line=<FP>){
chomp($line);


$ki[$r]=$line;
$r++;
}


open(FP1,"$ARGV[0]");
$line=<FP1>;

while($line=<FP1>){
    chomp($line);
    
    
          $des[$r11]=$line;
    $r11++;

}


   



for ($g=0;$g<@ki;$g++){

    $val=$ki[$g]+1;
    $val1=log($val);
    $val2=sprintf("%7.3f",$val1);
    $val2=~s/\ +//g;
 print "$val2 ::";


 @G=split(/\s+/,$des[$g]);
    $len=@G;
#print "$len\n";   


for ($s=1;$s<@G;$s++){
    print "$G[$s] ";
	$k=$s+1;
	$norm=(1/(1+(2.7182)**(-$G[$s])));
            $norm=sprintf("%7.4f",$norm);
            $norm=~s/\ +//g;

    #      print "$s:$norm ";

              

    }

   print "\n";
    }

