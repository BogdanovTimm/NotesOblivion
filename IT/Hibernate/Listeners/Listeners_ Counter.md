Sometimes you have a table that is linked to other table. And you may want to know how many rows in that linked table with your main table.

When to use:
- How many users are in chat

-:
 - you can't change tables via SQL or this listeners will not work

# Set up

It is modernised Many To Many trinity of tables:

Main table:

```JAVA
@Table (name = "table1", schema = "public")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EqualsAndHashCode (exclude = "listOfLinkedRowsFromTable2")
@ToString (exclude = "listOfLinkedRowsFromTable2")
@EntityListners (Table1Table2Listener)
public class Table1 {
    
    @Id // Represents table1.id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column // Represents table1.column1
    private String column1;
    
    @Builder.Default // Represents table1.count. It will count how many table1table2 rows are linked with this row of table1
    private Integer count = 0;

    @Builder.Default // It doesn't represent any table form SQL
    @OneToMany (mappedBy = "table1") // Variable in Table1Table2 that point to this table
    private List <Table1Table2> listOfLinkedRowsFromTable2 = new ArrayList<> ();

}
```

```JAVA
public class Table1Table2Listener {
    @PostPersist
    public void postPersist (UserChat userChat) {
        var chat = userChat.getChat ();
        chat.setCount (chat.getCount () + 1);
    }
    @PostRemove
    public void postRemove (UserChat userChat) {
        var chat = userChat.getChat ();
        chat.setCount (chat.getCount () - 1);
    }
}
```