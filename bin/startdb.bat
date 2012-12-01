@echo off
echo "MySQL is starting ... ... ... "
echo "MySQL is running, please execute shutdown.bat to stop it."
call "%RS_HOME%\system\mysql\bin\mysqld"
exit