#                  What it is

It is a way to use multiple HDD disks as a one.

##                 Benefits

Benefits:
* You don't need to change your programms









#                 RAID Level 0: Stripping

Store 1 file (A, B, C, D) partially across all HDDs (parallelism):
```
        Disk1                 Disk2                Disk3                 Disk4        
+------------------+  +------------------+ +------------------+  +------------------+
|         A1       |  |        A2        | |        B1        |  |        B2        |
|         C1       |  |        C2        | |        D1        |  |        D2        |
+------------------+  +------------------+ +------------------+  +------------------+
```

It is hard to determine the right chunk size: 
* Small chunk size - many files will get striped across many disks, thus increasing the parallelism of reads and writes to a single file; however, the positioning time to access blocks across multiple disks increases, because the positioning time for the entire request is determined by the maximum of the positioning times of the requests across all drives. 
* Big chunk size - reduces such intra-file parallelism, and thus relies on multiple concurrent requests to achieve high throughput. However, large chunk sizes reduce positioning time; if, for example, a single file fits within a chunk and thus is placed on a single disk, the positioning time incurred while accessing it will just be the positioning time of a single disk.









#                 RAID Level 1: Mirroring (Copying)

Store copies of a file on other HDDs:
```
        Disk1                 Disk2            Disk3 (Disk1 copy)    Disk4 (Disk2 copy)
+------------------+  +------------------+    +------------------+  +------------------+
|        A1        |  |        A1        |    |        A2        |  |        A2        |
|        B1        |  |        B1        |    |        B2        |  |        B2        |
+------------------+  +------------------+    +------------------+  +------------------+
```

Reading and writing:
* File may be read from either of disks it placed
* File must be written to both disks where it must be placed
* Writing speed is same as in no-RAID disk








#                 RAID 10: Stripe of Mirrors

Mirror 1 file across disks. Then Stripe it across other disks:
```
        Disk1          Disk2 (Disk1 copy)             Disk3          Disk4 (Disk3 copy)
+------------------+  +------------------+    +------------------+  +------------------+
|        A1        |  |        A1        |    |        A2        |  |        A2        |
|        B1        |  |        B1        |    |        B2        |  |        B2        |
+------------------+  +------------------+    +------------------+  +------------------+
```









#                 RAID 01: Mirror of Striptes

Stripe a file across other disks. Then mirror it on others:
```
        Disk1                 Disk2            Disk3 (Disk1 copy)   Disk4 (Disk2 copy)
+------------------+  +------------------+    +------------------+  +------------------+
|        A1        |  |        A2        |    |        A1        |  |        A2        |
|        B1        |  |        B2        |    |        B1        |  |        B2        |
+------------------+  +------------------+    +------------------+  +------------------+
```









# RAID Levels 4: Parity-Based Redundancy 

RAID4 is slow on random writes because of the calculating of Parity-Bit.

Parity disk calculates how much 1s in the same block of data on each disks:
```
        Disk1                 Disk2                Disk3                Parity Disk     
+------------------+  +------------------+ +------------------+    +------------------+
|        A1        |  |        B1        | |        C1        |    |    Parity-Bit1   |
|        A2        |  |        B2        | |        C2        |    |    Parity-Bit2   |
+------------------+  +------------------+ +------------------+    +------------------+
```

##                How Parity is calculated:

If we have such data stored on disks:
```
        Disk1                 Disk2                Disk3                Parity Disk    
+------------------+  +------------------+ +------------------+    +------------------+
|       0000       |  |       0001       | |       0011       |    |       eeoe       |
|       1111       |  |       1110       | |       1100       |    |       ooeo       |
+------------------+  +------------------+ +------------------+    +------------------+
```

We must:
1) Take bits from the same line on every disk
2) Find whether there is even (`e`) or odd (`o`) 1s in the column using `XOR`. For example, for the 1st row:
```
0000
0001
0011
----
eeoe
```
3) `ooee` - is a parity for a given line!

##                How parity is used

When the one of disks will die (If more than 1 die - we can't do nothnig about it!) - we can resotre its data by:
1) Getting the row from all other disks
2) Calculating whether we have even or odd number of 1s now
3) Checking Parity-Bit for each row:
    * If Parity-Bit is even:
        * If now we have even number of 1s - then, we restore 0
        * If now we have odd number of 1s - then, we restore 1
    * If Parity-Bit is odd:
        * If now we have even number of 1s - then, we restore 1
        * If now we have odd number of 1s - then, we restore 0










# RAID Level 5: Parity-Based Redundancy 


RAID5 is identical to RAID4, except that it does not uses Parity disk, but it places Parity-Bits across disks:
```
        Disk1                 Disk2                Disk3               Disk 4     
+------------------+  +------------------+ +------------------+ +------------------+
|        A1        |  |        B1        | |        C1        | |    Parity-Bit1   |
|        A2        |  |        B2        | |    Parity-Bit2   | |        D1        |
|        A3        |  |    Parity-Bit3   | |        C2        | |        D2        |
|    Parity-Bit4   |  |        B3        | |        C3        | |        D3        |
+------------------+  +------------------+ +------------------+ +------------------+
```

RAID-5 performs quite poorly when there are small writes in the workload.

Because RAID-5 is basically identical to RAID-4 except in the few cases where it is better, it has almost completely replaced RAID-4 in the marketplace. The only place where it has not is in systems that know they will never perform anything other than a large write, thus avoiding the smallwrite problem altogether; in those cases, RAID-4 is sometimes used as it is slightly simpler to build.









#                  Write-ahead log

If the data was written to a disk1, but not to the disk2 (e.g. due to the crash) - then, now, the data is inconsistent. To solve this problem we need to write 'I will write data to the disk1 and disk2' before every write operation. Then, after finishing writing, we must write 'I finished writing data to the disk1'. Now we know that data was not written to the disk2, though it must be.

If it is found that the data need to be written to some disk, but it was not done - then recovery process starts.