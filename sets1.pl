#!/usr/bin/perl

for($c=1;$c<6;$c++)
{
    for($d=1;$d<6;$d++)
    {
	if($d==$c)
	{
	    system "cat testset$d>test_$c";
	}
	else
	{
	    system "cat testset$d>>train_$c";
	}
    }
}

#system "rm set_*";
