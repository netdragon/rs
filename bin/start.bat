@echo off
call set_env.bat
start "MySQL Process is running" call startdb.bat
set CLASSPATH=%CLASSPATH%:%JAVA_HOME%/lib/tools.jar:%JAVA_HOME%/lib/dt.jar:.
set PATH=%path%;%JAVA_HOME%/bin
set JAVA_OPTS=-Xms512m -Xmx1024m
set CATALINA_OPTS=-Xms512m -Xmx1024m
rem call %RS_HOME%/system/apache-ant-1.8.1/bin/ant -f "%RS_HOME%\src\webapp\build.xml" deploy

cd "%RS_HOME%\system\apache-tomcat-6.0.26\bin\"
call catalina.bat start

cd "%RS_HOME%\bin"