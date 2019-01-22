#!/bin/bash

DB=$1
SCHEMA=$2
OPTIONS=$3

echo '++++++++++++++++++ CHECKING HOUSES FILES'
if [ -f ./_data/HOUSE01.DBF ]; then
   mv ./_data/HOUSE01.DBF ./_data/HOUSES.DBF
   echo '++++++++++++++++++ HOUSES INITIAL FILE MOVED'
fi
pgdbf ./_data/HOUSES.DBF | iconv -f cp866 -t utf-8 | PGOPTIONS=--search_path=$SCHEMA psql $DB $OPTIONS
echo '++++++++++++++++++ INITIAL HOUSES TABLE CREATED'

for FULLPATH in `find ./_data/HOUSE* -type f`
do
    FILE="${FULLPATH##*/}"
    TABLE="${FILE%.*}"

    if [ $TABLE = 'HOUSES' ]; then
      echo 'SKIPPING HOUSES'
    else
      pgdbf $FULLPATH | iconv -f cp866 -t utf-8 | PGOPTIONS=--search_path=$SCHEMA psql $DB $OPTIONS
      echo "++++++++++++++++++ TABLE $TABLE CREATED"

      echo "++++++++++++++++++ INSERT $TABLE DATA INTO HOUSES"
      PGOPTIONS=--search_path=$SCHEMA psql -d $DB -c "INSERT INTO houses SELECT * FROM $TABLE; DROP TABLE $TABLE;" $OPTIONS
    fi

done
