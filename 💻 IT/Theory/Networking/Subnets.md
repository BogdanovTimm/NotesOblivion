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
| | host1 |  | host3 | |
| | host2 |  | host4 | |
| +-------+  +-------+ |
+----------------------+
```
What it does:
* Allows creation of eararchy of IP-Addresses
* Allows to reuse IP Addresses