#                  What it is?

Sometimes you need to know either:
- which arguments was passed to some process
- which process was runned with specific argument









#                  Code

`ps -ef` - see all processes and their arguments

`ps -ef |grep ^argument^` - find process to which ^argument^ was passed

`ps -fp xPIDX` - find by PID