#!/usr/bin/perl
$ct=0;
$vt=0;
open(RK,">Chloro_svmpat");

for ($a=1;$a<85;$a++){
    $ct=0;
    $vt=0;   
    open(FL,"chloro$a.mtx")or die "uhihiu";
    
    $max=-10000000;
    $min=10000000;
    while($line=<FL>){   
	chomp($line);
	$ct++;
	undef @num;
	if($ct==2){
	    $seq=$line;
	}
	
	$length=length($seq);
	@AM=split("",$seq);
	
	for($j1=0;$j1<$length;$j1++){
	    $amino[$j1]=$AM[$j1];
	}
	if($ct>14){
	    $vt++;
	    @num=split(/ +/,$line);
	    $new=@num;
	    
	    splice(@num,2,1);
	    splice(@num,20,1);
	    splice(@num,21,3);
	    
	    $nlen=@num;
	    #print "@num\n";
	    $j3=0;
	    #print "$vt: ";
	    for($j2=1;$j2<$nlen;$j2++){
		
		$kem=$num[$j2];
		$pnum[$vt][$j2]=$kem;
		$j3++;
		
		if($max< $pnum[$vt][$j2])
		{
		    $max=$pnum[$vt][$j2];
		}
		
		if($min>$pnum[$vt][$j2]){
		    
		    $min=$pnum[$vt][$j2];
		}
		#  print " [$vt][$j2]: $pnum[$vt][$j2] "; # $R=<STDIN>;
	    }
#	print "\n";	
	}
	
    }
    close FL;
    
    $factor=$max-$min;
    
    for($nm=1;$nm<$vt;$nm++){
	for($nj=1;$nj<$nlen;$nj++){
	    $nnum[$nm][$nj]= ($pnum[$nm][$nj] - $min)/$factor;
	    #print "$nnum[$nm][$nj]\t";
	}
	#print "\n";
	#$R=<STDIN>;
    }
#print "max= $max; min=$min factor=$factor\n"; 
#print " [$vt][$j2]============= $pnum[750][21] ";#$R=<STDIN>;
#print "## $pnum[26][1]  $pnum[26][2] $pnum[26][3] $pnum[26][4] $pnum[26][5]\n";
#print "## $nnum[26][1]  $nnum[26][2] $nnum[26][3] $nnum[26][4] $nnum[26][5]\n";
#print "length=$length\n";
#print "vt=$vt\n";
    
    @AA=qw(A C D E F G H I K L M N P Q R S T V W Y);
    
    
    for($k=0;$k<@AA;$k++){
#print "FOR $AA[$k]\n\n";    
	for($i=1;$i<$vt;$i++){
	    
	    if("$AA[$k]" eq "$AM[$i]"){
		#print "POSITION= $i\n";
		# print "**  $k= $AA[$k]:$i  $AM[$i] ";# $R=<STDIN>; 
		
		for($j=1;$j<$nlen;$j++){
		    
		    for($Z=1;$Z<$vt;$Z++){
			
			if($Z==$i){	
			    #	print "z=$Z: i=$i\n";
			    #	print "k:j [$k][$j] /t Z:j [$Z][$j]: * $pnum[$Z][$j]\n";
			    #	$R=<STDIN>;
			    $snum[$k][$j] +=$nnum[$Z+1][$j];
			    #print "VALUE=$nnum[$Z][$j]\tSUM=$snum[$k][$j]\n";
			}
		    }
		    
		    
		}
	    }
	}
#$R=<STDIN>;
    }
    print RK "Chloro=";
    
    for($k1=0;$k1<@AA;$k1++){
#	print "$AA[$k1]:";
	
	for($j5=1;$j5<$nlen;$j5++){
	    
	    $kt++;
	    $fnum[$k1][$j5]=$snum[$k1][$j5]/$length;
	    #$fnum[$k1][$j5]=$snum[$k1][$j5];
	    
	    printf RK ("$kt:%-6.4f ",$fnum[$k1][$j5]);
	    $fnum[$k1][$j5]=0;
	    $nnum[$k1][$j5]=0;
	    
	    # print "$kt:$fnum[$k1][$j5] ";
	}
#print "\n";
    }
    print RK "\n";
    undef @fnum;
    undef @snum;
    undef @nnum;
    undef @nlen;
    
    $length=0;
    $kt=0;
#print "$seq\n";
    close FL;
}
close RK;
