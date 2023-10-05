#!/bin/bash -eu

dbname="demodb"
tblname="demotable"
destroy=1

echo "DROP DATABASE IF EXISTS ${dbname}" | mysql
echo "CREATE DATABASE ${dbname}" | mysql
echo "CREATE TABLE ${tblname} (email varchar(255), num int(11), znum int(11) zerofill)" | mysql "${dbname}"
echo "INSERT INTO ${tblname} VALUES('foo', 1, 1); COMMIT;" | mysql "${dbname}"
echo "SELECT * FROM ${tblname}" | mysql "${dbname}"
echo "SHOW CREATE TABLE ${tblname}" | mysql "${dbname}"

# end of the script
if [ "${destroy}" = 1 ]
then
	echo "now dropping the database called [${dbname}]..."
	echo "DROP DATABASE ${dbname}" | mysql
	echo "now you should not see any output..."
	echo "SHOW DATABASES" | mysql | grep "${dbname}" || true
	echo "that's all..."
fi
