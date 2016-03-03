use strict;
use warnings;
use Data::Dumper;

# temp variables
my %seen;

sub process {
    my $d="";
    my $url="";
    while (<>) {
	chomp;
	if (/^\t<(way|node|relation) id=\"(\d+)\"/)
	{
	    $url = "https://www.openstreetmap.org/$1/$2";
	    $d=$_;
	}   
	
	if (/k=\"is_in(:country)\"\s+v=\"(Serbia|Србија|Srbija)\"/) {
	    $seen{$url}=$url;	    
	}	
	
    }    
}

sub report {
    print "<html>";
    foreach my $name2 (sort keys %seen)     {
	my $u = $seen{$name2};
	print "<p>$name2</p>\n";
    }
        print "</html>";

}


process();
report();
