#                Thread context switch

With processes, we saved state to a process control block (PCB); now, we’ll need one or more thread control blocks (TCBs) to store the state of each thread of a process. There is one major difference, though, in the context switch we perform between threads as compared to processes: the address space remains the same (i.e., there is no need to switch which page table we are using).

#                 RAM

However, in a multi-threaded process, each thread runs independently and of course may call into various routines to do whatever work it is do-ing. Instead of a single stack in the address space, there will be one per thread. Let’s say we have a multi-threaded process that has two threads in it; the resulting address space looks different (Figure 26.1, right).
In this figure, you can see two stacks spread throughout the address space of the process. Thus, any stack-allocated variables, parameters, re-turn values, and other things that we put on the stack will be placed in what is sometimes called thread-local storage, i.e., the stack of the rele-vant thread.