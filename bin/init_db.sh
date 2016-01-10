db_name=cup
echo "DB_CONN_URL=jdbc:mysql://localhost:3306/$db_name" > ../project/src/main/resources/rsconfig.properties
echo "USERNAME=cup" >> ../project/src/main/resources/rsconfig.properties
echo "PASSWORD=cup47702dingdongtu" >> ../project/src/main/resources/rsconfig.properties
echo "RS_HOME=/home/ubuntu/rs" >> ../project/src/main/resources/rsconfig.properties
echo "RS_TEMP_PATH=/home/ubuntu/rs/data/temp" >> ../project/src/main/resources/rsconfig.properties
echo "drop database $db_name; create database $db_name;" > create_db.sql

mysql --host=localhost --port=3306 --user=root --password=password --default-character-set=utf8 < create_db.sql
mysql --database=$db_name --host=localhost --port=3306 --user=root  --password=password --default-character-set=utf8 < cup_init.sql

echo "grant all privileges on *.* to cup@localhost identified by 'cup47702dingdongtu';" > alter_db.sql
mysql --host=localhost --port=3306 --user=root --password=password --default-character-set=utf8 < alter_db.sql
