#!/usr/bin/perl
#perl program for LST_listn.new #
$file1=$ARGV[0];
open(IN,"$file1");
$i=0;
while($line=<IN>)
{

chomp($line);

#print "$line\n";
system "cp $line /usr2/users/nitish/GST/proset/TEST1/result-new-proset
}
close IN;







