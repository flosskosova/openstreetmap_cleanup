wget -m http://download.geofabrik.de/europe/kosovo-updates/ -l3 --no-parent
find -name \*.gz -exec zgrep user {} \; | cut -d= -f6 | sort | uniq -c | sort -n  > UserReport.md
find -name \*.gz -exec zcat {} \; | perl findnames2.pl > NameReport2.md
#find -name \*.gz -exec zcat {} \; | perl find_in_serbia.pl > InSerbia.md
bzcat kosovo-latest.osm.bz2 | perl find_in_serbia.pl > NamesInSerbia.md
