# Id Generators

There is 4 types of them:

- Identity:

```
@GeneratedValue (strategy = GenerationType.IDENTITY)
private Long id;
```

- Sequence:

```
@GeneratedValue (generator = 'user_gen', strategy = GenerationType.SEQUENCE)
@SequenceGenerator (name = 'user_gen', sequenceName = 'users_id_seq', allozationSize = 1)
private Long id;
```

Your SQL:

```
CREATE TABLE users (
id BIGINT PRIMARY KEY,
...
);
CREATE SEQUENCE users_id_seq
OWNED BY users.id;
```

- Table (very rare). It is used when there is no ID in the SQL
