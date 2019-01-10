#!/bin/bash

DB=$1
SCHEMA=$2
OPTIONS=$3
echo "++++++++++++++++++ HELLO; DB = '$DB'; SCHEMA = '$SCHEMA'"

echo '++++++++++++++++++ SOCRBASE TABLE CREATED'
pgdbf _data/SOCRBASE.DBF | iconv -f cp866 -t utf-8 | PGOPTIONS=--search_path=$SCHEMA psql $DB $OPTIONS

echo '++++++++++++++++++ CHECKING ADDROBJ FILES'
if [ -f ./_data/ADDROB01.DBF ]; then
   mv ./_data/ADDROB01.DBF ./_data/ADDROBJ.DBF
   echo '++++++++++++++++++ ADDROBJ INITIAL FILE MOVED'
fi
pgdbf ./_data/ADDROBJ.DBF | iconv -f cp866 -t utf-8 | PGOPTIONS=--search_path=$SCHEMA psql $DB $OPTIONS
echo '++++++++++++++++++ INITIAL ADDROBJ TABLE CREATED'

for FULLPATH in `find ./_data/ADDROB* -type f`
do
    FILE="${FULLPATH##*/}"
    TABLE="${FILE%.*}"

    if [ $TABLE = 'ADDROBJ' ]; then
      echo 'SKIPPING ADDROBJ'
    else
      pgdbf $FULLPATH | iconv -f cp866 -t utf-8 | PGOPTIONS=--search_path=$SCHEMA psql $DB $OPTIONS
      echo "++++++++++++++++++ TABLE $TABLE CREATED"

      echo "++++++++++++++++++ INSERT $TABLE DATA INTO ADDROBJ"
      PGOPTIONS=--search_path=$SCHEMA psql -d $DB -c "INSERT INTO addrobj SELECT * FROM $TABLE; DROP TABLE $TABLE;" $OPTIONS
    fi

done
