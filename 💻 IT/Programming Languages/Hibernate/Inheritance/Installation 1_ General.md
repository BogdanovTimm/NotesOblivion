# Installation

1.  `Project Structure\Modules`
2.  `+` \- click on
3.  Choose `Hibernate`
4.  Within Hibernate click on `+`
5.  Choose `hibernate.cfg.xml`
6.  Move it to `resources` folder
7.  `File\Settings\Editor\Inspections`
8.  `Serrializable class without 'serialVersionUId'` \- check it
9.  Create `\src\,main\java\org\example\util\HibernateUtil and add this:
```JAVA
@UtilityClass
public class HibernateUtil {
    public static SessionFactory buildSessionfactory () { // Sets SessionFactory for Hibernate
        Configuration configuration = buildConfiguration ();
        configuration.configure (); // Configures the configuration. You can give it a path to hibernate.cfg.xml. But, by default it searches for it in the root directory, so by default is good.
        return configuration.buildSessionFactory ();
    }
    
    public static Configuration buildConfiguration () {
        Configuration configuration = new Configuration ();
        configuration.setPhysicalNamingStrategy (new CamelCaseToUnderscoresNamingStrategy ());
        
        // Databases ---v
        configuration.addAnnotatedClass (Database1.class); // You need to add all databases like that
        // Databases ---^
        // Custom datatype converters ---v

        // configuration.addAttributeConverter (new BirthdayConverter ()); // Add Custom Converter for Birthday class
        // Custom datatype converters ---^

        // Pre-made datatypes that exist in PostgreSQL, but doesn't exist in Java---v
        // configuration.registerTypeOverride (new JsonBinaryType ());
        // Pre-made datatypes that exist in PostgreSQL, but doesn't exist in Java---^
        return configuration;
    }
}
```
10. Create a BaseEntity Interface:
```JAVA
public interface BaseEntity {
}
```
11. 