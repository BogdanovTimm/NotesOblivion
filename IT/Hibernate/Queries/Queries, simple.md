# CRUD:

- `database1.save (table1_row1);` - Safes an Entity into a Database after `database1.flush ()`, `database1.commit ()` or closing the session with database
- `database1.update (table1_row1);` - updates already existing in database row after `database1.flush ()`, `database1.commit ()` or closing the session with database. Actually, if you, prior to any change, in same session in which you later will do some change, get some row from database with `get ()`, or add it to database via `save ()` - it will automatically do `update ()` without your need to write it, if you change something after `get ()` or `save ()`. Throws and exception if there is no such raw in the table
- `database1.saveOrUpdate (table1_row1);` - adds a row into database if it isn't existed yet, or updates it after `database1.flush ()`, `database1.commit ()` or closing the session with database
- `database1.delete (table1_row1);` - Deletes given row from the table after `database1.flush ()`, `database1.commit ()` or closing the session with database. If there is no such row - it doesn't throw the exception.
- `Table1 table1_row2 = database1.get (Table2.class, 1);` - Gets a row from given table by given id immideatly. But it is better to use `database.find ()` instead.
- `Table1 table1_row2 = database1.find (Table2.class, 1);` - like `get ()`, but doesn't throw an exception if there is no such row in the table (better use it instead of `get ()`)

Other commands:
- Takes this row from an SQL Database and change table1_raw1 to be equal to this row from the SQL Database (for example, if you did some change in that row and want to roll it back):
```JAVA
Table1 table1_raw1 = database1.get (Table1.class, 1);
table1_raw1.setColumn1 (5); // Or other change, it doesn't matter
database1.refresh (table1_raw1);
```
- Goes to SQL, GETs the row for this user and change it so all the updates will be applied to the user variable (it can may be handy if database1_raw1 was `get ()` from database in previous session, so updates would not be applied without `database1.update (table1_raw1)` (but i think it is easier to just do `update()` lol)) :
```JAVA
In previous session: {
Table1 table1_raw1 = database1.get (Table1.class, 1);
}
Table1 table1_raw1_changed = database1.merge (table1_raw1);
```