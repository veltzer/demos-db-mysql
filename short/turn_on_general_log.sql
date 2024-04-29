#!/usr/bin/env mysql_run.sh
SET GLOBAL general_log = on;
SET GLOBAL general_log_file="/var/log/mysql/mysql.log";
SET GLOBAL log_output = "file";
