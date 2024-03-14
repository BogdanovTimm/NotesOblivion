#                  What it is?

It is a banch of bits









#                  Page Fault

Page Fault - when OS can't find Physical Memory Address by a given Virtual Memory Address









#                  Why?

It is faster to work with a banch of bits then with the bits itself









#                  States

Types of states of a page:
- **Nonpageable** - Virtual RAM that can be accessed. Never will be written to a Swap (Pagefile) file. Never produce a Page Fault.
- **Mapped** - Virtual RAM that can be accessed
- **Unused** - Can't be accessed
- **Free** - nothing here, errors if trying to access. There is no mapping in the Map of Virtual RAM Address -> Physical RAM Address
- **Reserved** - same as Free, but allocating of this page only could bu done from the program that has reserved it. If you try to reserve memory that is already reserved, the operation will fail. Because x64 PCs has a lot of VIrtual Memory, you may reserve up to 16TB of Virtual Memory.
- **Committed** - Virtual RAM, that after using `malloc()`, **can** be used by the programm (except if age was paget out, but OS will dealt with it). It means that the Virtual RAM will be mapped to an actual Physical RAM after first Page Fault. It can be written to a Swap (Pagefile) file. It does not mean that the 1GB of a committed memory uses 10GB of a Physical RAM, because committed memory starts use of Physical RAM only when it is in actual use by the program.