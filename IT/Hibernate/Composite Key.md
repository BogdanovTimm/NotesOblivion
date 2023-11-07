```JAVA
@Entity
public class Table1 {

    @EmbeddedId
    private CompositeKey compositeKey;
}

@Embeddable
public class CompositeKey implements Serializable {

    @Column(name = "id1")
    private Long id1;

    @Column(name = "id2")
    private Long id2;
}
```