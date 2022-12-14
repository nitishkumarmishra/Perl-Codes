#=================================================================
# program developed for computing dipeptide composition of
# n-terminal(nt) residues of proteins.
# Usage: program prot_sfata(single line fasta) outfile nt
# Usage: program prot_sfata(single line fasta) nt
#=================================================================


use Getopt::Std;
getopts('i:o:n:');
$file1=$opt_i;
$file2=$opt_o;
$nt=$opt_n;
$aa = "#ACDEFGHIKLMNPQRSTVWY";

if (($opt_i eq '')&&($opt_o eq '')||($opt_n eq ''))
{
    print "USAGE: nuc2nac -i <input file> -o <outfput file> -n <n-terminal position>\n";
    print "Input sequence in single fasta format\n";
    exit();
}
if (($opt_i ne '')&&($opt_o ne '')&&($opt_n ne ''))
{

open(FP1,"$file1");
open(FP2,">$file2");
print FP2 "# Dinucleic Composition of Protein \n";
Print FP2 "#AA , AC , AD , AE , AF , AG , AH , AI , AK , AL , AM , AN , AP , AQ , AR , AS , AT , AV , AW , AY , CA , CC , CD , CE , CF , CG , CH , CI , CK , CL , CM , CN , CP , CQ , CR , CS , CT , CV , CW , CY , DA , DC , DD , DE , DF , DG , DH , DI , DK , DL , DM , DN , DP , DQ , DR , DS , DT , DV , DW , DY , EA , EC , ED , EE , EF , EG , EH , EI , EK , EL , EM , EN , EP , EQ , ER , ES , ET , EV , EW , EY , FA , FC , FD , FE , FF , FG , FH , FI , FK , FL , FM , FN , FP , FQ , FR , FS , FT , FV , FW , FY , GA , GC , GD , GE , GF , GG , GH , GI , GK , GL , GM , GN , GP , GQ , GR , GS , GT , GV , GW , GY , HA , HC , HD , HE , HF , HG , HH , HI , HK , HL , HM , HN , HP , HQ , HR , HS , HT , HV , HW , HY , IA , IC , ID , IE , IF , IG , IH , II , IK , IL , IM , IN , IP , IQ , IR , IS , IT , IV , IW , IY , KA , KC , KD , KE , KF , KG , KH , KI , KK , KL , KM , KN , KP , KQ , KR , KS , KT , KV , KW , KY , LA , LC , LD , LE , LF , LG , LH , LI , LK , LL , LM , LN , LP , LQ , LR , LS , LT , LV , LW , LY , MA , MC , MD , ME , MF , MG , MH , MI , MK , ML , MM , MN , MP , MQ , MR , MS , MT , MV , MW , MY , NA , NC , ND , NE , NF , NG , NH , NI , NK , NL , NM , NN , NP , NQ , NR , NS , NT , NV , NW , NY , PA , PC , PD , PE , PF , PG , PH , PI , PK , PL , PM , PN , PP , PQ , PR , PS , PT , PV , PW , PY , QA , QC , QD , QE , QF , QG , QH , QI , QK , QL , QM , QN , QP , QQ , QR , QS , QT , QV , QW , QY , RA , RC , RD , RE , RF , RG , RH , RI , RK , RL , RM , RN , RP , RQ , RR , RS , RT , RV , RW , RY , SA , SC , SD , SE , SF , SG , SH , SI , SK , SL , SM , SN , SP , SQ , SR , SS , ST , SV , SW , SY , TA , TC , TD , TE , TF , TG , TH , TI , TK , TL , TM , TN , TP , TQ , TR , TS , TT , TV , TW , TY , VA , VC , VD , VE , VF , VG , VH , VI , VK , VL , VM , VN , VP , VQ , VR , VS , VT , VV , VW , VY , WA , WC , WD , WE , WF , WG , WH , WI , WK , WL , WM , WN , WP , WQ , WR , WS , WT , WV , WW , WY , YA , YC , YD , YE , YF , YG , YH , YI , YK , YL , YM , YN , YP , YQ , YR , YS , YT , YV , YW , YY\n";

while($t1=<FP1>){
    chomp($t1);
    uc($t1);
    $c1 = substr($t1,0,1);
    if($c1 =~ ">")
    {
	@ti = split("##",$t1);
	
	@ti1 = split("",$ti[1]);	    
	$le = length ($ti[1]);
	$len=$le-1;
	for($i1=1; $i1 <= 20; $i1++){
	    for($i2=1; $i2 <= 20; $i2++)
	    {
		$comp[$i1][$i2]=0;
		#print "[$i1][$i2]\n";
		
	    }
	   
	
	}
	for($j1 = 0; $j1 < $#ti1; $j1++){
	$c1 = $ti1[$j1];
	$in1 = index($aa,$c1);
	$c2 = $ti1[$j1+1];
	$in2 = index($aa,$c2);
	if($j1 < ($nt-1))
	{$comp[$in1][$in2]++;}
	
    }
	for($i1=1; $i1 <= 20; $i1++)
	{
	    for($i2=1; $i2 <= 20; $i2++)
	    {
		$perc=($comp[$i1][$i2])*100/($nt-1);
		printf(FP2 "%3d,",$perc);
	    }
	}
	print FP2 "\n";
    }
    
}
close FP1;
close FP2;

}
if (($opt_i ne '')&&($opt_o eq '')&&($opt_n ne ''))

