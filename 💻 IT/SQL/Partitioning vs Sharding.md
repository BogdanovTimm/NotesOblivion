#                Partitioning

There are 2 definitions of partitioning:
- It is every redistribution of the tables (so, sharing will be a kind of partitioning)
- It is a particular redistribution within single machine

Scalability - bad, because it is difficult to add new CPU or RAM or HDD to a single machine

Availability - bad, because if machine dies - all rows dies with it.

Query time - bad, because if some core is slow - others also will be affected.








#               Sharding

Redistribution of rows of a table over multiple machines.

Scalability - good, because it is easy to add new machine

Availability - good, because if 1 machine dies - others still work

Query time - good, because if 1 machine is slow - others will not be affected









#               When to sharding or partitioning?

If you table is larger than 2Gb