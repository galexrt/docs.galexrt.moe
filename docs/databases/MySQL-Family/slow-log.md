---
title: "Slow Log"
---

## Enable Slow Query Log to File

```sql
SET @@global.slow_query_log_use_global_control = long_query_time,min_examined_row_limit,log_slow_verbosity;
SET GLOBAL slow_query_log_file = '/var/log/mysql/slow_log.log';
SET GLOBAL min_examined_row_limit = 0;
SET GLOBAL long_query_time = 0;
SET GLOBAL slow_query_log = 1;
```

## Disable Slow Query Log

It is important to log slow queries, so set it to something like `3` seconds.

```sql
SET GLOBAL long_query_time = 3;
```
