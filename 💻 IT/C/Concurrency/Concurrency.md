#                  Do

- Use `_Atomic()`

There are no atomic array types. 

#                  call_once()

- Shared objects with static storage duration are initialized before any execution. 
- Shared objects with automatic or allocated storage duration can be properly initialized by the thread that creates them before any shared access occurs. 
- Shared objects with static storage duration where the information for dynamic initialization is 
    - Available at startup time should be initialized by main before any other thread is created. 
    - Not available at startup time must be initialized with call_once.  Any usage of that variable should be prefixed with a call to call_once that uses the same once_flag (here, errlog_flag) and the same callback function (here, errlog_fopen). 

    3.18.2.1 A properly initialized FILE* can be used race-free by several threads. Here, race-free only means your program will always be in a well-defined state; it does not mean your file may not contain garbled output lines originating from different threads. To avoid that, you’d have to make sure a call to fprintf or similar always prints an entire line. Takeaway 3.18.2.2 Concurrent write operations should print entire lines at once. 

The best way to access data local to threads is to use local variables: Takeaway 3.18.3.1 Pass thread-specific data through function arguments. Takeaway 3.18.3.2 Keep thread-specific state in local variables. 
In case this is not possible (or maybe too complicated), a special storage class and a dedicated data type allow us to handle thread-local data. _Thread_local is a storage class specifier that forces a thread-specific copy of the variable that is declared as such. The header threads.h also provides a macro thread_local, which expands to the keyword. <threads.h> Takeaway 3.18.3.3 A thread_local variable has one separate instance for each thread. That is, thread_local variables must be declared similar to variables with static storage duration: they are declared in file scope, or, if not, they must additionally be declared static (see subsection 13.2, table 13.1). As a consequence, they cannot be initialized dynamically. 3.18.3.4 Use thread_local if initialization can be determined at compile time. 

If a storage class specifier is not sufficient because we have to do dynamic initialization and destruction, we can use thread-specific storage, tss_t. It abstracts the identification of thread-specific data into an opaque ID, referred to as key, and accessor functions to set or get the data:

# Mutex (full lock)

Use mutex only if you have variable that must be created at runtime

Every mutex must be initialized with mtx_init.