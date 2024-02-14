You can do something:
- after it is created `@PreLoad`
- before it added to database `@PrePersist`
- after it added to database `@PPostPersist`
- before it updated `@PreUpdated`
- after it updated `@PostUpdated`
- before it deleted `@PreRemove`
- after it deleted `@PostRemove`

-:
 - you can't change tables via SQL or this listeners will not work

```JAVA
@Table (name = "payment", schema = "public")
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Payment {
    
    @Id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column
    private Integer amount;
      
    @PreUpdate
    public void preUpdate () {
        System.out.println ("Updating row...")
    }
}
```