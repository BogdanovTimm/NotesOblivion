#                Thread context switch

With processes, we saved state to a process control block (PCB); now, we’ll need one or more thread control blocks (TCBs) to store the state of each thread of a process. 

There is one major difference, though, in the context switch we perform between threads as compared to processes: the address space remains the same (i.e., there is no need to switch which page table we are using).









#                 RAM

However, in a multi-threaded process, each thread runs independently and of course may call into various routines to do whatever work it is do-ing. Instead of a single stack in the address space, there will be one per thread. Let’s say we have a multi-threaded process that has two threads in it; the resulting address space looks different (Figure 26.1, right).
In this figure, you can see two stacks spread throughout the address space of the process. Thus, any stack-allocated variables, parameters, re-turn values, and other things that we put on the stack will be placed in what is sometimes called thread-local storage, i.e., the stack of the rele-vant thread.









#                  Threads and Heap

Heap is used to pass the inputs and outputs between threads. Always return values from threads that are placed in the Heap! If the value woukd be in stack - it will be destroyed after thread is dead and you will be getting value from a bad place!









#                  Example of using a thread

```C
typedef struct { int a; int b; } ThreadInputs;  // Keeps thread's inputs if there is more than 1 value
typedef struct { int x; int y; } ThreadOutputs; // Keeps thread's output if there is more than 1 value

void* function1(void* arg) { // Must take [void*] and must return [void*]
    ThreadOutputs* thread_output = Malloc(sizeof(ThreadOutputs)); // It must be in Heap
    thread_output->x = 1;
    thread_output->y = 2;
    return (void *) thread_output; // It must be cast to [void*] and must be in Heap
}




int main(int argc, char *argv[]) {
    pthread_t       thread1;                    // Thread representation
    ThreadOutputs*  thread_output;              // Struct that represents thread's outputs in Heap
    ThreadInputs    thread_inputs = { 10, 20 }; // Struct that represents thread's inputs
    Pthread_create(&thread1,                    // Thread to bind the function with
                   NULL,                        // Thread's settings (NULL = defaults)
                   function1,                   // Function to run in thread
                   &thread_inputs               // Inputs for the function1, stored in Stack
    );
    Pthread_join(thread1,                       // Thread representation to wait for
                 (void **) &thread_output       // Where to store the thread's output
    );
    printf("returned %d %d\n", 
           thread_output->x, 
           thread_output->y
    );

    free(thread_output);
    return 0;
}
```