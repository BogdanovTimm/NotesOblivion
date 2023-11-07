There is a problem with linked tables: they are very slow. There are plenty of ways to handle this:

- Goood ones:
    - When you create your QueryDsls - just use `.join (QTable1.table1.column1, QTable2.table2).fetchJoin ()` on every `.join ()`
    - When you want to use `database1.get()` \- use `database1.find ()` instead and insert an EntityGraph in it.
- Bad ones:
    - `@FetchProfile`
    - `@Batch` \- not so helpful, so, do not use it
    - `@Fetch (FetchMode = SUBSELECT)` \- it works only for collections and it takes out this collection every time when you take out the table that has this collection in it. So. do not use it

* * *

# EntityGraph

## Find ()

Suppose we have this tables:

```
Table1.table2Id --> Table2
Table1.listOfTable3 --> Table3
Table3.table4ID --> Table4

   table1[listOfTable3]-->table3[table4_id]-->table4
[table2Id]
  |
  v
table2
```

Table1:

```JAVA
@Table (name = "table1", schema = "public")
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EqualsAndHashCode (exclude = { // You need to exclude all foreign keys
        "table2Id"
})
@ToString (exclude = { // You need to exclude all foreign keys
        "table2Id"
})
public class Table1 {

    @Id // Represents table1.id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long id;

    @Column (unique = true) // Represents table1.column1
    private String column1;

    @JoinColumn (name = "table2_id") // Represents table1.table2_id
    @ManyToOne (fetch = FetchType.LAZY)
    private Table2 table2Id;

    // Doesn't represents any column in original SQL
    @OneToMany (mappedBy = "user") // Set which variable in Table3 must be equal to this variable
    @Builder.Default
    private List <Table3> listOfTable3 = new ArrayList <> ();
}
```

Table2, Table3 and Table4 are not showed, but they exist.

Runner or Utility class:

```JAVA
...
var table1Graph = database1.createEntityGraph (Table1.class); // Table you will start with
table1Graph.addAttributeNodes ("table2_id", "listOfTable3"); // Variables of linked to Table1 tables that you want to get with Table1
var table1Subgraph = table1Graph.addSubgraph ("listOfTable3", Table1.class); // Creates a possibility to go to our subgraphs and get tables, linked to them
table1Subgraph.addAttributeNodes ("table4Id"); // Variables of linked to Table3 tables that you want to get with it
Map <String, Object> getTable2Table3Table4 = Map.of ( // Creates a Map that you can insert into database.find () when you want to get Table2, Table3 and Table4 along side with Table1
    GraphSemantic.LOAD.getJpaHintName(),
    table1Graph
);
var table1 = database1.find (Table1.class, 1L, getTable2Table3Table4);
...
```