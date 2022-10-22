#!/cagr/software/bin/perl
#####!/usr/bin/perl
use lib "/cagr/bin";
use utils;
use PF_utils;
use Getopt::Std;
#use strict;
use R;
use RReferences;
getopts('b:d:c:Ftpf:');
&R::initR("--silent");
  

$usage = "$0 -b bindfile [-d fastafile] [-c controlSeqIdFile] [-r REFSEQIDFILE] [-R chip TFfile] [-t (tile data)] [-p pairwise] [-f filterTFs when provided only these PWMs are used in pairwise analysis]
bindfile is a 2-column file with RefseqId and binding-value
\n";


# The program is structured as follows
# Ultimately there is one routines implemented : Fisher
# It requires two inputs : 
#      a 2-column file called "chip" with SeqId and Binding value (say, 0 and 1), and 
#      a table file with rows : seqid and column : PWMs and entry = PWMscore, say occupancy probability, or 1/0 or -log)p-value) etc.
# The beginning of the program is basically processing of the input data (could be tile data or refseq data) 
# to get these two files.
# To run Fisher, the two files are processed form Pos and Neg Ids.

# Example usage: ChIP_enrichment.pl -b A1ALL -c A1ALLctrl -t     (Fisher)




if(defined $opt_t) {
    $DBFASTA = (defined $opt_d) ? $opt_d : "/cagr/projects/Pancreas/Data/download-20050815.nomirna.0pad.fa";
    $REFSEQIDFILE = (defined $opt_r) ? $opt_r : "/cagr/projects/Pancreas/Data/TileIDs";
}
else {
    $DBFASTA = (defined $opt_d) ? $opt_d : "/cagr/data/ucsc/Mar0606/mm8/upstream2000.fa";
    $REFSEQIDFILE = (defined $opt_r) ? $opt_r : "/cagr/data/ucsc/Mar0606/mm8/RefSeqIds";
}

