#             What it is?

It is a locking when we work in a concurrency







# Types of locks

Different types of locks may conflict with each other, e.g. if there is **ACCESS EXCLUSIVE** lock on the table, then PostgreSQL can't use **ACCESS SHARE** lock.

Table of conflicts (**X** means conflict, nothing means that these 2 lock modes may be used concurrently):

| | ACCESS SHARE | ROW SHARE | ROW EXCLUSIVE | SHARE UPDATE EXCLUSIVE | SHARE | SHARE ROW EXCLUSIVE | EXCLUSIVE | ACCESS EXCLUSIVE |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
| **ACCESS SHARE** |  |  |  |  |  |  |  | X |
| **ROW SHARE** |  |  |  |  |  |  | X | X |
| **ROW EXCLUSIVE** |  |  |  |  | X | X | X | X |
| **SHARE UPDATE EXCLUSIVE** |  |  |  | X | X | X | X | X |
| **SHARE** |  |  | X | X |  | X | X | X |
| **SHARE ROW EXCEXCLUSIVE** |  |  | X | X | X | X | X | X |
| **EXCLUSIVE** |  | X | X | X | X | X | X | X |
| **ACCESS EXCLUSIVE** | X | X | X | X | X | X | X | X |

Which SQL-Queries use them:
- **ACCESS SHARE** (`AccessShareLock`) - The `SELECT` command acquires a lock of this mode on referenced tables. In general, any query that only _reads_ a table and does not modify it will acquire this lock mode.
 - **ROW SHARE** (`RowShareLock`) - The `SELECT` command acquires a lock of this mode on all tables on which one of the `FOR UPDATE`, `FOR NO KEY UPDATE`, `FOR SHARE`, or `FOR KEY SHARE` options is specified (in addition to **ACCESS SHARE** locks on any other tables that are referenced without any explicit `FOR ...` locking option).
 - **ROW EXCLUSIVE** (`RowExclusiveLock`) - The commands `UPDATE`, `DELETE`, `INSERT`, and `MERGE` acquire this lock mode on the target table (in addition to **ACCESS SHARE** locks on any other referenced tables). In general, this lock mode will be acquired by any command that _modifies data_ in a table. 
 - **SHARE UPDATE EXCLUSIVE** (`ShareUpdateExclusiveLock`) - This mode protects a table against concurrent schema changes and `VACUUM` runs. Acquired by `VACUUM` (without `FULL`), `ANALYZE`, `CREATE INDEX CONCURRENTLY`, `CREATE STATISTICS`, `COMMENT ON`, `REINDEX CONCURRENTLY`, and certain [`ALTER INDEX`](https://www.postgresql.org/docs/current/sql-alterindex.html "ALTER INDEX") and [`ALTER TABLE`](https://www.postgresql.org/docs/current/sql-altertable.html "ALTER TABLE") variants (for full details see the documentation of these commands).
 - **SHARE** (`ShareLock`) - This mode protects a table against concurrent data changes. Acquired by `CREATE INDEX` (without `CONCURRENTLY`).
 - **SHARE ROW EXCLUSIVE** (`ShareRowExclusiveLock`) - This mode protects a table against concurrent data changes, and is self-exclusive so that only one session can hold it at a time. Acquired by `CREATE TRIGGER` and some forms of [`ALTER TABLE`](https://www.postgresql.org/docs/current/sql-altertable.html "ALTER TABLE").
 - **EXCLUSIVE** (`ExclusiveLock`) - This mode allows only concurrent `ACCESS SHARE` locks, i.e., only reads from the table can proceed in parallel with a transaction holding this lock mode. Acquired by `REFRESH MATERIALIZED VIEW CONCURRENTLY`.
 - **ACCESS EXCLUSIVE** (`AccessExclusiveLock`) - This mode guarantees that the holder is the only transaction accessing the table in any way. Acquired by the `DROP TABLE`, `TRUNCATE`, `REINDEX`, `CLUSTER`, `VACUUM FULL`, and `REFRESH MATERIALIZED VIEW` (without `CONCURRENTLY`) commands. Many forms of `ALTER INDEX` and `ALTER TABLE` also acquire a lock at this level. This is also the default lock mode for `LOCK TABLE` statements that do not specify a mode explicitly.