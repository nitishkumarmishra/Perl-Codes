#!/usr/bin/perl
#@gg=qw(0.0001 0.0005 0.0009 0.001 0.005 0.009 0.01 0.05 0.09 0.1 0.5 0.9 1 10);
#@cc=qw(0.05 0.5 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20);
@name=qw(Gasteiger_Multi_Mix);
for($s1=0;$s1<=$#name;$s1++)
{
    open(FILE,"$name[$s1]") or die "$!";chomp($name[$s1]);
    @patterns=<FILE>;
    @gg=qw(0.0001 0.00001 0.000001 0.001 0.1 0.005);
    @cc=qw(1 2 3);
    @jj=qw(1 2 3 5);
    
    for($yy=0;$yy<@gg;$yy++)
    {
    
	for($yy1=0;$yy1<@cc;$yy1++)
	{
	    for($yy2=0;$yy2<@jj;$yy2++)
	    {
		@obs="";
		@ori="";
		$u=0;
		system "rm Tempo_* TEMPU";
		open(MAD,">>RESULT_SVM");
		print MAD"Optimising value of c=$gg[$yy]----d=$cc[$yy1]-----j=$jj[$yy2]----\n";
		print MAD"class\tTP\tTN\tFP\tFN\tSEN\tSPEC\tACC\tMCC\n";
		close MAD;
		for($numb=1;$numb<6;$numb++)
		{
		    system "rm *.pat";
		    
		    for($a=0;$a<=$#patterns;$a++)
		    {
			open(TRAIN,">train.pat") or die "$!";
			for($b=0;$b<=$#patterns;$b++)
			{
			    chomp($patterns[$b]);
			    if($a == $b)
			    {
				open(TEST,">test.pat") or die "$!";
				print TEST "$patterns[$b]\n";
				# print "Test**$a **:$patterns[$b]\n";
				close TEST;
				
			    }
			    else
			    {
				
				print TRAIN "$patterns[$b]\n";
#		    print "Train**: $patterns[$b]\n";
			    }
			}
			close TRAIN;
			system "./class_pattern.pl test.pat $numb testset.pat";
			system "./class_pattern.pl train.pat $numb training.pat";
			
			# print "\n\n\n\n************DOING $num**Protein=$numb******trainingset_$num*******\n\n\n";
			system "svm_learn -z c -t 1 -c $gg[$yy] -d $cc[$yy1] -j $jj[$yy2] training.pat model";
			
			system "svm_classify testset.pat model Tempo";
			system "cat Tempo >> Tempo_$numb";
			
			system "rm model Tempo training.pat testset.pat test.pat train.pat";
		    }
		}
		
###############Analysis Part############################
		
		system "./create_array.pl";
		
		
		system "rm predicted original";
	
		open(MAF1,"TEMPU");
		while($lik1=<MAF1>)
		{
		    chomp($lik1);
		    @aa=split(/:/,$lik1);
		    @ab=sort {$b <=> $a} @aa;
		    for($c=0;$c<@aa;$c++)
		    {
			if($ab[0]==$aa[$c])
		    {
			$f=$c+1;
		    }
		    }
		    $obs[$u]=$f;
		    $u++;
		}
		close MAF1;
		
		for($z=0;$z<@obs;$z++)
		{
		    open(MEK,">>predicted");
		    print MEK"$obs[$z]\n";
		    close MEK;
		}       
		
		$g=0;
		$k=0;
		
		open(MAS,"Actual");
		while($lik2=<MAS>)
		{
		    chomp($lik2);
		    $ori[$g]=$lik2;
		    $g++;
		    
		}
		close MAS;
		
	    
		
		for($x=0;$x<@ori;$x++)
		{
		    open(MES,">>original");
		    print MES"$ori[$x]\n";
		    close MES;
		}	
	    
		
		for($an=1;$an<6;$an++)
		{
		    $tn=$tp=$fn=$fp=0;
		    $tob=$nnum=$dnum=$ton=$np=$pp=0;
		    $g=0;
		    
		    for($fi=0;$fi<@ori;$fi++)
		    {
			if(($ori[$fi]==$an) && ($obs[$fi]==$an))
			{
			    $tp++;
			}
			if(($ori[$fi]==$an) && ($obs[$fi]!=$an))
			{
			$fn++;
			}
			if(($ori[$fi]!=$an) && ($obs[$fi]==$an))
			{
			    $fp++;
			}
			if(($ori[$fi]!=$an) && ($obs[$fi]!=$an))
			{
			$tn++;
			}
		    }
		    
		    $tob=$tp+$fn;
		    $ton=$tn+$fp;
		    $tot_p=$tp+$tn;
		    $total=$tob+$ton;
		    $np=$tn+$fn;
		    $pp=$tp+$fp;
		    $sen=$spec=$acc=$mcc=0;
		    if($tob!=0)
		    {
			$sen=($tp/$tob)*100;
		    }
		    else
		    {
			$sen=0;
		    }
		    
		    if($ton!=0)
		    {
			$spec=($tn/$ton)*100;
		    }
		    
		    $acc=($tot_p/$total)*100;
		    $nnum=($tp*$tn)-($fp*$fn);
		    $dnum=sqrt($tob*$ton*$pp*$np);
		    if($dnum != 0)
		    {
			$cc=$nnum/$dnum;
		    }
		    else
		    {
			$cc=0;
		    }
		    $cc= sprintf "%6.2f", $cc;
		    $sen= sprintf "%6.2f", $sen;
		    $spec= sprintf "%6.2f", $spec;
		    $acc= sprintf "%6.2f", $acc;
		    open(MAJ,">>RESULT_SVM");
		    print MAJ"$an\t$tp\t$tn\t$fp\t$fn\t$sen\t$spec\t$acc\t$cc\n";
		    close MAJ;
		    
		}
	    }
	}
	
    }
}
