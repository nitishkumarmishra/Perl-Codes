#!/usr/bin/perl
$file=$ARGV[0];
open(FP, "$file");
while($line=<FP>)
{
    chomp($line);
if($line =~ />/)
{
    print "\n$line##";
}
else
{
    print "$line";
}
}
print "\n";
close FP;
