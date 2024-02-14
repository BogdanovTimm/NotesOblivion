# Datatype exists in PostgreSQL, but doesn't exist in Java

SQL:

- table1:

```POSTGRESQL
CREATE TABLE table1 (
    id BIGSERIAL PRIMARY KEY,
    columnwithraredatatype JSONB
)
```

Java:

- Table1:

```JAVA
@Table (name = "table1", schema = "public") // Sets name of a Tabla
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@EqualsAndHashCode
@ToString
@TypeDef (name = "JsonB", typeClass = JsonBinaryType.class) // Create a name for a pre-made representation of a rare datatype from PostgreSQL
public class Table1 {

    @Id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long id;

    @Type (type = "JsonB") // Here we give a name to a pre-made representation of a rare datatype from PostgreSQL. So,.we just use a pre-made type of JSONB instead of creating our own representation of it.
    private String columnwithraredatatype;
}
```

- gradle.build:

```GROOVY
...
dependencies {
    ...
    implementation 'com.vladmihalcea:hibernate-types-52:2.12.1'
    ...
}
...
```

- HibernateUtil.java:
```JAVA
configuration.registerTypeOverride (new JsonBinaryType ());
```

# Enumeration

SQL:

```POSTGRESQL
CREATE TABLE table1 (
    id BIGSERIAL PRIMARY KEY,
    column1 VARCHAR (32)
);

```

Java:

- Table1:

```JAVA
@Table (name = "table1", schema = "public")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@EqualsAndHashCode
@ToString
public class Table1 {

    @Id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated (EnumType.STRING) // This variable will be converted from Enum to VARCHAR.
    private Enum1 column1; // Represents table1.column1
}
```

- Role:

```JAVA
public enum Role {
    USER,
    ADMIN
}
```

# Date

Use:
- `LocalDateTime`
- `LocalDate`
- `LocalTime`

Why? Because:
- Before Java 8 there were @Temporal annotation to map java's Date class to SQL.
- Since Java 8 there are LocalDateTime, LocalDate and LocalTime and @Temporal isn't needed.


# Custom programmer's datatype in Java, there is no such in PostgreSQL

SQL:

- table1:

```POSTGRESQL
CREATE TABLE table1 (
    id BIGSERIAL PRIMARY KEY,
    column1 DATE,
);
```

Java:

- Table1:

```JAVA
@Table (name = "table1", schema = "public")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@EqualsAndHashCode
@ToString
public class Table1 {

    @Id // table1.id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long id;

    @Convert (converter = BirthdayConverter.class) // Because it is a custom variable, we need to create BirthdayConverter to teach Hibernate how to work with that
    private CustomDatatype column1; // Represents table1.column1
}
```

- CustomDatatype:

```JAVA
public record CustomDatatype (LocalDate birthdate) {
    public long getCustomDatatype () {
        return ChronoUnit.YEARS.between (birthdate, LocalDate.now ());
    }
}
```
- CustomDatatypeConverter:
```
@Converter (autoApply = true)
public class CustomDatatypeConverter implements AttributeConverter <CustomDatatype, Date> { // Custom converter for CustomDatatype because Hibernate donesn't know ho to work with our Custom variables
    @Override
    public Date convertToDatabaseColumn (Customdatatype attribute) { // Converts CustomDatatype into SQL column
        return Optional.ofNullable (attribute)
                       .map (CustomDatatype::birthdate)
                       .map (Date::valueOf)
                       .orElse (null);
    }
    @Override
    public CustomDatatype convertToEntityAttribute (Date dbData) { // Convert SQL column into our Class
        return Optional.ofNullable (dbData)
                .map (Date::toLocalDate)
                .map (CustomDatatype::new)
                .orElse (null);
    }
}

```

- HibernateUtil.java:
```JAVA
configuration.addAttributeConverter (new BirthdayConverter ());
```
