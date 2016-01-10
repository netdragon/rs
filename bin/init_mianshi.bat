set db_name=mianshi
echo create database %db_name%; > create_mianshi_db.sql
echo grant all privileges on *.* to cup@localhost identified by 'cup'; >> create_mianshi_db.sql
..\system\mysql\bin\mysql --host=localhost --port=3306 --user=root  --default-character-set=utf8 < create_mianshi_db.sql
..\system\mysql\bin\mysql --database=%db_name% --host=localhost --port=3306 --user=root  --default-character-set=utf8 < d:\mianshi.sql
