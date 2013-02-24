set db_name=cup
echo DB_CONN_URL=jdbc:mysql://localhost:3306/%db_name%> ..\src\webapp\java\rsconfig.properties
echo USERNAME=cup>> ..\src\webapp\java\rsconfig.properties
echo PASSWORD=cup47702dingdongtu >> ..\src\webapp\java\rsconfig.properties
echo RS_HOME=d:\\rs>> ..\src\webapp\java\rsconfig.properties
echo RS_TEMP_PATH=d:\\rs\\data\\temp>> ..\src\webapp\java\rsconfig.properties
echo drop database %db_name%;create database %db_name%; > create_db.sql

..\system\mysql\bin\mysql --host=localhost --port=3306 --user=root --password=dingdongtu --default-character-set=utf8 < create_db.sql
..\system\mysql\bin\mysql --database=%db_name% --host=localhost --port=3306 --user=root  --password=dingdongtu --default-character-set=utf8 < cup_init.sql

echo grant all privileges on *.* to cup@localhost identified by 'cup47702dingdongtu'; > alter_db.sql
..\system\mysql\bin\mysql --host=localhost --port=3306 --user=root --password=dingdongtu --default-character-set=utf8 < alter_db.sql