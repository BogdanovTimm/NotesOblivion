#                  What it is

It is when:
- RAM is divided into pages (zones)
- Each bit in the RAM has its Virtual Representation (simillar to IPv4 and domain address)
- Map (table) of which RAM-bit is represented by which Virtual Memory-bit is created
- When your program needs to access Virtual Memory address that is not existed or is not free, OS will copy (evict) data from some Virtual Address to a swap-space and then write it to this Virtual Memory address

It includes:
- Swap-space