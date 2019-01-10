
DB=$1
SCHEMA=$2
OPTIONS=$3

echo '_______________________НАЧИНАЮ ИМПОРТ ИЗ ФАЙЛОВ__________________'
bash import.sh $DB $SCHEMA $OPTIONS

echo '_______________________НАЧИНАЮ ОБНОВЛЕНИЕ СХЕМЫ__________________'
PGOPTIONS=--search_path=$SCHEMA psql -f update_schema.sql -d $DB $OPTIONS

echo '_______________________НАЧИНАЮ СОЗДАНИЕ ИНДЕКСОВ_________________'
PGOPTIONS=--search_path=$SCHEMA psql -f indexes.sql -d $DB $OPTIONS

echo '_______________________ _________ГОТОВО________ _________________'
