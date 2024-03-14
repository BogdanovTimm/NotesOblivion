#                  Terms

- **Memory Address Sapce** - something to keep a bit
- **Physical Memory** aka **Valid** - Physical storage for bits
- **Virtual Memory** aka **Address Space** - table of mappings from Virtual Memory Address Space to a Physical Memory Address Spaces.  In a 64-bit system, the virtual memory address space can theoretically address up to 2^64 (~17.4 million TB of memory). However, Windows 64-bit currently supports only ~16TB
- **Page** - some amount (4KiB) of Virtual Memory Address Space
- *(Page)* **Frame** - some amount (4KiB) of Physical Memory Address Space
- **Working Set** - **Pages**, that are actively use Physical Memory right now by some application
- **Resident Pages** - the ones in the **Working Set** and in-RAM (as opposed to be in a Swap space (Pagefile))
- **Mapping** - find **Physical RAM** for a given **Virtual RAM**









#                  What it is

It is when:
- RAM is divided into pages (zones)
- Each bit in the RAM has its Virtual Representation (simillar to IPv4 and domain address)
- Map (table) of which RAM-bit is represented by which Virtual Memory-bit is created
- When your program needs to access Virtual Memory address that is not existed or is not free, OS will copy (evict) data from some Virtual Address to a swap-space and then write it to this Virtual Memory address

It includes:
- Swap-space

#                  Read again

Delving Deep into Windows Memory Management by Roahim REounane MELLAH on LinkedIn