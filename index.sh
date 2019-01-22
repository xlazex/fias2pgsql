#!/bin/bash

DB=$1
SCHEMA=$2
OPTIONS=$3
echo "_______________________HELLO; DB = '$DB'; SCHEMA = '$SCHEMA'"

echo '_______________________НАЧИНАЮ ИМПОРТ SOCRBASE____________________'
bash import_socrbase.sh $DB $SCHEMA "$OPTIONS"

echo '_______________________НАЧИНАЮ ИМПОРТ HOUSE______________________'
bash import_house.sh $DB $SCHEMA "$OPTIONS"

echo '_______________________НАЧИНАЮ ИМПОРТ ADDROBJ_____________________'
bash import_addrobj.sh $DB $SCHEMA "$OPTIONS"

echo '_______________________НАЧИНАЮ ОБНОВЛЕНИЕ СХЕМЫ__________________'
PGOPTIONS=--search_path=$SCHEMA psql -f update_schema.sql -d $DB $OPTIONS

echo '_______________________НАЧИНАЮ СОЗДАНИЕ ИНДЕКСОВ_________________'
PGOPTIONS=--search_path=$SCHEMA psql -f indexes.sql -d $DB $OPTIONS

echo '_______________________ _________ГОТОВО________ _________________'
