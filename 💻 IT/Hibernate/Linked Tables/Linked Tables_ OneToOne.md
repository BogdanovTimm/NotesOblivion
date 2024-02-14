# Bidirectional

It can be used only if Capital table will have NON-synthetic id. Then this need to be added to State:
```JAVA
@OneToOne (
    mappedBy = "myState", // variable in Capital that points to State
    fetch = FetchType.LAZY,
    optional = false
)
private Capital capital;
```

SQL:

- state:

```POSTGRESQL
CREATE TABLE state (
    id BIGSERIAL PRIMARY KEY,
    statename VARCHAR (128) UNIQUE
);
```

- capital:

```POSTGRESQL
CREATE TABLE capital (
    id BIGSERIAL PRIMARY KEY,
    state_id BIGINT NOT NULL UNIQUE REFERENCES usersbest (id),
    capitalname VARCHAR (128)
);
```

***

# Unidirectional

SQL:

- state:

```POSTGRESQL
CREATE TABLE state (
    id BIGSERIAL PRIMARY KEY,
    statename VARCHAR (128) UNIQUE
);
```

- capital:

```POSTGRESQL
CREATE TABLE capital (
    id BIGSERIAL PRIMARY KEY,
    state_id BIGINT NOT NULL UNIQUE REFERENCES usersbest (id),
    capitalname VARCHAR (128)
);
```

Java:

- State:

```JAVA
@Table (name = "state", schema = "public")
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EqualsAndHashCode (exclude = { // You need to exclude all foreign keys
        "capital"
})
@ToString (exclude = { // You need to exclude all foreign keys
        "capital"
})
public class State {

    @Id // Represents staet.id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long id;

    @Column (unique = true) // Represents state.statename
    private String statename;

}
```

- Capital:

```JAVA
@Table (name = "capital", schema = "public")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@EqualsAndHashCode (exclude = { // You need to exclude all foreign keys
        "myState"
})
@ToString (exclude = { // You need to exclude all foreign keys
        "myState"
})
public class Capital {

    @Id // Represents capital.id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long id;

    @Column (unique = true) // Represents capital.capitalname
    private String capitalname;

    @JoinColumn (name = "state_id") // Represents capital.state_id
    @ManyToOne
    private State myState;

    public void setState (State state) {
        state.setCapital (this);
        this.state = state;
    }
}
```
