
rm kosovo-latest.osm.bz2
wget http://download.geofabrik.de/europe/kosovo-latest.osm.bz2
bzcat kosovo-latest.osm.bz2  | perl findnames.pl   > report.md
bzcat kosovo-latest.osm.bz2  | perl find_in_serbia.pl > in_serbia.md


bash -x getchanges.sh
