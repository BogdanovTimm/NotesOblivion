# Java classes

Class must be not final.

Every java class that represents some table in database must be added to both `scr\main\resources\hivernate.cfg.xml` and `scr\test\resources\hivernate.cfg.xml`

Every Table must implement BaseEntity interface

# Java Variables

All variables must be not final

All variable must be private

Use only List or Maps from Collections

If your variable has identical name with column in Database table, then you don't need to set which column this variable represents.

But, you can explicitly set which column some variable represents using `@Column (name = "column1"`:

```JAVA
...
@Column (name = "column1") // Represents table1.column1
private String column1;
...
```

## Java @Id variable

Class of id-variable must be implement Interface Serializable.

We don't need to set and Id variable when we create a new instance of a class with auto-generated id.