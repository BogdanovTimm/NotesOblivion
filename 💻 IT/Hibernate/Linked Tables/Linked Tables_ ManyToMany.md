# SQL

- actor_film

```
CREATE TABLE actor_film (
    id BIGSERIAL PRIMARY KEY ,
    actor_id BIGINT REFERENCES actor (id),
    film_id BIGINT REFERENCES film (id),
    created_at TIMESTAMP NOT NULL,
    UNIQUE (actor_id, film_id)
);
```

- film:

```
CREATE TABLE film (
    id BIGSERIAL PRIMARY KEY,
    filmname VARCHAR (64) NOT NULL UNIQUE
);
```

- actor:

```
CREATE TABLE actor (
    id BIGSERIAL PRIMARY KEY,
    lastname VARCHAR (128) UNIQUE,
);
```

***

# Java:

- ActorFilm:

```JAVA
@Table (name = "actor_film", schema = "public")
@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode (exclude = { // You need to exclude all foreign keys
    "actor",
    "film"
})
@ToString (exclude = { // You need to exclude all foreign keys
    "actor",
    "film"
})
public class ActorFilm {
    
    @Id // Represents actor_film.id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn (name = "actor_id") // Represents actor_film.actor_id
    private Actor actor;
    
    @ManyToOne
    @JoinColumn (name = "film_id") // Represents actor_film.film_id
    private Film film;
    
    private Instant createdAt;
    
    public void setActor (Actor actor) {
        this.actor = actor;
        this.actor.getListOfActorFilm ().add (this);
    }
    public void setFilm (Film film) {
        this.film = film;
        this.film.getListOfActorFilm ().add (this);
    }
}
```

- Actor:

```JAVA
@Table (name = "actor", schema = "public")
@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode (exclude = { // You need to exclude all foreign keys
    "actor",
    "film"
})
@ToString (exclude = { // You need to exclude all foreign keys
    "actor",
    "film"
})
public class Actor {

    @Id // Represents actor.id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long id;

    private String lastname; // Represents actor.lastname
    
    @OneToMany ( // Doesn't represent any column
    mappedBy = "actor" // Set which variable in ActorFilm represents actor_film.actor_id
    )
    @Builder.Default
    private List <ActorFilm> listOfActorFilm = new ArrayList <> ();
}
```

- Film:

```JAVA
@Table (name = "film", schema = "public")
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EqualsAndHashCode (of = "filmname")
@ToString (exclude = "listOfActorFilm")
public class Film {
    
    @Id // Represents film.id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column (nullable = false, unique = false) // Represents film.filmname
    private String filmname;
    
    @Builder.Default
    @OneToMany ( // Doesn't represent any column
        mappedBy = "film" // Which variable in ActorFilm represents actor_film.film_id
    )
    private List <ActorFilm> listOfActorFilm = new ArrayList<> ();
}
```