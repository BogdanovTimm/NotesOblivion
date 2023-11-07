1 Create a concrete Dao:
```JAVA
public class RepositpryDao extends RepostoryDao <Long, Payment> {    
    public PaymentDao (SessionFactory sessionFactory) {
        super (sessionFactory, Payment.class);
    }
}
```