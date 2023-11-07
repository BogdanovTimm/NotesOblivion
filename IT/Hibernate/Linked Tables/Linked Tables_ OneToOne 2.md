```JAVA
@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
    private Address address;
    //...
}

@Entity
public class Address {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String street;
    private String city;
    private String state;
    private String zip;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;
    //...
}
```

OR

```JAVA
@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
    private Address address;
    //...
}

@Entity
public class Address {
    @Id
    private Long id;
    private String street;
    private String city;
    private String state;
    private String zip;

    @MapsId
    @OneToOne
    @JoinColumn(name = "id")
    private User user;
    //...
}
```