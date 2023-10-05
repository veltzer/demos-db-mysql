#!/bin/bash -eu

dbname="demodb"
tblname="demotable"
destroy=1

echo "DROP DATABASE IF EXISTS ${dbname}" | mysql
echo "CREATE DATABASE ${dbname}" | mysql
echo "CREATE TABLE ${tblname} (num int(11))" | mysql "${dbname}"
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
