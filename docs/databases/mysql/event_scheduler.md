---
title: "event_scheduler"
---

Ever wanted to run queries in a cronjob? Where to safely put the database credentials? MySQL / MariaDB can help out with that.

## Enable the `event_scheduler` System

You must have the `event_scheduler` enabled, this can be done by running the following query:

```sql
SET GLOBAL event_scheduler = ON;
```

!!! note
    It is highly recommended to use the config file(s) of your MySQL / MariaDB server to enable the `event_scheduler` feature.
    Another (hacky) way is to use the [MySQL server `init_file` option](cheat-sheet.md#run-a-sql-script-on-init--startup) which runs a SQL script on server startup.

## Create an Event to run a SQL Query

The `CREATE EVENT` query below would run the query after the `DO` every day at `02:00` in the `exampledb` database.

```sql
CREATE EVENT `exampledb`.`my_cool_table_reset_userOption45` ON
SCHEDULE EVERY 1 DAY STARTS CURRENT_DATE + INTERVAL 1 DAY + INTERVAL 2 HOUR DO
UPDATE
    `exampledb`.`my_cool_table`
SET
    userOption45 = ''
WHERE
    userOption45 != ''
    AND STR_TO_DATE(userOption45,
    '%Y-%m-%d') <= NOW();
```

## Show existing Events

!!! note
    `exampledb` is the database name.

```sql
SHOW EVENTS FROM `exampledb`;
```

## References

* [MySQL 5.7 Reference - `event_scheduler`](https://dev.mysql.com/doc/refman/5.7/en/event-scheduler.html)
* [MySQL 5.7 Reference - `CREATE EVENT` Statement](https://dev.mysql.com/doc/refman/5.7/en/create-event.html).
