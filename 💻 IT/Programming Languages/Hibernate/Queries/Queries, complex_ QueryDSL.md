# Output a List of rows

SQL:
```POSTGRESQL
SELECT
    table1.column1, table1.column2
FROM
    table1
    JOIN table2 ON table1.table2_id = table2.table1_id
        JOIN table3 ON table2.table3_id = table3.table2_id
WHERE
    table1.column1 > 5
ORDERED BY
    table1.column1 ASC
LIMIT 5
```

QueryDsl:
```JAVA
var listOfRowsFromTable1 = new JPAQuery <Table1> (database1)
    .select (QTable1.table1, QTable1.column2)
    .from (QTable1.table1)
    .join (QTable1.table1.table2, QTable2)
    .join (QTable2.table2.table3, QTable3)
    .where (QTable1.table1.column1.gt (5))
    .orderBy (QTable1.table1.column1.asc ())
    .limit (5)
    .fetch ();
```


# GROUPED BY

When you use GROUPED BY, the output will consist of little tables, in Java Tuple class will represent them.

SQL:
```POSTGRESQL
SELECT
    table1.*
FROM
    table1
GROUPED BY
    table1.id
HAVING
    AVG(table1.column1) > 5
```

QueryDSL:
```JAVA
var listOfTuplesOfMinitables = new JPAQuery <Tuple> (database1)
    .select (QTable1.table1)
    .from (QTable1.table1)
    .groupedBy (QTable1.table1.id)
    .havind (QTable1.table1.column1.avg ().gt (5))
    .fetch ();
```

# SELECT AVG(table1.column1)

SQL:
```POSTGRESQL
SELECT
    AVG (table1.collumn1)
FROM
    table1
```

QueryDSL:
```JAVA
var double1 = new JPAQuery <Double> (database1)
    .select (QTable1.table1)
    .form (QTable1.table1)
    .fetchFirst ();
```

# Subqueries

SQL:
```POSTGRESQL
SELECT
    table1.*
FROM
    table1
GROUPED BY
    table1.id
HAVING
    AVG(table1.column1) > SELECT
                              AVG(table2.column2)
                          FROM
                              table2
```


QueryDSL
```JAVA
var listOfTuplesOfMinitables = new JPAQuery <Tuple> (database1)
    .select (QTable1.table1)
    .from (QTable1.table1)
    .groupedBy (QTable1.table1.id)
    .havind (QTable1.table1.column1.avg ().gt (new JPAQuery <Tuple> (database1).select (QTable2.table2.column2.avg ()).from (QTable2.table2)))
    .fetch ();
```

# Dynamic Quering

\dao.QPredicate:
```JAVA
import com.querydsl.core.types.ExpressionUtils;
import com.querydsl.core.types.Predicate;

@NoArgsConstructor (access = AccessLevel.PRIVATE)
public class QPredicate {
    private final List <Predicate> predicates = new ArrayList <> ();
    
    public static QPredicate builder () {
        return new QPredicate ();
    }
    public <T> QPredicate add (T object, Function <T, Predicate> function) {
        if (object != null) {
            predicates.add (function.apply (object));
        }
        return this;
    }
    
    public Predicate buildAnd () {
        return ExpressionUtils.allOf (predicates);
    }
    
    public Predicate buildOr () {
        return ExpressionUtils.anyOf (predicates);
    }
}
```

\dto\ParameterFilter:
```
@Value
@Builder
public class PaymentFilter {
    
    String firstname;
    
    String lastname;
    
}
```

\dao\UserDao:
```JAVA
ublic Double findAveragePaymentAmountByFirstAndLastName (Session database, PaymentFilter filter) {
        var predicate = QPredicate.builder () // It often created on Service level and then Predicate will be given to this function. Also it is how Spring works (QuerydslPredicateExecutor)
                .add (filter.getFirstname (), QUserBestId.userBestId.personalInfo.firstname::eq)
                .add (filter.getLastname (), QUserBestId.userBestId.personalInfo.lastname::eq)
                .buildAnd ();
        
        return new JPAQuery <Double> (database)
                .select (QPayment.payment.amount.avg ())
                .from (QPayment.payment)
                .join (QPayment.payment.receiver, QUserBestId.userBestId) // JOIN users ON...
                //.join (QPayment.payment.receiver.company) // JOIN company ON...
                .where (QPayment.payment.receiver.personalInfo.firstname.eq (firstname)
                        .and (QPayment.payment.receiver.personalInfo.lastname.eq (lastname)))
                //.orderBy (QUserBestId.userBestId.personalInfo.birthDate.isNotNull ().asc ())
                .fetchOne () // When you SELECT AVG(column1)
                ;
    }
```

Runner:
```JAVA
PaymentFilter filter = PaymentFilter.builder () // Even if there is no lastname or firstname or both, it just will give different result from database (it is cool)
                .lastname ("Bill")
                .firstname ("Gates")
                .build ();
try (SessionFactory sessionFactory = HibernateUtil.buildSessionfactory ()) {
    try (Session session1 = sessionFactory.openSession ()) { // We are working with Database using session.
        Transaction transaction = session1.beginTransaction ();
        var listOfTuplesOfMinitables = UserDao.findAveragePaymentAmountByFirstAndLastName (session1, filter);
        session1.getTransaction ().commit ();
    }
}
```