{
    print "# Dinucleic Composition of Protein \n";

print "#AA , AC , AD , AE , AF , AG , AH , AI , AK , AL , AM , AN , AP , AQ , AR , AS , AT , AV , AW , AY , CA , CC , CD , CE , CF , CG , CH , CI , CK , CL , CM , CN , CP , CQ , CR , CS , CT , CV , CW , CY , DA , DC , DD , DE , DF , DG , DH , DI , DK , DL , DM , DN , DP , DQ , DR , DS , DT , DV , DW , DY , EA , EC , ED , EE , EF , EG , EH , EI , EK , EL , EM , EN , EP , EQ , ER , ES , ET , EV , EW , EY , FA , FC , FD , FE , FF , FG , FH , FI , FK , FL , FM , FN , FP , FQ , FR , FS , FT , FV , FW , FY , GA , GC , GD , GE , GF , GG , GH , GI , GK , GL , GM , GN , GP , GQ , GR , GS , GT , GV , GW , GY , HA , HC , HD , HE , HF , HG , HH , HI , HK , HL , HM , HN , HP , HQ , HR , HS , HT , HV , HW , HY , IA , IC , ID , IE , IF , IG , IH , II , IK , IL , IM , IN , IP , IQ , IR , IS , IT , IV , IW , IY , KA , KC , KD , KE , KF , KG , KH , KI , KK , KL , KM , KN , KP , KQ , KR , KS , KT , KV , KW , KY , LA , LC , LD , LE , LF , LG , LH , LI , LK , LL , LM , LN , LP , LQ , LR , LS , LT , LV , LW , LY , MA , MC , MD , ME , MF , MG , MH , MI , MK , ML , MM , MN , MP , MQ , MR , MS , MT , MV , MW , MY , NA , NC , ND , NE , NF , NG , NH , NI , NK , NL , NM , NN , NP , NQ , NR , NS , NT , NV , NW , NY , PA , PC , PD , PE , PF , PG , PH , PI , PK , PL , PM , PN , PP , PQ , PR , PS , PT , PV , PW , PY , QA , QC , QD , QE , QF , QG , QH , QI , QK , QL , QM , QN , QP , QQ , QR , QS , QT , QV , QW , QY , RA , RC , RD , RE , RF , RG , RH , RI , RK , RL , RM , RN , RP , RQ , RR , RS , RT , RV , RW , RY , SA , SC , SD , SE , SF , SG , SH , SI , SK , SL , SM , SN , SP , SQ , SR , SS , ST , SV , SW , SY , TA , TC , TD , TE , TF , TG , TH , TI , TK , TL , TM , TN , TP , TQ , TR , TS , TT , TV , TW , TY , VA , VC , VD , VE , VF , VG , VH , VI , VK , VL , VM , VN , VP , VQ , VR , VS , VT , VV , VW , VY , WA , WC , WD , WE , WF , WG , WH , WI , WK , WL , WM , WN , WP , WQ , WR , WS , WT , WV , WW , WY , YA , YC , YD , YE , YF , YG , YH , YI , YK , YL , YM , YN , YP , YQ , YR , YS , YT , YV , YW , YY\n";


open(FP1,"$file1");
while($t1=<FP1>){
    chomp($t1);
    uc($t1);

 $c1 = substr($t1,0,1);
    if($c1 =~ ">")
{
    @ti = split("##",$t1);
    
    @ti1 = split("",$ti[1]);	    
    $le = length ($ti[1]);
    $len=$le-1;
    for($i1=1; $i1 <= 20; $i1++)
    {
	for($i2=1; $i2 <= 20; $i2++)
	{
	    $comp[$i1][$i2]=0;
	}
    }
    for($j1 = 0; $j1 < $#ti1; $j1++){
	$c1 = $ti1[$j1];
	$in1 = index($aa,$c1);
	$c2 = $ti1[$j1+1];
	$in2 = index($aa,$c2);
	if($j1 < ($nt-1))
	{$comp[$in1][$in2]++;}
    }
    for($i1=1; $i1 <= 20; $i1++)
    {
	for($i2=1; $i2 <= 20; $i2++)
	{
	    $perc=($comp[$i1][$i2])*100/($nt-1);
	    printf("%3d,",$perc);
	    }
    }
    print "\n";
}

}
close FP1;

}


# Developed by G P S Raghava on 10 Jan 2009
