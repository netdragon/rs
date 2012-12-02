@echo off
call set_env.bat
echo "Backup starting ... ..."

set temp_name=%1

set RAR_Dir="D:\tools\WinRAR\WinRAR.exe"

mkdir "%RS_HOME%\data\temp\%temp_name%"

echo "1 of 4. Backup database ... ..."

"%RS_HOME%\system\mysql\bin\mysqldump.exe" -uroot -pdingdongtu --all-databases --default-character-set=GB2312 -R --triggers > "%RS_HOME%\data\temp\%temp_name%\db.sql"

echo "2 of 4. Backup files ... ..."

xcopy /S "%RS_HOME%\data\appfiles\*" "%RS_HOME%\data\temp\%temp_name%\appfiles\"

echo "3 of 4. Backup log ... ..."

xcopy /S "%RS_HOME%\data\log\*" "%RS_HOME%\data\temp\%temp_name%\log\"

echo "4 of 4. Package backup data ... ..."

cd "%RS_HOME%\data\temp\"
"%RS_HOME%\GnuWin32\bin\tar.exe" cvf "%temp_name%.tar" "%temp_name%"



REM %RAR_Dir% a -df -IBCK "%temp_name%.rar" "%temp_name%"

cd "%RS_HOME%\bin"