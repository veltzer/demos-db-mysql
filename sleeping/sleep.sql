#!/usr/bin/env mysql_run.sh
SELECT 'Before Sleep' AS message;
SELECT SLEEP(5);
SELECT 'After Sleep' AS message;
