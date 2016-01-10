@echo off
call set_env.bat

cd "%RS_HOME%\system\apache-tomcat-6.0.26\bin\"
call catalina.bat stop
set CLASSPATH=%CLASSPATH%:%JAVA_HOME%\lib\tools.jar:%JAVA_HOME%\lib\dt.jar:.
set PATH=%path%;%JAVA_HOME%\bin
cd %RS_HOME%\src\project\
call %RS_HOME%\system\apache-maven-3.2.5\bin/mvn.bat clean install
copy target\rs.war "%RS_HOME%\system\apache-tomcat-6.0.26\"
cd "%RS_HOME%\system\apache-tomcat-6.0.26\"
call "%RS_HOME%\system\WinRAR\WinRAR.exe e rs.war "%RS_HOME%\system\apache-tomcat-6.0.26\rs"
set JAVA_OPTS=-Xms512m -Xmx1024m
set CATALINA_OPTS=-Xms512m -Xmx1024m
cd "%RS_HOME%\system\apache-tomcat-6.0.26\bin\"
call catalina.bat start

cd "%RS_HOME%\src\bin"