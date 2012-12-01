
@echo off
call set_env.bat

set CLASSPATH=%CLASSPATH%:%JAVA_HOME%/lib/tools.jar:%JAVA_HOME%/lib/dt.jar:.
set PATH=%path%;%JAVA_HOME%/bin
%RS_HOME%/system/apache-ant-1.8.1/bin/ant -f "%RS_HOME%\src\webapp\build.xml" compilejsp


