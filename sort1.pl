#!/usr/bin/perl

$dir=$ARGV[0];
opendir(DIR, "$dir") or die "erroe in opening file\n";
while($file=readdir(DIR)){
    chomp($file);
    print "$file\n";
  # open (FP,"$file") or die "error in opening file\n";

    }

