#!/usr/bin/env mysql_run.sh
SET GLOBAL general_log = ON;
SET GLOBAL general_log_file="/var/log/mysql/mysql.log";
SET GLOBAL log_output = "FILE";
