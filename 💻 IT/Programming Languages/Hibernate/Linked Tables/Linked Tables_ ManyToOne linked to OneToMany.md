# SQL Code:

- pupil table:

```POSTGRESQL
CREATE TABLE concubine (
    id BIGSERIAL PRIMARY KEY,
    lastname VARCHAR (128),
    sheikh_id INT REFERENCES sheikh (id) ON DELETE CASCADE
);
```

- school table:

```POSTGRESQL
CREATE TABLE sheikh (
     id SERIAL PRIMARY KEY,
     lastname VARCHAR (64) NOT NULL UNIQUE
);
```

***

# Java code

- Concubine:

```JAVA
@Table (name = "concubine", schema = "public")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@EqualsAndHashCode (exclude = { // You need to exclude all foreign keys
        "mySheikh"
})
@ToString (exclude = { // You need to exclude all foreign keys
        "mySheikh"
})
public class Concubine {

    @Id // Represents concubine.id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long id;

    @Column (unique = true) // Represents concubine.lastname
    private String lastname;

    @JoinColumn (name = "scheikh_id") // Represents concubine.sheikh_id
    @ManyToOne (fetch = FetchType.LAZY) // It must be lazy everytime
    private Sheikh mySheikh;
}
```

- Sheikh:

```JAVA
@Table (name = "sheikh", schema = "public")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
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
    private Map <String, Concubine> mapOfConcubines = new TreeMap <String, Concubine> ();

    public void addCocubine (Concubine concubine) {
        mapOfConcubines.put (concubine.getLastname (), concubine);
        concubine.setMySheikh (this);
    }
}
```
