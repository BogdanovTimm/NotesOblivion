# Problems

Types of problems:
- Dirty reads - thread1 updates a row and leaves it uncommitted, meanwhile, thread2 reads the updated row. If thread1 rolls back the change, thread2 will have read data that is considered never to have existed.
- Non-repetable reads -  thread1 reads data, while thread2 updates the same data and commit. Now, if thread1 rereads the same data, it will retrieve a different value.
- Phantom reads - like non-repeatable reads, but when we create a new row, instead of change an existing one

# Isolation levels

1. Read Uncommitted - Dirty reads, Non-repeatable reads and Phantom reads may occur (the most fast one)
2. Read Committed - Non-repeatable reads and Phantom reads may occur
3. Repeatable Read - Phantom reads may occur (creates something like a snapshot of a database's state at the start of a transaction and works with it (yep, thread1 will not see changes, made by other threads unless thread1 finishes transaсtion))
4. Serializable - non of problems may occur (the most slowest one - just do everything sequentially (not in parallel))