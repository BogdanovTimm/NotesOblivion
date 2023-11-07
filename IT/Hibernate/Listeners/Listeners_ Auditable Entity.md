dmdev has showed that, but it does not work for me at all, lol! It does not even compile.

When to use:
- accout of a creation time of row in database (e.g. when was bank transsaction occured)
- sent an email when user get registered on site

-:
 - you can't change tables via SQL or this listeners will not work

```JAVA
@MappedSuperclass
@EntityListeners (AuditListener.class)
@Getter
@Setter
public abstract class AuditableEntity <T extends Serializable> {
    
    private Instant createdAt;
    
    private String createdBy;
    
    private Instant updatedAt;
    
    private String updatedBy;
}
```

- AuditListener

```JAVA
public class AuditListner {
    @PrePersist
    public void prePersist (AuditableEntity <?> entity) {
        entity.setCreatedAt (Instant.now ());
    }
    @PreUpdate
    public void preUpdate (AuditableEntity <?> entity) {
        entity.setUpdatedAt (Instant.now ());
    }
}
```

And then, table that need to be auditable must extend this abstract class:

```JAVA
@Table (name = "table1", schema = "public")
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Table1 extends AuditableEntity <Long> {
    
    @Id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column
    private Integer column1;
}
```