if(defined $opt_F) {
    die "with -F option must provide bind file and tf file\n" if ($#ARGV < 1);
    $CHIPFILE = $ARGV[0];
    $TFFILE = $ARGV[1];
    #exit();
}
else {
    die "$usage" if (! defined $opt_b);

    $CHIPFILE = "chip";
    $TFFILE = "pos_and_ctrl.hit";

#extract the positive RefSeq sequences
    if(0) {
	$cmd = "awk '{print \$1;}' $opt_b | sort -u > tmpA";
	print `$cmd`;
	if(defined $opt_t) {
	    $cmd = "comm -12 tmpA /cagr/projects/Pancreas/Data/tiles_with_len100to1000 > tmpB";
	}
	else {
	    $cmd = "comm -12 tmpA $REFSEQIDFILE > tmpB";
	}
	print `$cmd`;
	$cmd = "join.pl tmpB 0 \"\" $opt_b 0 ALL > $opt_b.u";
	print `$cmd`;
	$cmd  = "/cagr/bin/grepSeqs.pl tmpB $DBFASTA > $opt_b.fa";
	print STDERR "$cmd\n";
	print `$cmd` if(! -e "$opt_b.fa");
	#exit;
    }
    
#get control RefSeqs
    if(0) {
	if(defined $opt_c) {
	    print `cp $opt_c $opt_b.ctrl`;
	}
	else {
	    $_ = `wc -l tmpB`;
	    @a = split;
	    $numPos = $a[0];
	    $cmd = "perl -ne 'chomp; printf \"%s %f\\n\",\$_,rand();' $REFSEQIDFILE |  sort -k2n | head -$numPos | awk '{print \$1;}' > $opt_b.ctrl";
	    print `$cmd` if(! -e "$opt_b.ctrl");
	}
	$cmd = "sort -u $opt_b.ctrl > tmpC";
	print `$cmd`;
	if(defined $opt_t) {
	    $cmd = "comm -12 tmpC /cagr/projects/Pancreas/Data/tiles_with_len100to1000 > $opt_b.ctrl.u";
	}
	else {
	    $cmd = "comm -12 tmpC $REFSEQIDFILE > $opt_b.ctrl.u";
	}
	print `$cmd`;
	$cmd  = "/cagr/bin/grepSeqs.pl $opt_b.ctrl.u $DBFASTA > $opt_b.ctrl.fa";
	print STDERR "$cmd\n";
	print `$cmd` if(! -e "$opt_b.ctrl.fa");
	#exit;
    }
    
#run pwm_scan
    
    if(0) {
	$cmd = "pwm_scan -f $opt_b.fa -m /cagr/data/TRANSFAC/v10.2/matrices.vert -s 2 -p -9.21 &> /dev/null";
	print STDERR "$cmd\n";
	print `$cmd` if(! -e "$opt_b.fa.M01125.gff" && ! -e "$opt_b.fa.hit");
	$cmd = "cat $opt_b.fa.M*.gff | awk '{printf \"%s\\t%s\\n\", \$1,\$2;}' | perl -ne 's/.mat//; print;' | sort -u > $opt_b.fa.hit";
	print `$cmd` if(! -e "$opt_b.fa.hit"); 
	$cmd = "rm -f $opt_b.fa.M*.gff";
	print `$cmd`; 
	
    }
    if(0) {
	$cmd = "pwm_scan -f $opt_b.ctrl.fa -m /cagr/data/TRANSFAC/v10.2/matrices.vert -s 2  -p -9.21  &> /dev/null";
	print STDERR "$cmd\n";
	print `$cmd` if(! -e "$opt_b.ctrl.fa.M01125.gff" && ! -e "$opt_b.ctrl.fa.hit");
	$cmd = "cat $opt_b.ctrl.fa.M*.gff | awk '{printf \"%s\\t%s\\n\", \$1,\$2;}' | perl -ne 's/.mat//; print;' | sort -u > $opt_b.ctrl.fa.hit";
	print `$cmd` if(! -e "$opt_b.ctrl.fa.hit"); 
	print STDERR "pwmscan done\n";
	$cmd = "rm -f $opt_b.ctrl.fa.M*.gff";
	print `$cmd`; 
    }
    
    
#prepare data for regression
    
#TFBS  data
    if(0) {
	print `cat $opt_b.fa.hit $opt_b.ctrl.fa.hit > pos_and_ctrl.hit`;
	#exit;
    }
    
#Chip binding data
    if(0) {
	$cmd = "awk '(NF > 1){printf \"%s\\t%s\\n\",\$1,\$2;}(NF == 1){printf \"%s\\t1\\n\",\$1;}' $opt_b.u > tmpD";
	print STDERR "$cmd\n";
	print `$cmd`;
	$cmd = "awk '{printf \"%s\\t0\\n\",\$1;}' $opt_b.ctrl.u >> tmpD";
	print STDERR "$cmd\n";
	print `$cmd`;
	$cmd = "awk '{printf \"%s\\n\",\$1;}'  pos_and_ctrl.tabAll | sort -u > tmpE";
	print STDERR "$cmd\n";
	print `$cmd`;
	$cmd = "join.pl tmpE 0 \"\" tmpD 0 ALL | sort -k1,1 -u | sort  -k1,1 > chip;";
	print STDERR "$cmd\n";
	print `$cmd`;
	#exit();
    }
}


#run Fisher test
if(1) {
    if(!defined $opt_p) {
	Fisher($CHIPFILE, $TFFILE);
    }
    else {
	FisherPair($CHIPFILE, $TFFILE);
    }
    #exit;
}


#process the data FIsher
if(1) {
    if(!defined $opt_p) {
	$cmd = "perl -ne 'chomp;s/\\\"//g;\@a=split;if(\$a[5] <= 0.05){printf \"%s.mat\\t%.2f\\n\", \$a[0],-1*log(\$a[5]);}' $CHIPFILE.Fisher > tmp";
	print `$cmd`;
	$cmd = "join.pl tmp 0 ALL /cagr/data/TRANSFAC/v10.2/matrices.vert.consensus 0 2 | sort -k2nr,2nr > $CHIPFILE.Fisher.05.name";
	print `$cmd`;
	$cmd = "representativeTF.pl -m 0 -c 0 -t 2 $CHIPFILE.Fisher.05.name | grep -v DELT > $CHIPFILE.Fisher.05.name.rep";
	print `$cmd`;
    }
    else {
	$cmd = "perl -ne 'chomp;s/\\\"//g;\@a=split;if(\$a[6] <= 0.05){printf \"%s.mat\\t%s.mat\\t%.2f\\t%s\\t%s\\n\", \$a[0],\$a[1],-1*log(\$a[6]),\$a[7],\$a[8];}' $CHIPFILE.FisherPair > tmp";
	print `$cmd`;
	$cmd = "sort -k3nr,3nr tmp > $CHIPFILE.FisherPair.05.name";
	print `$cmd`;
	$cmd = "representativeTFPair.pl -t 2 $CHIPFILE.FisherPair.05.name > $CHIPFILE.FisherPair.05.name.rep";
	print `$cmd`;
    }
}


#####################################################################################

sub Fisher {
    my($bindfile, $tffile) = @_;
    my($gene, $bind, $i, $tf, $PVAL, $av1,$sd1,$av2,$sd2);
    my($TotalFG) = 0;
    my($TotalBG) = 0;
    my(%CHIP, %HIT);

    open(G,">$bindfile.Fisher") or die "can't open $bindfile.Fisher\n";
    open(F,"<$bindfile") or die "can't open $bindfile\n";
    while(<F>) {
	chomp;
	($gene, $bind) = split;
	$CHIP{$gene} = $bind;
	if($bind == 1) { $TotalFG++; }
	else { $TotalBG++; }
    }
    close(F);
    open(F,"<$tffile") or die "can't open $tffile\n";
    while(<F>) {
	chomp;
	($gene, $tf) = split;
	$HIT{$tf}{$gene} = 1;
    }
    close(F);
	    
    foreach $tf (keys %HIT) {
	my($numHitsinFG) = 0;
	my($numHitsinBG) = 0;
	my($numnoHitsinFG) = 0;
	my($numnoHitsinBG) = 0;
	foreach $gene (keys %{$HIT{$tf}}) {
	    if($CHIP{$gene} == 1) { $numHitsinFG++; }
	    else  { $numHitsinBG++; }
	}
	$numnoHitsinFG = $TotalFG - $numHitsinFG;
	$numnoHitsinBG = $TotalBG - $numHitsinBG;
	my(@FG) = ($numHitsinFG, $numnoHitsinFG);
	my(@BG) = ($numHitsinBG, $numnoHitsinBG);
	
	#my(@M) = ($numHitsinFG, $numnoHitsinFG, $numHitsinBG, $numnoHitsinBG);
	#my $obj = R::call("matrix", \@M, 2, 2);

	$hgp = HyperGeometric2($numHitsinFG,$TotalFG+$TotalBG,$TotalFG,$numHitsinFG+$numHitsinBG);
	#my $w = &R::callWithNames("fisher.test",{ 'x' => $obj, 'alternative' => 'g'});
	#$PVAL = $w->getEl('p.value');
	printf  G "%s\t%d\t%d\t%d\t%d\t%.2e\n", $tf, $numHitsinFG, $numnoHitsinFG, $numHitsinBG, $numnoHitsinBG, $hgp;
	#exit;
    }
    close(G);
}
#####################################################################################

sub FisherPair {
    my($bindfile, $tffile) = @_;
    my($gene, $bind, $i, $tf, $PVAL, $av1,$sd1,$av2,$sd2);
    my($TotalFG) = 0;
    my($TotalBG) = 0;
    my(%CHIP, %HIT);
    my($pwm1, $pwm2, %PWMName, %PWMSim, %Filter);
    my($N) = 0;
    my(@a);

    open(F,"</cagr/projects/TFCluster/Work/TRANSFAC10.2/RE_TF2TF.name") or die "can' open /RE_TF2TF.name\n";
    while(<F>) {
	chomp;
	@a = split;
	$pwm1 = $a[0]; $pwm1 =~ s/.mat//;
	$PWMName{$pwm1} = $a[6];
	$pwm2 = $a[1]; $pwm2 =~ s/.mat//;
	$PWMName{$pwm2} = $a[7];
	$PWMSim{$pwm1}{$pwm2} = $a[3];
    }
    close(F);
    
    if(defined $opt_f) {
	open(F,"<$opt_f") or die "can't open $opt_f\n";
	while(<F>) {
	    chomp;
	    @a = split;
	    $tmp = $a[0];
	    $tmp =~ s/.mat//;
	    $Filter{$tmp} = 1;
	}
	close(F);
    }
	    
	    
 
    open(F,"<$bindfile") or die "can't open $bindfile\n";
    while(<F>) {
	chomp;
	($gene, $bind) = split;
	$CHIP{$gene} = $bind;
	if($bind == 1) { $TotalFG++; }
	else { $TotalBG++; }
    }
    close(F);
    open(F,"<$tffile") or die "can't open $tffile\n";
    while(<F>) {
	chomp;
	($gene, $tf) = split;
	$HIT{$tf}{$gene} = 1;
    }
    close(F);
   
    open(G,">$bindfile.FisherPair") or die "can't open $bindfile.FisherPair\n";	    
    foreach $tf1 (keys %HIT) {	    
	foreach $tf2 (keys %HIT) {
	    next if($tf2 le $tf1);
	    next if(defined $opt_f && $Filter{$tf1} != 1 &&  $Filter{$tf2} != 1);
	    next if($PWMSim{$tf1}{$tf2} >= 2 || $PWMSim{$tf2}{$tf1} >= 2);
	    if($N++ % 1000 == 0) { print STDERR "$N done\n"; }
	    
	    my($numHitsinFG) = 0;
	    my($numHitsinBG) = 0;
	    my($numnoHitsinFG) = 0;
	    my($numnoHitsinBG) = 0;
	    foreach $gene (keys %{$HIT{$tf1}}) {
		next if($HIT{$tf2}{$gene} != 1);
		if($CHIP{$gene} == 1) { $numHitsinFG++; }
		else  { $numHitsinBG++; }
	    }
	    $numnoHitsinFG = $TotalFG - $numHitsinFG;
	    $numnoHitsinBG = $TotalBG - $numHitsinBG;
	    #printf  STDERR "%s\t%s\t%d\t%d\t%d\t%d\t%s\t%s\n", $tf1, $tf2, $numHitsinFG, $numnoHitsinFG, $numHitsinBG, $numnoHitsinBG, $PWMName{$tf1}, $PWMName{$tf2};
	    next if($numHitsinFG/$TotalFG < 0.05);
	    $hgp = HyperGeometric2($numHitsinFG,$TotalFG+$TotalBG,$TotalFG,$numHitsinFG+$numHitsinBG);
	    if($hgp <= 0.05) {
		printf  G "%s\t%s\t%d\t%d\t%d\t%d\t%.2e\t%s\t%s\n", $tf1, $tf2, $numHitsinFG, $numnoHitsinFG, $numHitsinBG, $numnoHitsinBG, $hgp, $PWMName{$tf1}, $PWMName{$tf2};
	    }
	}
    }
    close(G);
}
