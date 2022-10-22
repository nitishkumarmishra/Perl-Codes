#!/usr/bin/perl

# AUC calculation
# Created Fri Jun 6 2008 by Beate Krause (<krause@cs.uni-kassel.de>)

use strict;
use Pod::Usage;
use Getopt::Long;

my $user_file = $ARGV[0];
my $pred_file = $ARGV[1];

# parameters for processing, default: ON
my $GET_AUC = 1;
my $GET_ROC_PLOT = 1;
my $opt_help         = 0;
my $opt_man          = 0;

GetOptions('auc|a=i' => \$GET_AUC,
        'roc|r=i' => \$GET_ROC_PLOT,
        'help' => \$opt_help,
        'man' => \$opt_man
)
or pod2usage(2);

pod2usage(-verbose => 1) if $opt_help;
pod2usage(-verbose => 2) if $opt_man;

if($#ARGV < 1) {
        print STDERR ("usage:\ncalc_auc <data_file_with_user_labels>
<file_with_decision_function_values>\n");
        exit(1);
}

=pod

=head1 NAME
calculate_auc.pl - creates ROC curve plot and calculates AUC value 

=head1 SYNOPSIS

calculate_auc.pl <data_file_with_user_labels> <file_with_decision_function_values>

 Options:
   -auc           Print the area under the ROC curve (AUC) (1 enable, 0 disable)
   -roc           Output the ROC curve points (1 enable, 0 disable)
   -help          Short synposis
   -man           Longer help

=head1 OPTIONS

=over 4

=item B<-AUC>

Binary switch (default: ON).  Output the AUC value. Choose -auc 0 to disable auc
computation.

=item B<-ROC>

Binary switch (default: ON).  Plot the ROC curve. You need to have gnuplot
installed. -roc 0 to disable gnutplot output

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=back

=head1 DESCRIPTION

This script creates the ROC curve points from two input files. One contains the
user_id and the true class of the 
user. One contains the user_id and the confidence for each user that the user is a
spammer. A new file is created 
which stores for each user the true class, confidence, tp, fp, tpr and fpr values.
Out of this file the AUC can be 
computed and the ROC curve plotted. 

=head1 REQUIREMENTS

In order to use the plot function, you need to have "gnuplot" installed. 
available at: http://www.gnuplot.info/

=head1 SEE ALSO

Tom Fawcett: ROC Graphs: Notes and Practical Considerations for Data Mining Researchers
available at: www.hpl.hp.com/techreports/2003/HPL-2003-4.pdf

=cut

# global variables
my %actual_values = (); 
my $totalPos = 0; 
my $totalNeg = 0; 
my (@ROC_toPlot)     = ([0,0,'-']);

# read user id and true classes from user file
open (READ, $user_file) or die ("open $user_file : $!\n");
while (<READ>){

        chomp;
        if ($_ !~ /\d+\s+\d/){
                print STDERR "Wrong line format $_ in $user_file\n";
                exit; 
        }
        my ($usernr, $spamClassification) = split(/\s+/, $_);        
        $actual_values{$usernr}=$spamClassification;
        if ($actual_values{$usernr}){
                $totalPos++;
        }else{
                $totalNeg++;
        }
}
close READ;

# read user id and predictions from prediction file
# prediction file is sorted so that we can get ranking from file

my @predictions = ();

open (READ, $pred_file) or die ("open $pred_file : $!\n");  
  
while (<READ>){
        chomp;
        if ($_ !~ /\d+\s+\d/){
                print STDERR "Wrong line format $_ in $pred_file\n";
                exit;
        }
        my ($usernr, $prediction) = split(/\s+/, $_);
        push @predictions, [$usernr, $prediction];        
}
close READ;

# calculate TP, FP rates for a ranking of users
# sort according to the highest prediction values (ranking)

my ($positiveCounter, $negativeCounter) = (0,0);
my ($tp, $fp) = (0,0);
my ($tp_rate, $fp_rate) = (0.0, 0.0);

open (OUT, ">output_predictions") or die ("write $!\n"); 
# sort by ranking 
foreach (sort {$b->[1] <=> $a->[1]} @predictions){
        # check prediction
         my @inst = @{$_};
        if ($actual_values{$inst[0]}){
                # True Positive!
                $positiveCounter++;
                $tp = $positiveCounter;
                $tp_rate = $positiveCounter / $totalPos;
        }else{
                $negativeCounter++; 
                $fp = $negativeCounter;  
                $fp_rate = $negativeCounter / $totalNeg;
        }
        
        print OUT "$inst[0] $actual_values{$inst[0]} $inst[1] $tp $fp $tp_rate $fp_rate\n"; 
}
close OUT; 

print STDERR "Total Positives: $totalPos\nFalse Positives: $totalNeg\n";

###########################################################################
# calculate AUC value
if ($GET_AUC){
        my $auc = calculate_AUC();
        print "AUC Value: $auc\n";
} 

###########################################################################
# create gnuplot file and graph

if ($GET_ROC_PLOT){
        create_gnuplot(); 
}

# end

############################################################################

# make gnuplot
# please note that you need to have gnuplot installed to use this function

sub create_gnuplot {
        
        # create file with roc points
        open (OUT, ">roc_curve_points") or die ("Can not write\n");
        foreach (@ROC_toPlot){
                
                my ($fpr,$tpr,$prediction) = @{$_};
                print OUT "$fpr\t$tpr\t$prediction\n";
        }
        close OUT;
        
        open (OUT, ">roc_curve.gnu") or die ("Can not write\n");
        
        print OUT join ("set output \"roc.ps\"\n",
                        "set terminal postscript eps colour enhanced 14\n",
                         "set title 'ROC curve'\n",
                        "set yrange [0:1]\n",
                        "set xrange [0:1]\n",
                        "set key right bottom\n",
                        "set xlabel 'FP Rate'\n",
                        "set ylabel 'TP Rate'\n",
                        "plot 'roc_curve_points' using 1:2 with linespoints lw 3 pt 3\n");
        system ("gnuplot roc_curve.gnu"); 
}

############################################################################

# calculate AUC value

sub calculate_AUC {

        # get file with predictions and rates
        my $lastProb = -1; 
        my ($oldTpr, $oldFpr) = (0.0, 0.0);
        my $AUC = 0.0;
        my ($usernr, $trueClass, $prediction, $tpr, $fpr);
        
        open (READ, "output_predictions") or die "Can not read file\n";
        while (<READ>){
                chomp;
                ($usernr, $trueClass, $prediction, $tpr, $fpr) = split(/\s+/, $_);
                $tpr /= $totalPos;# if ($totalPos != 0);
                $fpr /= $totalNeg;# if ($totalNeg != 0);
                
                if ($lastProb != $prediction){
                        my ($new_area) = trapezoid_area($oldFpr, $oldTpr, $fpr, $tpr);
                        $AUC += $new_area;        
                        $lastProb = $prediction;
                        ($oldTpr, $oldFpr) = ($tpr, $fpr);
                        push(@ROC_toPlot, [$fpr,$tpr,$prediction]) if $GET_ROC_PLOT;
                }
        }        
        close READ;
        $AUC += trapezoid_area($oldFpr, $oldTpr, $fpr, $tpr); 
        push(@ROC_toPlot, [$fpr,$tpr,$prediction]) if $GET_ROC_PLOT;
        return $AUC;
}


# This area assumes x1<=x2 and y1<=y2
# This is simply base * 1/2 height.

sub trapezoid_area {
        my($x1, $y1, $x2, $y2) = @_;
        my $area = ($x2 - $x1 ) * ( $y1 + ($y2 - $y1)/2.0 );
        return $area;
}
