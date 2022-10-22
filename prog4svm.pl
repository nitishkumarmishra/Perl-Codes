#!/usr/bin/perl

$file=$ARGV[0];

open(IN,"$file");
while($line=<IN>){print"-1 ";
    chomp($line);

#    print"$line";
    @seq=split(/\ /,$line);

#    $len=@seq;
  #  print"$len\n ";

    for($i=0;$i<@seq;$i++){

	$k=$i+1;

	print"$k:$seq[$i] ";

}
		  print"\n";

# @set=split(/\ /,@seq);
#    print"@set";
  #  $a[$b]=@seq;
  #  $i++;
  # print" $i:$a[$b]\n";




}
