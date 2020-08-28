---
title: "Pitfalls"
date: 2020-92-13
---

## `mysql` CLI Console Password Character "Limit"

`mysql` command only reads in 79 characters of "password" from TTY / "console". In my case I was copy'n'pasting / the password store autotyping database passwords which doesn't work then (leads to `Access denied for user` errors because the password is wrong).
This "limit" doesn't seem to be documented anywhere I looked, so here we go. If you want to login to your users only use passwords 79 characters long when "typing" them on the console.

Thanks to this [Jira ticket (MXS-1766)](https://jira.mariadb.org/browse/MXS-1766) to pointing to the code behind the "limitation"!

I also need to give a shoutout to the people with which I reflected the issue and then stumbled upon the `mysql` CLI limitation.

**Code references**:

* [GitHub MariaDB/server - `10.3/client/mysql.cc` Line 1959](https://github.com/MariaDB/server/blob/10.3/client/mysql.cc#L1959)
* [GitHub MariaDB/server - `10.3/mysys/get_password.c` Line 63](https://github.com/MariaDB/server/blob/10.3/mysys/get_password.c#L63)

## Replication User Password Character Limit

The password for a replication user must be a maximum of `32` characters long.
