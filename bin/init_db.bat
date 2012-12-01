set db_name=cup_%date:~0,4%%date:~5,2%%date:~8,2%%time:~3,2%%time:~6,2%%time:~9,2%
echo DB_CONN_URL=jdbc:mysql://localhost:3306/%db_name%> ..\src\webapp\java\rsconfig.properties
echo USERNAME=cup>> ..\src\webapp\java\rsconfig.properties
echo PASSWORD=cup>> ..\src\webapp\java\rsconfig.properties
echo RS_HOME=d:\\rs>> ..\src\webapp\java\rsconfig.properties
echo RS_TEMP_PATH=d:\\rs\\data\\temp>> ..\src\webapp\java\rsconfig.properties
echo create database %db_name%; > create_db.sql

..\system\mysql\bin\mysql --host=localhost --port=3306 --user=root --password=dingdongtu --default-character-set=utf8 < create_db.sql
..\system\mysql\bin\mysql --database=%db_name% --host=localhost --port=3306 --user=root  --password=dingdongtu --default-character-set=utf8 < cup_init.sql

echo grant all privileges on *.* to cup@localhost identified by 'cup'; > alter_db.sql
..\system\mysql\bin\mysql --host=localhost --port=3306 --user=root --password=dingdongtu --default-character-set=utf8 < alter_db.sql