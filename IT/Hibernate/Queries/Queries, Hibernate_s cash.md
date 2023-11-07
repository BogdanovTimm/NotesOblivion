# What is cash

Hibernate has 2 cashes:
- 1st level cash - if you ask for some row in a session 2 times, it helps to automatically do only 1 get from database. Also it saves all rows in it that was `get ()`, `save()`, `update ()` , `createQuery ()`
- 2nd level cash

- `database1.evict (table1_raw1);` - Clears Hibernate's cash for given Entity. Rarely used
- `database1.clear ();` - Clears Hibernate's cash for all Entities. Rarely used
- `database1.close ();` - Clears Hibernate's cash. (We never run it because `try ()` block do it for us. Rarely used
- `database1.flush ();` - Like an `update ()`: synchronize the Enities with an SQL Database, but using only 1st level cash.