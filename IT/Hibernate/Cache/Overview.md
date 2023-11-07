# How does the cache works

Stages of .find ():
1. you use .find () to get some row from a table.
2. Hibernate tries to find it in 1st level cache
3. If he didn't find it in 1st level cache, it tries to find it in 2nd level cache
4. If he didn't find it in both caches - only then it tries to find it in the databse