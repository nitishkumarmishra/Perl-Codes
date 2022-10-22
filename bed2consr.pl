#!/usr/bin/perl
### SYNPOSIS ###################
# Input : A bed file, Alignment directory
#Output : For each record, if exists in conservation file, extract the two sequences.


use lib "/fs/sh-code/SH/bin";
use PF_utils;
use Counter;

use Getopt::Std;
&getopts("i:c:o:");

$usage = "$0 [options]   
         -i BED file (the seq id should be same as the one used in alignment files)  
         -c directory containing axt files by chromosome                   
         -o outfile
";

die "$usage" if(! $opt_i || ! $opt_c || ! $opt_o);
$AxtDir = $opt_c;

open(G,">$opt_o") or die "can't open outfile $opt_o\n";
open(C,"ls $opt_c/chr*.axt |") or die "Can't ls $opt_c/chr*.axt\n";
while(<C>) {
    chomp;
    $_ =~ m/.*(chr.*)\.axt/;
    $chr = $1;
    print "processing $chr\n";
    $axtfile = "$opt_c/$chr.axt";
    process($chr, $opt_i, $axtfile);
}
close(C);
close(G);



############################################################################
###############################  SUBROUTINES ###############################
############################################################################
 
sub process {
    my($CHR, $bedfile, $axtfile) = @_;
    my($aid, $chr_h, $start_h, $end_h, $chr_m, $start_m, $end_m, $strand, $score);
    my($hdr, $i, $j, %Map_M, %huamnSeq, %mouseSeq, %huamnSeqAry, %mouseSeqAry, %Human_M, %Mouse);
    #my $counter = new Counter("Processing TF : Lines inputted ",10);
  
    my($mat, $dummy1, $beg, $end, $dummy2, $strand);
    my($len, $match_hm, $pid_hm, $found, $tfline);
    my(%SelectedAXT, %SelectedUTR, %Score);

    #sort AXT file alignment human coordinates and merge with altready sorted TFBS corrdinates
    open(AXT,"grep chr $axtfile | awk '{print \$3,\$4;}' | sort -k 1n,1n | ") or die "can't grep chr\n";
    #$cmd = "awk '(\$1 == $CHR){print \$2,\$3;}' $bedfile";
    open(F,"awk '(\$1 == \"$CHR\"){print \$2,\$3;}' $bedfile | sort -k 1n,1n | ") or die "getPID: can't open $bedfile\n";
    #READ FIRST TF RECORDS
    $_ = <AXT>; chomp;
    ($start_h, $end_h) = split;
    $_ = <F>; chomp;
    ($beg, $end) = split;

    while(1) {
	if($beg < $start_h) {
	    last if(eof(F));
	    $_ = <F>; chomp;
	    ($beg, $end) = split;
	}
	elsif($end <= $end_h) {    # found the axt record containing the bed record
	    #printf  "$CHR $start_h $end_h $beg $end\n";
	    $SelectedAXT{$CHR}{$start_h} = 1;
	    $SelectedUTR{$CHR}{$beg}{$end} = 1;
	    $AXTstart{$CHR}{$beg}{$end} = $start_h;
	    last if(eof(F));
	    $_ = <F>; chomp;
	    ($beg, $end) = split;	 
	}
	else { # $end > $end_h # $beg > $start_h
	    last if(eof(AXT));
	    $_ = <AXT>; chomp;
	    ($start_h, $end_h, $score) = split;
	}
    }
    close(F);
    close(AXT);
    print STDERR "AXT and TF Merged\n";

    #read and process select AXT entries
    
    open(AXT,"<$axtfile") or die "can't open axtfile - $axtfile\n";
    while(<AXT>) {
	if(/chr/) {
	    ($aid, $chr_h, $start_h, $end_h) = split;
	    if($SelectedAXT{$chr_h}{$start_h} == 1) {
		$_ = <AXT>; chomp; $humanSeq{$chr_h}{$start_h} = $_;
		$_ = <AXT>; chomp; $mouseSeq{$chr_h}{$start_h} = $_;
		$_ = <AXT>;

		$humanSeq{$chr_h}{$start_h} =~ tr/a-z/A-Z/;
		$mouseSeq{$chr_h}{$start_h} =~ tr/a-z/A-Z/;	
		
		@{$humanSeqAry{$chr_h}{$start_h}} = split '',  $humanSeq{$chr_h}{$start_h};
		@{$mouseSeqAry{$chr_h}{$start_h}} = split '',  $mouseSeq{$chr_h}{$start_h};

		$j=0;
		for ($i = 0; $i <= $#{$humanSeqAry{$chr_h}{$start_h}}; $i++) {
		    if($humanSeqAry{$chr_h}{$start_h}[$i] ne '-') {
			$Map_H{$chr_h}{$start_h+$j} = $i; # only to figure out existance of gaps
			if($humanSeqAry{$chr_h}{$start_h}[$i] eq $mouseSeqAry{$chr_h}{$start_h}[$i]) {
			    $Match{$chr_h}{$start_h+$j} = 1;
			}
			$j++;
		    }
		}
		$j=0;
		for ($i = 0; $i <= $#{$mouseSeqAry{$chr_h}{$start_h}}; $i++) {
		    if($mouseSeqAry{$chr_h}{$start_h}[$i] ne '-') {
			$Map_M{$chr_h}{$start_h+$j} = $i; # only to figure out existance of gaps
			$j++;
		    }
		}
	    }
	}
    }
    close(AXT);
    print STDERR "Selected AXT entries process\n";
    

    #process UTR file

    open(F,"<$bedfile") or die "can't open bedfile $bedfile\n";
    while(<F>) {
	chomp;
	($chr, $beg, $end, $id) = split;
	next if($chr ne $CHR);
	if($SelectedUTR{$chr}{$beg}{$end} == 1) {
	    $match_hm = 0;
	    for($i=$beg;$i<=$end;$i++) {
		if($Match{$chr_h}{$i} == 1) { $match_hm++; }
	    }
	    $pid_hm = ($match_hm >= 0) ? $match_hm/($end-$beg+1) : -1;
	    printf G "$_\t%.2f\n", $pid_hm;

	    $axtstart = $AXTstart{$chr}{$beg}{$end};
	    $offset_begin = $Map_H{$chr}{$beg};
	    $offset_end = $Map_H{$chr}{$end};
	    $len = $offset_end-$offset_begin+1;
	    #printf G "HUMAN %d %d %d %d %d %d %d\n",length($humanSeq{$chr}{$axtstart}), $axtstart, $beg, $offset_begin, $end, $offset_end,$len;
	    $human_utr = substr($humanSeq{$chr}{$axtstart},$offset_begin,$len);
	    $human_utr =~ s/-//g;
	    printf G "%s\n",$human_utr;
	    #$offset_begin = $Map_M{$chr}{$beg};
	    #$offset_end = $Map_M{$chr}{$end};
	    #$len = $offset_end-$offset_begin+1;
	    #printf G "MOUSE %d %d %d %d %d %d %d\n",length($mouseSeq{$chr}{$axtstart}), $axtstart, $beg, $offset_begin, $end, $offset_end,$len;
	    $mouse_utr = substr($mouseSeq{$chr}{$axtstart},$offset_begin,$len);
	    $mouse_utr =~ s/-//g;
	    printf G "%s\n",$mouse_utr;
	}
	else {
	    #printf G "$_\t0\n\n\n";
	}
    }
    close(F);
    #$counter->close( );
}



    

