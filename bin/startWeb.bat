@echo on
call set_env.bat

set CLASSPATH=%CLASSPATH%:%JAVA_HOME%/lib/tools.jar:%JAVA_HOME%/lib/dt.jar:.
set PATH=%path%;%JAVA_HOME%/bin
set JAVA_OPTS=-Xms512m -Xmx1024m
set CATALINA_OPTS=-Xms512m -Xmx1024m


cd "%RS_HOME%\system\apache-tomcat-6.0.26\bin\"
call catalina.bat start

cd "%RS_HOME%\bin"
