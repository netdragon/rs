@echo off
call set_env.bat
cd "%RS_HOME%\system\apache-tomcat-6.0.26\bin\"
call catalina.bat stop

cd "%RS_HOME%\bin"
