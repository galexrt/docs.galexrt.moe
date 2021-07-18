---
title: "init_file: Run SQL file on startup"
---

Add the following paramter to the `[mysqld]` or `[mariadb]` section of your `my.cnf` file (depending on the OS, at `/etc/mysql/my.cnf`, `/etc/my.cnf`, other path):

```ini
init_file = /etc/mysql/init.sql
```

The `/etc/mysql/init.sql` file can contain "any" SQL queries.

Example to enable / install the [MariaDB Query Response Time Plugin plugin](https://mariadb.com/kb/en/query-response-time-plugin/):

```sql
INSTALL SONAME 'query_response_time';

SET GLOBAL query_response_time_stats = 1;
SET GLOBAL query_response_time_flush = 1;
```

!!! note
    There are other ways to install the plugin, but to "initially" flush the plugin's data the `SET GLOBAL query_response_time_` can be useful to be run.

## References

* [https://mariadb.com/docs/reference/mdb/system-variables/init_file/](https://mariadb.com/docs/reference/mdb/system-variables/init_file/)
* [https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_init_file](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_init_file)
