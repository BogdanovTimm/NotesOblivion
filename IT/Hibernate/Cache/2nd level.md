It is a single cache (fragmented on regions) for sesison facotry (so, because we have only 1 sessionFactory, there is only 1 2nd level cache)\

By default it is not working.

When to use:

- Tables that rarely changes:
    - Language catalogs
    - States catalogs

When not to use:

- Tables that often changes:
    - Stock exchanges

# Installation

build.gradle:
```GROOVY
implementation 'org.hibernate:hibernate-jcache:5.5.7.Final'
implementation 'org.ehcache:ehcache:3.9.7'
```

hibernate.cfg:
```
<property name="hibernate.cache.use_second_level_cache">true</property>
<property name="hibernate.cache.region.factory_class">org.hibernate.cache.jcache.internal.JCacheRegionFactory</property>
```
