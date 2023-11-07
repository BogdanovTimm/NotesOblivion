If you change some row from table, update () will not work.

# For all queris in the session

```Java
sessionWithDatabase.setDefaultReadOnly (true);
```

# For 1 QueryDSL

```JAVA
var listOfRowsFromTable1 = new JPAQuery <Table1> (sessionWithDatabase)
		.select (Table1.table1)
		.from (Table1.table1)
		.setReadOnly (true)
		.list ();
```