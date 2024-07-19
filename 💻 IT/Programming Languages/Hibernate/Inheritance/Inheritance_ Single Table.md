Single Table for Parent and all of its children

+ :
- Use it
- We can use `@GeneratedValue (strategy = GenerationType.IDENTITY)`
- Often used
- Parent class can be not `abstract class`

- :
- We can't add constraints on columns (e.g. NOT NULL only for chlid1, etc)

Java:
- Parent (if you decide that it will be not absctract class - it must be added to hibernate.cfg):
```JAVA
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Inheritance (strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn (name = "tabletype") // Represent parentandallchild.tabletype - it set the type of java class
public abstract class Parent { // There will be 1 table for parent and all its children

    @Id // Represents parentandallchild.id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long id;

    private String column1; // Represents parentandallchild.column1
```

- Child1 (must be added to hibernate.cfg):
```JAVA
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Child1 extends Parent { // It will be a part of parentandallchild table

    private String column2; // Represents parentandallchild.column2
    
    @Builder
    public Programmer (Long id, String column1, String column2) {
        super (id, column1);
        this.column2 = column2;
    }
}
```

- Child2 (must be added to hibernate.cfg):
```JAVA
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Child2 extends Parent { // It will be a part of parentandallchild table

    private Integer column3; // Represents parentandallchild.column3 (IDK what will be if there will be identical columns in both child1 and child2)
    
    @Builder
    public Programmer (Long id, String column1, Integer column2) {
        super (id, column1);
        this.column2 = column2;
    }
}
```
