# Set up Table

No set up is needed.

* * *

# Queries

## Simple

```Java
session.find (Payment.class, 1L, LockModeType.PESSIMISTIC_WRITE)
```

## QueryDSL

```JAVA
var listOfRowsFromTable1 = new JPAQuery <Table1> (sessionWithDatabase)
        .select (Table1.table1)
        .from (Table1.table1)
        .setLockMode (LockModeType.PESSIMISTIC_WRITE)
        .setHint ("javax.persistence.lock.timeout", 5000) // Lock for 5 second
        .list ();
```