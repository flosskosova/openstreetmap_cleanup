use strict;
use warnings;
use Data::Dumper;

sub process {
    my $d="";
    my $url="";
    my $type;
    my $id;
    my $line=0;
    #print @ARGV;
    my %seen;
    my $filename = $ARGV[0];
    while (<>) {
	$line++;
	chomp;
	if (/^\t<(way|node|relation) id=\"(\d+)\"/)
	{
	    $type = $1;
	    $id = $2;
	}   
	
	if (/k=\"(name.*)\"\s+v=\"(.+)\"/) {
	    my $key =$1;
	    my $value =$2;

	    if (! exists($seen{$value})){
		
		print "#: osm type:$type id:$id key:$key $filename:$line\n";
		print "msgid \"$value\"\n";
		print "msgstr \"\"\n";
	    }
	    $seen{$value}++;
	}	
	
    }    
}


process();
