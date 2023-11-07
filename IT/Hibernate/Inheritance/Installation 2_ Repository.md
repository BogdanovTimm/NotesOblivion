1. Add this to hibernate.cfg:
```XML
<property name="hibernate.current_session_context_class">thread</property>
```
2. Create a Repostory Interface:
```JAVA
public interface Repostory <GivenIdClass extends Serializable, GivenEntityClass extends BaseEntity> {
    
    GivenEntityClass save (GivenEntityClass entity);
    
    void update (GivenEntityClass entity);
    
    void delete (GivenIdClass id);
    
    Optional <GivenEntityClass> findById (GivenIdClass id);
    
    List <GivenEntityClass> findAll ();
}

```
3. Create RepostoryBase abstract class:
```JAVA
@RequiredArgsConstructor
public abstract class RepositoryBase <GivenIdClass extends Serializable, GivenEntityClass extends BaseEntity> implements Repository <GivenIdClass, GivenEntityClass> {
    private final EntityManager entityManager;
    private final Class <GivenEntityClass> clazz;
    @Override
    public GivenEntityClass save (GivenEntityClass entity) {
         entityManager.persist (entity);
        return entity;
    }
    @Override
    public void update (GivenEntityClass entity) {
         entityManager.merge (entity);
    }
    @Override
    public void delete (GivenIdClass id) {
         entityManager.remove (id);
         entityManager.flush ();
    }
    @Override
    public Optional<GivenEntityClass> findById (GivenIdClass id) {
        return Optional.ofNullable (entityManager.find (clazz, id));
    }
}
```
4. Create a concrete Repository:
```JAVA
public class PaymentRepository extends RepositoryBase<Long, Payment> {
    
    public PaymentRepository (EntityManager entityManager) {
        super (entityManager, Payment.class);
    }
}
```