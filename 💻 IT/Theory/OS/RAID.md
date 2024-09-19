#                  What it is

It is a way to use multiple HDD disks as a one.

##                 Benefits

Benefits:
* You don't need to change your programms









#                  RAID types

## RAID Level 0: Stripping

Store 1 file partiaaly across all HDDs (parallelism).

It is hard to determine the right chunk size: 
* Small chunk size - many files will get striped across many disks, thus increasing the parallelism of reads and writes to a single file; however, the positioning time to access blocks across multiple disks increases, because the positioning time for the entire request is determined by the maximum of the positioning times of the requests across all drives. 
* Big chunk size - reduces such intra-file parallelism, and thus relies on multiple concurrent requests to achieve high throughput. However, large chunk sizes reduce positioning time; if, for example, a single file fits within a chunk and thus is placed on a single disk, the positioning time incurred while accessing it will just be the positioning time of a single disk.

## RAID Level 1: Mirroring

???

## RAID Levels 4/5: Parity-Based Redundancy 

???