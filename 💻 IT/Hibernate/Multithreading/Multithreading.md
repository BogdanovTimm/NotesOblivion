# Isolation levels in Hibernate

- Read committed - default one. Safes from:
    - Lost Update
    - Dirty Read
- Serializable - safes from:
    - Lost Update
    - Dirty Read
    - Nonrepeatable Read
    - Phantom Read

***

# Types of LockModeType

- OPTIMISTIC:
    - VERSION - you need to create another column in the table to account the version of every row. If 2 threads simultaneously have changed some row - application will see that the version of the row was changed, so first one who has changed the row changes it, seccond one gets OptimisticLockException
    - ALL - do not use it
    - DIRTY - do not use it
- OPTIMISTIC\_FORCE\_INCREMENT - Do not use it. same as OPTIMISTIC, but forces the increment of version.
- PESSIMISTIC_READ - if some session is working with some rows - blocks them and force another session to wait untill first session finishes its work or until some timeout has passed.
- PESSIMISTIC_WRITE - like READ, but more strict than READ
- PESSIMISTIC\_FORCE\_INCREMENT - like OPTIMISTIC\_FORCE\_INCREMENT, but with waiting form PESSIMISTC. it needs only if you need to change versions of
- WRITE - outdated one
- READ - outdated one