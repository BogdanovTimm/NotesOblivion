#                  Writing a file to a disk

When you writing a file, OS first stores it into the Buffer in the RAM. 

You must use `fsync()` to this file AND its directory if you want it to be written to HDD right now!