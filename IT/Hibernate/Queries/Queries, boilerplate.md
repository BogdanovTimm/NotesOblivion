Also, dmdev used some Hibernate code as some DAO class, and in that video he open SessionFecotry in TestRunner, and in DAO there were only `database1.createQuery ()` and so on

There must be only 1 SessionFactory in your application (just like an ConnectionPool)

You can see a lot of try-with-resources, catch and so on and so on. In Spring, there is a thing that handles this, so, this variant is an outdated one. Use it for this course, but then it all will not be needed and you can just write simple queries or a QueryDSL ones.

```JAVA
public class HibernateRunner {
    private static final Logger log = LoggerFactory.getLogger (HibernateReunner.class);

    public void main (String [] args) {
        try ( // Same sessionFactory for all sessions with database
            SessionFactory sessionFactory = HibernateUtil.buildSessionfactory ();
        ) {
            try ( // First Session with database1
                Session database1 = sessionFactory.openSession ();
            ) {
                var transaction = database1.beginTransaction ();
                // Here you can add your CRUD-operations, HQL queries/Criteria API ---v
                database1.saveOrUpdate (table1_raw1);
                var result= database1.createQuery (
                                                   "%HQL QUERY",
                                                   Table1 // Datatype of the output form get
                                                  )
                                     .list ();
                log.trace ("User is in persistend state: {}, session {}", user, session1);
                // Here you can add your CRUD-operations, HQL queries/Criteria API ---^
                database1.getTransaction ().commit ();
            } catch (Exception exception) {
                log.error ("Exception occured", exception);
                session.getTransaction ().rollback (); 
                throw  exception;
            } 
            try (  // Second session with database1
                Session database1_1 = sessionFactory.openSession ();
            ) {
                database1_1.beginTransaction ();
                var table2_raw1 = database1_1.get (Table2.class, 1);
                table2_raw1.getColumn2 ().add ("Lorem Ipsum");
                session2.getTransaction ().commit ();
            }
        }
    }
}
```

# Multithreading

```JAVA
try (SessionFactory sessionFactory = HibernateUtil.buildSessionfactory ()) {
            var session = (Session) java.lang.reflect.Proxy.newProxyInstance ( // For multithreading to create a new Session with Database for every thread
                    SessionFactory.class.getClassLoader (),
                    new Class[] {Session.class},
                    (proxy, method, args1) -> method.invoke (
                            sessionFactory.getCurrentSession (), args
                    ));
            var transaction = session.beginTransaction ();
            // Working with database ---v
            var paymentRepository = new PaymentRepository (session);
            paymentRepository.save (Payment.builder()
                                           .amount (100)
                                           .receiver (session.find (UserBestId.class, 2L))
                                           .build());
            // Working with database ---^
            session.getTransaction ().commit ();
        }
```