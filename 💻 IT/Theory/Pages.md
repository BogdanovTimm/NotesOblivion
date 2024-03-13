#                  What it is?

It is a banch of bits









#                  Why?

It is faster to work with a banch of bits then with the bits itself









#                  States

Types of states of a page:
- **Free** - nothing here, errors if trying to access. There is no mapping in the Map of Virtual RAM Address -> Physical RAM Address
- **Reserved** - same as Free, but allocating of this page only could bu done from the program that has reserved it.
- **Committed** - after using `malloc()`, can be used by the programm (except if age was paget out, but OS will dealt with it)