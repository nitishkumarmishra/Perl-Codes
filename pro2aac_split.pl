#=================================================================
# program developed for computing split amino acid composition of proteins.
# It divide protein in given parts and compute amino acid composition of each part. 
# Usage: program prot_sfata(single line fasta) outfile np(number between 2 to 5)
# Usage: program prot_sfata(single line fasta) np(number between 2 to 5)
#=================================================================
use Getopt::Std;
getopts('i:o:n:');
$file1=$opt_i;
$file2=$opt_o;
$np=$opt_n;
$aa = "#ACDEFGHIKLMNPQRSTVWY";
if(($opt_i eq '')||($opt_n eq ''))
{
    print "-i\tSequence in S-FASTA format\n";
    print "-o\tOutput file name\n";
    print "-n\tNumber of split part\n";
    print "Usage: pro2aac_split sfasta_file output_file np(number between 2 to 5)\n";
    print "Usage for displaying on screen: pro2aac_split sfasta_file np(number between 2 to 5) \n";
    exit();
}
    if(($opt_i ne '')&& ($opt_o ne '') && ($np <= 5)){
open(FP1,"$file1");
open(FP2,">$file2");
print FP2 "# Amino Acid Composition of $np equal parts of proteins \n";
print FP2 "# A , C , D , E , F , G , H , I , K , L , M , N , P , Q , R , S , T , V , W , Y\n";
while($t1=<FP1>){
    chomp($t1);
 $c1 = substr($t1,0,1);
    if($c1 =~ ">")
{
    @ti = split("##",$t1);
    @ti1 = split("",$ti[1]);	    
    $len = length ($ti[1]);
    $np1 = int($len/$np);
    if(($len-$np1*$np) > 0) {$np1++;} 
    for($i1=1; $i1 <= 20; $i1++){for($i2=0; $i2 < $np; $i2++){$comp[$i2][$i1]=0;}}
    $count = 0;
    foreach(@ti1){
	$c2 = $_;
	$in1 = index($aa,$c2);
	$np2 = int($count/$np1);
	$comp[$np2][$in1]++;
	$count++;
    }
    for($i2=0; $i2 < $np; $i2++){
    for($i1=1; $i1 <= 20; $i1++){
	$perc=($comp[$i2][$i1]*100)/$np1;
	if($i1 <= 19)
		{
		    printf(FP2 "%5.3f,",$perc);
		}
		else
		{
		    printf(FP2 "%5.3f ",$perc);
		}
    }
    if($i2 < $np-1){
	print FP2 ",";
    }
}
    print FP2 "\n";
}

}
close FP1;
close FP2;
exit();
}if(($opt_i ne '')&& ($opt_o eq '') && ($np <= 5)){
print "# Amino Acid Composition of $np equal parts of proteins \n";
print "# A , C , D , E , F , G , H , I , K , L , M , N , P , Q , R , S , T , V , W , Y\n";
open(FP1,"$file1");
while($t1=<FP1>){
    chomp($t1);
 $c1 = substr($t1,0,1);
    if($c1 =~ ">")
{
    @ti = split("##",$t1);
    @ti1 = split("",$ti[1]);	    
    $len = length ($ti[1]);
    $np1 = int($len/$np);
    if(($len-$np1*$np) > 0) {$np1++;} 
    for($i1=1; $i1 <= 20; $i1++){for($i2=0; $i2 < $np; $i2++){$comp[$i2][$i1]=0;}}
    $count = 0;
    foreach(@ti1){
	$c2 = $_;
	$in1 = index($aa,$c2);
	$np2 = int($count/$np1);
	$comp[$np2][$in1]++;
	$count++;
    }
    for($i2=0; $i2 < $np; $i2++){
    for($i1=1; $i1 <= 20; $i1++){
	$perc=($comp[$i2][$i1]*100)/$np1;
	if($i1 <= 19)
	{
	    printf( "%5.3f,",$perc);
	}
	else
	{
	    printf ("%5.3f",$perc);
	}
    }
    if($i2 < $np-1){
	print  ",";
    }
    
}

    print "\n";

}

}
close FP1;
exit();
}

# Developed by G P S Raghava on 10 Jan 2009
