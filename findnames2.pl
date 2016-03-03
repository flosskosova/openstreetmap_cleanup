use strict;
use warnings;
use Data::Dumper;

# temp variables
my %f;
my %seen;

sub process {
    my $d="";
    my $url="";
    my $mode ='';
    while (<>) {
	chomp;
	if (/<modify>/){$mode="m";}
	if (/<delete>/){$mode="d";}
	if (/<create>/){$mode="c";}


	if ($mode eq 'c' || $mode eq 'm') {
	    if (/\s+<(way|node|relation) id=\"(\d+)\"/)
	    {
		$url = "https://www.openstreetmap.org/$1/$2";
		$d=$_;
	    }   
	
	    if (/k=\"name\"\s+v=\"(.+)\"/) {
		my $name =$1;
		for my $c (split(//,$name)) {
		    my $a = ord($c);
		    if ($a > 127 ) {
			push @{$f{$a}},[$url, $d, $_];
			#print $c, ord($c);
			#print $d;
		    }
		}
		
	    }	
	}
    }    
}

sub report {
    print "<html>";
    foreach my $name2 (sort keys %seen)     {
	my $u = $seen{$name2};
	print "<p>$name2\t$u</p>\n";
    }
        print "</html>";

}

sub prepare {
    
    for my $x (keys %f)
    {
	my $v = $f{$x};
	for my $z (@{$v}) {
	    my $url = $z->[0];
	    my $node = $z->[1];
	    my $name = $z->[2];
	    
	    if ($name =~/v=\"(.+)\"/) {
		$name = $1;
	    }
		
	    $seen{$name}=$url;
	}
    };

};

process();
prepare();
report();
