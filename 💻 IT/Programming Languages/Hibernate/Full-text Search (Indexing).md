```JAVA
@Entity
@Indexed //? You need add this for indexing to work
public class Book {
    @Id
    private Long id;

    @Field //? You need to add this above every column that needs an index
    private String title;

    @Field
    private String description;

    // getters and setters
}

// performing a search
FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
QueryBuilder queryBuilder = fullTextEntityManager.getSearchFactory()
        .buildQueryBuilder()
        .forEntity(Book.class)
        .get();
Query luceneQuery = queryBuilder
        .keyword()
        .onFields("title", "description")
        .matching("Hibernate Search")
        .createQuery();
FullTextQuery jpaQuery = fullTextEntityManager.createFullTextQuery(luceneQuery, Book.class);
List<Book> results = jpaQuery.getResultList();
```