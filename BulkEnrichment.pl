  #!/usr/bin/perl

    use strict;
    use warnings;
my $num_args = $#ARGV + 1;
if ($num_args != 4 ) {
	print "usage: perl BulkEnrichment.pl <Folder containing the Gene List> <Universe> <pvalue_cutoff> <FDR_cutoff> \n";
	exit;
}

    my $dir = $ARGV[0];
    my $universe=$ARGV[1];
    my $pvalue_cutoff = $ARGV[2];
    my $FDR_cutoff = $ARGV[3];

    #opendir(DIR, $dir) or die $!;

   # while (my $file = readdir(DIR)) {

        # We only want files
  #      next unless (-f "$dir/$file");

        # Use a regular expression to find files ending in .txt
 #       next unless ($file =~ m/\.txt$/);
#
#	system("perl MyEnrichment.pl $dir/$file $universe $pvalue_cutoff $FDR_cutoff");

        #print "$file\n";
  #  }

 #   closedir(DIR);
   
 my $Enrichment_CMD = "/fs/sh-code/Software/R-2.13.0/bin/R --slave --vanilla --args $dir $universe $pvalue_cutoff $FDR_cutoff < Enrichment.R > LOG";
system($Enrichment_CMD);

exit 0;
