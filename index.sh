#!/bin/bash

DB=$1
SCHEMA=$2
OPTIONS=$3
echo "_______________________HELLO; DB = '$DB'; SCHEMA = '$SCHEMA'"

echo '_______________________IMPORTING SOCRBASE__________________'
bash import_socrbase.sh $DB $SCHEMA "$OPTIONS"

echo '_______________________IMPORTING HOUSE_____________________'
bash import_house.sh $DB $SCHEMA "$OPTIONS"

echo '_______________________IMPORTING ADDROBJ___________________'
bash import_addrobj.sh $DB $SCHEMA "$OPTIONS"

echo '_______________________UPDATING SCHEMA_____________________'
PGOPTIONS=--search_path=$SCHEMA psql -f update_schema.sql -d $DB $OPTIONS

echo '_______________________PREPARING INDEX CREATION____________'
PGOPTIONS=--search_path=$SCHEMA psql -f indexes__before.sql -d $DB $OPTIONS

echo '_______________________CREATING INDEXES: SOCRBASE__________'
PGOPTIONS=--search_path=$SCHEMA psql -f indexes_socrbase.sql -d $DB $OPTIONS

echo '_______________________CREATING INDEXES: HOUSES____________'
PGOPTIONS=--search_path=$SCHEMA psql -f indexes_houses.sql -d $DB $OPTIONS

echo '_______________________CREATING INDEXES ADDROBJ____________'
PGOPTIONS=--search_path=$SCHEMA psql -f indexes_addrobj.sql -d $DB $OPTIONS

echo '_______________________POST INDEX CREATION_________________'
PGOPTIONS=--search_path=$SCHEMA psql -f indexes__after.sql -d $DB $OPTIONS

echo '_______________________ _________DONE________ _____________'