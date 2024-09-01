#                   What it is? 

It is when 1 core of CPU is non-parallelly runs more tgan 1 program. 

It works like this:
1) OS starts a timer for a few milliseconds
2) OS runs some program 1
3) When timer is off, program 1 returns control to the OS
4) OS saves context (arguments, etc) of a program 1 
5) OS desides whether to:
    * Return control back to program 1:
        1) OS starts a timer for a few milliseconds
        2) OS runs some program 1
        3) When timer is off, program 1 return control to the OS
        4) Back to 4)
    * Give control to a program 2:
        1) OS perform a context switch (saves arguments, etc from pgrogram 1 and loads arguments, etc of program 2)
        2) OS starts a timer for a few milliseconds
        3) OS runs some program 2
        4) When timer is off, program 2 return control to the OS
        5) Back to 4)









#                  Scheduler

Scheduler has queues that has different priorities. 

* If Process1 is in queue which priority is greater than queue in which Process 2 recides, then Process 1 is chosen
* If Process1 and Process2 both recide in same queue, then Process1 and Process2 will be run in Round-Robin
* If Process1 is just started, it goes into the queue with the highest priority
* If Process1 will use CPU for too long without starting I/O operation - it will be plased into queue with less prioroty
* If Process1 will use CPU shortly, starting I/O periodically, but it also will be placed in the queue with less priority, because it uses too much CPU in total
* Once in a time, move all Processes to the highest queue (for the most CPU-aggressive without I/O to do some progress) 


The key to MLFQ scheduling therefore lies in how the scheduler sets priorities. Rather than giving a fixed priority to each job, MLFQ varies the priority of a job based on its observed behavior. If, for example, a job repeatedly relinquishes the CPU while waiting for input from the key-board, MLFQ will keep its priority high, as this is how an interactive process might behave. If, instead, a job uses the CPU intensively for long periods of time, MLFQ will reduce its priority. In this way, MLFQ will try to learn about processes as they run, and thus use the history of the job to predict its future behavior. 

Linux, btw, uses another scheduler:
* It stores all active (not waiting for I/O, etc) processes into a Red-Black-Tree (because it is fast to find the least number and then increase it and store it back in another place) using their time that they actively used CPU
1) It finds Process that have least active CPU-usage time
2) It runs it for a time, calculated using its peiority
3) Process runs for a given time
4) It saves this Process' new active CPU-usahe time into a Red-Black-Tree
5) Go to 1)
