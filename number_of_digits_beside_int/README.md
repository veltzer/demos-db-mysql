This example shows that this syntax:

CRATE TABLE FOO (
    price INT(11)
);

Means nothing to mysql.

Note that the "SHOW CREATE TABLE" shows that MySQL doesn't even remember the "11".

References:
- https://www.youtube.com/watch?v=xYl67AvQci8
