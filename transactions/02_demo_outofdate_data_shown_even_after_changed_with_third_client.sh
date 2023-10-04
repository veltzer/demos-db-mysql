#!/bin/bash -eu

dbname="demo"
tblname="foo"
destroy=1

echo "DROP DATABASE IF EXISTS ${dbname}" | mysql
echo "CREATE DATABASE ${dbname}" | mysql
echo "created a database called [${dbname}]"
echo "lets see if indeed there is one..."
echo "SHOW DATABASES" | mysql | grep ${dbname}
echo "creating a table for the demo..."
echo "CREATE TABLE ${tblname} (data int)" | mysql ${dbname}
echo "START TRANSACTION; INSERT INTO ${tblname} (data) values (15); COMMIT" | mysql ${dbname}
echo "finished creating table..."

rm -f /tmp/client1 /tmp/client2 /tmp/client3
mkfifo /tmp/client1 /tmp/client2 /tmp/client3
mysql ${dbname} < /tmp/client1 &
mysql ${dbname} < /tmp/client2 &
mysql ${dbname} < /tmp/client3 &
echo "before exec..."
exec 3> /tmp/client1
exec 4> /tmp/client2
exec 5> /tmp/client3

echo "======================="
echo "client1"
echo "START TRANSACTION;" > /tmp/client1
echo "SELECT * FROM ${tblname};" > /tmp/client1
sleep 2

echo "======================="
echo "client2"
echo "START TRANSACTION;" > /tmp/client2
echo "SELECT * FROM ${tblname};" > /tmp/client2
echo "UPDATE ${tblname} SET data=17 where data=15;" > /tmp/client2
echo "SELECT * FROM ${tblname};" > /tmp/client2
echo "COMMIT;" > /tmp/client2
sleep 2

echo "======================="
echo "client3"
echo "START TRANSACTION;" > /tmp/client3
echo "SELECT * FROM ${tblname};" > /tmp/client3
echo "COMMIT;" > /tmp/client3
sleep 2

echo "======================="
echo "client1"
echo "SELECT * FROM ${tblname};" > /tmp/client1
echo "COMMIT;" > /tmp/client1
sleep 2

# make eof appear to both clients by closing the relevant file
# descriptors at the shell end...
exec 3>&- # close file descriptor 3
exec 4>&- # close file descriptor 4
exec 5>&- # close file descriptor 5

# end of the script
if [ "${destroy}" = 1 ]
then
	echo "now dropping the database called [${dbname}]..."
	echo "DROP DATABASE ${dbname}" | mysql
	echo "now you should not see any output..."
	echo "SHOW DATABASES" | mysql | grep "${dbname}"
	echo "that's all..."
fi
