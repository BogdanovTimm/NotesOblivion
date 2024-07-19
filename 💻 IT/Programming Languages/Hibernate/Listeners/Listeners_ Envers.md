Actually, it is not only the single table of all changes, but also an audit table for every table on which you have writed `@Audited` plus one table with all changes.

Individual tables consist of columns:

- id - id of a row from origianl table
- rev - version of row. By default it 1, then it increases after each update
- revtype - what was done to the row:
    - 0 - add to database
    - 1 - update
    - 3 -
    - 4 -
- timestamp - when was new version created
- your columns

Add implementatio to build.gradle:

```GROOVY
implementation 'org.hibernate:hibernate-envers:5.0.1.Final'
```

On every table that you want to be audited, you must write `@Audited (targetAuditMode = RelationTargetAuditMode.NOT_AUDITED)`. Collections with linked tables must not be audited at all, or you need to add `@Audited (targetAuditMode = RelationTargetAuditMode.NOT_AUDITED)` on the tables that it audit.

```JAVA
@Table (name = "sheikh", schema = "public")
@Entity
@Audited (targetAuditMode = RelationTargetAuditMode.NOT_AUDITED) // <-- add this
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString (exclude = "mapOfConcubines") // You need to exclude all foreign keys
@EqualsAndHashCode (exclude = "mapOfConcubines") // You need to exclude all foreign keys
public class Sheikh {

    @Id // Represents school.id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column (nullable = false, unique = true) // Represents sheikh.lastname
    private String lastname;

    @OneToMany (
        mappedBy = "mySheikh", // variable name in Concubine that represents sheikh.concubine_id
        cascade = CascadeType.ALL,
        orphanRemoval = false // Don't delete users if it is deleted from this Map, but not deleted from database (true is rarely used)
    ) // It doesn't represent any column
    @MapKey (name = "lastname") // Concubine.lastname will be the key to this Map
    @NotAudited // <-- Collections must be not auditted
    private Map <String, Concubine> mapOfConcubines = new TreeMap <String, Concubine> ();

    @JoinColumn (name = "scheikh_id") // Represents concubine.sheikh_id
    @ManyToOne (fetch = FetchType.LAZY) // It must be lazy everytime
    private Sheikh mySheikh;

    public void addCocubine (Concubine concubine) {
        mapOfConcubines.put (concubine.getLastname (), concubine);
        concubine.setMySheikh (this);
    }
}
```

..\\entity\\Revision - it is a table that will consist of auditable information - id of entity, time when something has occured, username of who did something with row:

```JAVA
@Entity
@RevisionEntity (DmdevRevisionListener.class)
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Revision {
    @Id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    @RevisionNumber
    private Long id;
    
    @RevisionTimestamp
    private Long timestamp;
    
    private String username;
}
```

...\\listner\\DmdevRevisionListner - it will look after the updates of all tables

```JAVA
public class DmdevRevisionListener implements RevisionListener {
    @Override
    public void newRevision (Object revisionEntity) {
        //SecurityContext.getUser ().getId (); In real applications it will be like that
        ((Revision) revisionEntity).setUsername ("dmdev");
    }
}
```

# Working with audit tables

Because auditable tables are just tables, you can work with them like with the common tables:

```JAVA
var auditReader = AuditReaderFactory.get (sessionWithDatabase);
var version1OfRow1FromTable1 = auditReader.find (Table1.class, 1L, 1L); // Original table, id of row, id of version of row
```

Querydsl will works too.

# Time machine

You can get your old versions of rows and add update last version of row using them - so, it is like Git, or a time machine.