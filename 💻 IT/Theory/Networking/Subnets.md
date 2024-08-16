#                  What it is

Adds 3d logical entity into Network-Structure - Subnets by interpreting host ID part of the IP-Address as 2 numbers: 
* Subnet ID
* Host ID

So, now we have:
```
        Network
+----------------------+
|  Subnet1    Subnet2  |
| +-------+  +-------+ |
| | Host1 |  | Host3 | |
| | Host2 |  | Host4 | |
| +-------+  +-------+ |
+----------------------+
```
What it does:
* Allows creation of eararchy of IP-Addresses
* Allows to reuse IP Addresses

To represent subnets, it uses Subnet-Mask:
```
11111111 . 11111111  .  11110000 . 00000000
'-----------------'     '--''-------------'
         |               |         |
    Network_ID       Subnet_ID  Host_ID
 (automatically
   calculated)
```









#                  Variable Length Subnet Masking

It allows you to do:
```
                       Network
        Subnet1                      Subnet4
+----------------------+     +----------------------+
|  Subnet2    Subnet3  |     |                      |
| +-------+  +-------+ |     |        Host5         |
| | Host1 |  | Host3 | |     |        Host6         |
| | Host2 |  | Host4 | |     |        Host7         |
| +-------+  +-------+ |     |                      |
+----------------------+     +----------------------+
```