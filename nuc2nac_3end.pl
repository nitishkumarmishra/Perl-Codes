#=================================================================
# program developed for computing nucleic acid composition of
# 3-end terminal of a DNA/RNA.  
# Usage: program nuc_sfata(single line fasta) outfile 3'-end-length
# Usage: program nuc_sfata(single line fasta)     3'-end-length
#=================================================================
use Getopt::Std;
getopts('i:o:c:');
$file1=$opt_i;
$file2=$opt_o;
$ct=$opt_c;
$aa = "#ACGT";

if (($opt_i eq '')&&($opt_o eq '')||($opt_c eq ''))
{
    print "USAGE: nuc2nac -i <input file> -o <outfput file> -c <3-end position>\n";
    print "Input sequence in single fasta format\n";
    exit();
}
if (($opt_i ne '')&&($opt_o ne '')&&($opt_c ne ''))
{

open(FP1,"$file1");
open(FP2,">$file2");
print FP2 "# Nucleic Acid Composition of $ct 3'-end of DNA/RNA \n";
print FP2 "# A , C , G, T/U, \n";
while($t1=<FP1>){
    chomp($t1);
    uc($t1);
 $c1 = substr($t1,0,1);
    if($c1 =~ ">")
{
    @ti = split("##",$t1);
    $ti[1]=~tr/ACGTU/ACGTT/;
    @ti1 = split("",$ti[1]);	    
    $len = length ($ti[1]);
    for($i1=1; $i1 <= 4; $i1++){$comp[$i1]=0;}
    $count = -1;
    foreach(@ti1){
	$c2 = $_;
	$in1 = index($aa,$c2);
	$count++;
	if($count >= ($len - $ct)){$comp[$in1]++;}
    }
    for($i1=1; $i1 <= 4; $i1++){
        $perc = ($comp[$i1]*100)/$ct;
        printf(FP2 "%5.2f,",$perc);
    }
    print FP2 "\n";
}

}
close FP1;
close FP2;

}
if (($opt_i ne '')&&($opt_o eq '')&&($opt_c ne ''))

{
print FP2 "# Nucleic Acid Composition of $ct 3'-end of DNA/RNA \n";
print "# A , C , G , T/U, \n";

open(FP1,"$file1");
while($t1=<FP1>){
    chomp($t1);
    uc($t1);

 $c1 = substr($t1,0,1);
    if($c1 =~ ">")
{
    @ti = split("##",$t1);
    $ti[1]=~tr/ACGTU/ACGTT/;
    @ti1 = split("",$ti[1]);	    
    $len = length ($ti[1]);
    for($i1=1; $i1 <= 4; $i1++){$comp[$i1]=0;}
    $count = -1 ;
    foreach(@ti1){
	$c2 = $_;
	$in1 = index($aa,$c2);
	$count++;
	if($count >= ($len - $ct)){$comp[$in1]++;}

    }
    for($i1=1; $i1 <= 4; $i1++){
        $perc = ($comp[$i1]*100)/$ct;
        printf("%5.2f,",$perc);
    }
    print "\n";
}

}
close FP1;

}


# Developed by G P S Raghava on 10 Jan 2009
