#!/bin/bash

DB=$1
SCHEMA=$2
OPTIONS=$3

echo '++++++++++++++++++ SOCRBASE TABLE CREATED'
pgdbf _data/SOCRBASE.DBF | iconv -f cp866 -t utf-8 | PGOPTIONS=--search_path=$SCHEMA psql $DB $OPTIONS