#!/usr/bin/env mysql_run.sh
SELECT @@general_log;
SELECT @@log_output;
SHOW VARIABLES LIKE 'general%';
