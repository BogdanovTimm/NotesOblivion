#                  Working with Heap-RAM-Space

##                 Dividing it on variable-sized peaces

Coalesing - where you `free()` some Addresses back to the OS and OS not only backs it, but also concatenates it with the Addresses near it to defragment the RAM.
Example without the coalesing:
```
1. [ 000000000000 ] - RAM with 1 chunk of free 12 bytes
2. [ 1111 00000000] - Application uses 1 chunk of 4 bytes of memory, there is 1 chunk with 84bytes of free memory
3. [1111 0000 1111] - Application uses 2 chunks of 4 bytes of memory, there is 1 chunk with 4 byte sof free memory
4. [0000 0000 0000] - There is 3 chunks of free 4 bytes.
```
If we will ask for 5 bytes of memory after the 4th step - OS will give us an error, becuase there is no 1 chunk of 5 bytes offree memeory
Now with coalesin:
```
1. [ 000000000000 ] - RAM with 1 chunk of free 12 bytes
2. [ 1111 00000000] - Application uses 1 chunk of 4 bytes of memory, there is 1 chunk with 84bytes of free memory
3. [1111 0000 1111] - Application uses 2 chunks of 4 bytes of memory, there is 1 chunk with 4 byte sof free memory
4. [ 000000000000 ] - RAM with 1 chunk of free 12 bytes
```
After coalesing, we again have the 1 chunk of 12 free bytes









##                 Dividing it on fixed-sized peaces (paging)

Page table - per-process data structure used by the Operating System to record where each virtual page of the address space is placed in physical memory. The major role of the page table is to store address translations for each of the virtual pages of the address space, thus letting us know where in physical memory each page resides.

###                TLB

TLB aka translation-lookaside buffer - part of the chip’s memory-management unit (MMU), and is simply a hardware cache of popular virtual-to-physical address translations; thus, a better name would be an address-translation cache. 

Upon each virtual memory reference, the hardware first checks the TLB to see if the desired translation is held therein; if so, the translation is performed (quickly) without having to consult the page table (which has all translations).









#                  SWAP

Paging out - it is when some RAM-Addresses are evicted (moved) into the SWAP space

##                 Dirty Pages

Dirty pages is a page, data in which was modifyed while being in the RAM. It means that if this dirty page will be evicted (written to the SWAP space) - they will be written to the Hard Disk, which is slow.
So, Operation Systems usually prefer to evict clean pages first, because it is simply faster.









#                  Page fault

Page fault - it is when a program tries to access a RAM Address and it either:
* Occurs to be in the SWAPspace on the disk
* Accessing this RAM Address is illegal