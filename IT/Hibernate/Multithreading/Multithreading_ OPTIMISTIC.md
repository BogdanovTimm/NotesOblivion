# Set up Table

Table1:
```JAVA
@Table (name = "table1", schema = "public")
@Entity
@OptimisticLocking (type = OptimisticLockType.VERSION)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EqualsAndHashCode
@ToString
public class Table1 {

    @Id // Represents table1.id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long id;

    @Column // Represents table1.statename
    private String column1;

    @Version // Doesn't represent any column. It is needed to Optimistic Lock to work
    private Long version;
}
```

* * *

# Quering

## Simple query

```Java
session.find (Payment.class, 1L, LockModeType.OPTIMISTIC)
```

## QueryDSL

```JAVA
var listOfRowsFromTable1 = new JPAQuery <Table1> (sessionWithDatabase)
		.select (Table1.table1)
		.from (Table1.table1)
		.setLockMode (LockModeType.OPTIMISTIC)
		.setHint ("javax.persistence.lock.timeout", 5000) // Lock for 5 second
		.list ();
```
