#!/usr/bin/env mysql_run.sh
SELECT @@general_log;
SHOW VARIABLES LIKE 'general%';
