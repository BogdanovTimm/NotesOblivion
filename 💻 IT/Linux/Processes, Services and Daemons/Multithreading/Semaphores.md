#                  What it is?

It is a counter for multiple processors to synchronize their use of a shared resources.

##                 Types of Semaphores in Linux

Types of semaphores:
- System V IPC
- POSIX:
    - named
    - unnamed (memory-based)









#                  Diagnostic

- `ipcs -s` - shows active System V IPC semaphores
- `ipcs -m` - shows active shared memory segments
- `ipcs -q` - shows active message queues

- `lsipc` - shows active System V IPC semaphores
- `ls -1 /dev/shm` - shows POSIX Named semaphores
- `vim -M /proc/sys/kernel/sem` - shows: 
    - SEMMSL - Max number of Semaphores in 1 semaphore set
    - SEMMNS - Total number of Semaphores (should not be more than Max number of Semaphores in 1 semaphore set * Number of Semaphores set)
    - SEMOPM - Maximum number of semaphores that may be used by 1 `semop()` function in the programm's original code
    - SEMMNI - Maximum number of Semaphore sets






#                  Working with Semaphores

`semop(semaphore_id, increase_or_decrease)` - use it
`semget()` - creates a new semaphore
`semctl(semaphore_id, semaphore_number, increase_or_decrease)` - control semaphore