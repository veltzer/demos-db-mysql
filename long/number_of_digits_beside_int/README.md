This example shows that this syntax:

CRATE TABLE FOO (
    price INT(11)
);

Means nothing to mysql.

Note that the "SHOW CREATE TABLE" shows that MySQL doesn't even remember the "11".
It does remember the size of varchar fields etc.

Conclusions:
In MySQL the size of the INT is not determined by the number in parenthesis.
It is determined by TINYINT, SMALLINT, INT, MEDIUMINT, BIGINT etc...

References:
- https://www.youtube.com/watch?v=xYl67AvQci8
- https://dev.mysql.com/doc/refman/8.0/en/integer-types.html
