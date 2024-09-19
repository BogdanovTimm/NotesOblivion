#                  `strace`

strace:
* `-f` - follows programm's children
* `-e trace=open,close,read,write` - only traces calls to those system calls and ignore others
* `-t` - also logs time of day