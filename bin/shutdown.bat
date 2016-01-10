@echo off
call set_env.bat
"%RS_HOME%\system\mysql\bin\mysqladmin" -uroot -pdingdongtu  shutdown
cd "%RS_HOME%\system\apache-tomcat-6.0.26\bin\"
call catalina.bat stop

cd "%RS_HOME%\bin"
