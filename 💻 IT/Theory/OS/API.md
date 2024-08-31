API allows to call system calls using C programming language :
* `fork()` create a new thread and run it concurrently with the parent thread, starting from the line it was called
* `exec()` - run another bibary file
* `wait()` - parent thread uses it to wait untill its child executes
* `kill()` - used to send signals to a process, including directives to pause, die, and other useful imperatives. For convenience, in most UNIXshells, certain keystroke combinations are configured to deliver a specific signal to the currently running process; for example, control-c sends a SIGINT (interrupt) to the process (normally terminating it) and control-z sends a SIGTSTP (stop) signal thus pausing the process in mid-execution (you can  it later with a command, e.g., the 
* `fg()` - resume 