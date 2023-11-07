## Joined

+ :
- Easy to understand
- Often used

- :
- Slow

Java:
- Parent (if you decide that it will be not absctract class - it must be added to hibernate.cfg):
```JAVA
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Inheritance (strategy = InheritanceType.SINGLE_TABLE)
public abstract class Parent { // Doesn't represents any table. It only keeps common columns

    @Id // Will represent child.id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long id;

    private String column1; // Will represent child.column1
```

- Child1 (must be added to hibernate.cfg):
```JAVA
@Table (name = "chlid1", schema = "public") // Represents child1 table
@Entity
@PrimaryKeyJoinColumn (name = "id") // child1.id will be used to connect this table with parent that keeps other columns
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Child1 extends Parent {

    // parent.column1 will represent child1.column1	

    private String column2; // Represents chlid1.column2
    
    @Builder
    public Programmer (Long id, String column1, String column2) {
        super (id, column1);
        this.column2 = column2;
    }
}
```

- Child2 (must be added to hibernate.cfg):
```JAVA
@Table (name = "chlid2", schema = "public") // Represents child1 table
@Entity
@PrimaryKeyJoinColumn (name = "id")// child1.id will be used to connect this table with parent that keeps other columns
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Child2 extends Parent { // It will be a part of parentandallchild table

    // parent.column1 will represent child1.column1	

    private Integer column2; // Represents chlid1.column2
    
    @Builder
    public Programmer (Long id, String column1, Integer column2) {
        super (id, column1);
        this.column2 = column2;
    }
}
```