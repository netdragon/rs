@echo off
set db_name=cup_%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%%time:~9,2%
echo DB_CONN_URL=jdbc:mysql://localhost:3306/%db_name%> ..\system\apache-tomcat-6.0.26\RS\WEB-INF\classes\rsconfig.properties
echo USERNAME=cup>> ..\system\apache-tomcat-6.0.26\RS\WEB-INF\classes\rsconfig.properties
echo PASSWORD=dingdongtu>> ..\system\apache-tomcat-6.0.26\RS\WEB-INF\classes\rsconfig.properties
echo RS_HOME=d:\\rs>> ..\system\apache-tomcat-6.0.26\RS\WEB-INF\classes\rsconfig.properties
echo RS_TEMP_PATH=d:\\rs\\data\\temp>> ..\system\apache-tomcat-6.0.26\RS\WEB-INF\classes\rsconfig.properties
echo create database %db_name%; > create_db.sql

..\system\mysql\bin\mysql --host=localhost --port=3306 --user=root --password=dingdongtu --default-character-set=utf8 < create_db.sql
..\system\mysql\bin\mysql --database=%db_name% --host=localhost --port=3306 --user=root  --password=dingdongtu --default-character-set=utf8 < cup_init.sql

echo grant all privileges on *.* to cup@localhost identified by 'dingdongtu'; > alter_db.sql
..\system\mysql\bin\mysql --host=localhost --port=3306 --user=root --password=dingdongtu --default-character-set=utf8 < alter_db.sql

@call set_env.bat
@cd "%RS_HOME%\system\apache-tomcat-6.0.26\bin\"
@call catalina.bat stop

@ping 1.1.1.1 -n 1 -w 5000 > nul

@set CLASSPATH=%CLASSPATH%:%JAVA_HOME%/lib/tools.jar:%JAVA_HOME%/lib/dt.jar:.
@set PATH=%path%;%JAVA_HOME%/bin
@set JAVA_OPTS=-Xms512m -Xmx1024m
@set CATALINA_OPTS=-Xms512m -Xmx1024m
@call catalina.bat start
@cd "%RS_HOME%\bin"
