#!/usr/local/bin/perl
use Getopt::Std;

getopts("t");

# input file1 col_num1 file2 col_num2 [file 1 columns]; join file1.col_num1 and file2.col_num2; output file2
#assume the first file is shorter

$usage = "$0 -t (to use tab as field seperator) file1 joinColumns1 OutputColumns1 file2 joinColumns2 OutputColumns2
             JoinColumns1 and joinColumns2 look like \"x1 x2..xk\" and \"y1 y2..yk\"
              xi is compared against yi and if all match the OutputColumns1 and OutputColumns2 are output.
             OutputColumns have the same format as joinColumns
";

die "$usage" if ($#ARGV != 5);

($file1, $col1, $ListStr1, $file2, $col2, $ListStr2) = @ARGV;

@joinlist1 = split /\s+/, $col1; 
@joinlist2 = split /\s+/, $col2; 
die "unequal number of join columns\n" if($#joinlist1 != $#joinlist2);
$numjoin = $#joinlist1;

@list1 = split /\s+/, $ListStr1; 
@list2 = split /\s+/, $ListStr2; 

open(F, "<$file1") or die "join.pl: can't open $file1\n";
while(<F>) {
    chomp;
    if(! defined $opt_t) {
      @args = split;
    }
    else {
      @args = split /\t/;
    }
    $key = "";
    foreach $pos (@joinlist1) {
      $key .= $args[$pos]."__";
    }
    push @{$record1{$key}}, $_;
}
close(F);

open(F, "<$file2") or die "join.pl: can't open $file2\n";
while(<F>) {
    chomp;
    if(! defined $opt_t) {
      @args = split;
    }
    else {
      @args = split /\t/;
    }
    $key = "";
    foreach $pos (@joinlist2) {
      $key .= $args[$pos]."__";
    }
    push @{$record2{$key}}, $_;
}
close(F);

foreach $key (keys %record1) {
  foreach $rec1 (@{$record1{$key}}) {
    @args1 = (defined $opt_t) ? split /\t/, $rec1 : split /\s+/, $rec1;
    foreach $rec2 (@{$record2{$key}}) {
      @args2 = (defined $opt_t) ? split /\t/, $rec2 : split /\s+/, $rec2;
      if($ListStr1 =~ /ALL/) {
	printf "%s\t", join "\t", @args1;
      }
      else {
	foreach $col (@list1) {
	  printf "%s\t", $args1[$col];
	}
      }
      if($ListStr2 =~ /ALL/) {
	printf "%s", join "\t", @args2;
      }
      else {
	foreach $col (@list2) {
	  printf "%s\t", $args2[$col];
	}
      }
      print "\n";
    }
  }
}
	
