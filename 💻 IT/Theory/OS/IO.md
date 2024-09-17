1) Polling - OS waits until the device is ready to receive a command by repeatedly reading the status register
2) OS sends some data down to the data register; one can imagine that if this were a disk, for example, that multiple writes would need to take place to transfer a disk block (say 4KB) to the device. When the main CPU is involved with the data movement (as in this example protocol), we refer to it as programmed I/O (PIO). 
3) OS writes a command to the command register; doing so implicitly lets the device know that both the data is present and that it should begin working on the command.
4) Polling - OS waits for the device to finish by again polling it in a loop, waiting to see if it is finished (it may then get an error code to indicate success or failure)










#                  Direct Memory Access (DMA)

When you want to write something to the I/O device, it will done as follow:
1) Write a data using CPU
2) Let I/O device write the data from the 1) into itself

DMA is used on the 1) step to handle this step instead of the CPU









#                  How to access the I/O device

There are 2 approaches:
* Use special Assembly instructions
* Store information in the specific RAM-Addresses