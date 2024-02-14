+ :
- We can add constraints on columns (e.g. NOT NULL only for chlid1, etc)
- If we need to find raw only from Chlid1, we can search only in Child1 (more fast)

- :
- Rarely used
- We can't use `@GeneratedValue (strategy = GenerationType.IDENTITY)`
- If we add some column to Parent - we must change constructor in every its Childer
- Parent must be abstract class

Java:
- Parent (must not be added to hibernate.cfg):
```JAVA
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Inheritance (strategy = InheritanceType.TABLE_PER_CLASS)
public abstract class Parent { //It doesn't Represent any table

    @Id // Will be create with every child. Will represent its child.id
    @GeneratedValue (strategy = GenerationType.SEQUENCE) // Only this type of strategy cna be used
    private Long id;

    private String column1; // Will be create with every child. Will represent its child.column1
```

- Child1 (must be added to hibernate.cfg):
```JAVA
@Table (name = "child1", schema = "public") // Represents child1 table
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Child1 extends Parent {
    
    // Parent.id will be created and will represent child1.id

    // Parent.column1 will be created and will represent child1.column1

    private String column2; // Represents child1.column2
    
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
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Child2 extends Parent {

    // Parent.id will be created and will represent child1.id

    // Parent.column1 will be created and will represent child1.column1

    private Integer column2; // Represents child2.column2
    
    @Builder
    public Programmer (Long id, String column1, Integer column2) {
        super (id, column1);
        this.column2 = column2;
    }
}
```
