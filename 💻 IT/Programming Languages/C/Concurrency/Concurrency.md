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

The second parameter of mtx_init specifies the “type” of the mutex. It must be one of these four values:
• mtx_plain • mtx_timed • mtx_plain|mtx_recursive • mtx_timed|mtx_recursive As you probably have guessed, using mtx_plain versus mtx_timed controls the possi-bility to use mtx_timedlock. The additional property mtx_recursive enables us to call mtx_lock and similar functions successively several times for the same thread, without unlocking it beforehand.
Takeaway 3.18.4.3 A thread that holds a nonrecursive mutex must not call any of the mutex lock functions for it.
The name mtx_recursive indicates that it is mostly used for recursive functions that call mtx_lock on entry of a critical section and mtx_unlock on exit.
Takeaway 3.18.4.4 A recursive mutex is only released after the holding thread issues as many calls to mtx_unlock as it has acquired locks.
Takeaway 3.18.4.5 A locked mutex must be released before the termination of the thread.
Takeaway 3.18.4.6 A thread must only call mtx_unlock on a mutex that it holds.
From all of this, we can deduce a simple rule of thumb:
Takeaway 3.18.4.7 Each successful mutex lock corresponds to exactly one call to mtx_unlock.

Every mutext must be destroyed using mtx_destroy. It must be called • Before the scope of a mutex with automatic storage duration ends • And before the memory of a dynamically allocated mutex is freed

Threads should preferably only operate on data that is local, through function arguments and automatic variables. If unavoidable, thread-specific data can also be created as thread_local objects or via tss_create. Use the latter only when you need dynamic construction and destruction of the variable.
• Small critical data that is shared between threads should be specified as _Atomic.
• Critical sections (code paths that operate on unprotected shared data) must be protected, usually by using a mtx_t mutex.
• Conditional processing dependencies between threads are modeled with cnd_t condition variables.
• Thread code that does not have the ability to rely on a post mortem cleanup by main should use thrd_detach and place all its cleanup code in atexit and/or at_quick_exit handlers.

3.19.2.5 Calls to cnd_signal and cnd_broadcast should occur inside a critical section that is protected by the same mutex as the waiters. 