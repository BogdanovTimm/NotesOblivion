#                  What it is



#                  What parts does it have?

Here you can from what a MinIO CLuster consist of, where: 
* `----` - Physical Devices
* `- - ` - Logical Entities
```
+-   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   +
                                    Cluster-Deploment-Site                                 
| +-   -   -   -   -   -   -   -   -   -   -+    +-   -   -   -   -   -   -   -   -   -   -+ |
                 Server-Pool-1                                  Server-Pool-2                  
| | +-----------------+ +-----------------+ |    | +-----------------+ +-----------------+ | |
    |    PC-Node-1    | |    PC-Node2     |        |    PC-Node-3    | |    PC-Node-4    |
| | | +-----+ +-----+ | | +-----+ +-----+ | |    | | +-----+ +-----+ | | +-----+ +-----+ | | |
    | |HDD-1| |HDD-2| | | |HDD-3| |HDD-4| |        | |HDD-5| |HDD-6| | | |HDD-7| |HDD-8| | 
| | | +-----+ +-----+ | | +-----+ +-----+ | |    | | +-----+ +-----+ | | +-----+ +-----+ | | |
    +-----------------+ +-----------------+        +-----------------+ +-----------------+ 
| +-   -   -   -   -   -   -   -   -   -   -+    +-   -   -   -   -   -   -   -   -   -   -+ |
+-   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   +
```

##                 How to change your Cluster

Once the Server-Pool is createxd, you can't change it. Only that you can do is
1) Create a new one
2) Copy all data from the old one 
3) Delete the old one


##                 Server-Pool

If multiple Server-Pools available - object always writes to the same Erasure-Set in the same Server-Pool.
If one Server-Pool goes down, MinIO halts I/O to all Server-Pools until the Cluster resumes normal operations. Objects written to other Server-Pools remain safe on disk while you perform repair operations.

For multi-Server-Pool MinIO deployments, each Server-Pool requires at least one Erasure-Set maintaining Read/Write-Quorum to continue performing operations.
If even 1 Server-Pool lost all its Erasure-Sets - then MinIO stops all read/writes operations in the Deployment (Cluster, Site) - If one Server-Pool loses all Erasure-Sets, MinIO can no longer determine whether a given read/write operation would have routed to that Server-Pool to keep the objects in the same bucket on the same Server-Pool.









#                  How it works?

MinIO requires exclusive access to the drives or volumes provided for object storage. No other processes, software, scripts, or persons should perform any actions directly on the drives or volumes provided to MinIO or the objects or files MinIO places on them.









#                  How MinIO chooses to which Server-Pool to write a new file

It chooses the Server-Pool with most free space available.

MinIO must query each Server-Pool to determine the correct Erasure-Set to which it directs read and write operations, such that each additional Server-Pool adds increased internode traffic per call. The Server-Pool which contains the correct Erasure-Set then responds to the operation, remaining entirely transparent to the application.

##                 Rebalancing

`mc admin rebalance` - rebalance the objects between your Server-Pools.

Rebalancing does not block ongoing operations and runs in parallel to all other I/O. This can result in reduced performance of regular operations. 

You can start and stop rebalancing at any time

Consider scheduling rebalancing operations during non-peak periods to avoid impacting production workloads. 









#                  How MinIO chooses the Erasure-Set to which to write a new file

For each unique object namespace `BUCKET/PREFIX/[PREFIX/...]/OBJECT.EXTENSION`, MinIO always selects the same Erasure-Set for read/write operations.

 MinIO handles all routing within Server-Pools and Erasure-Sets, making the select/read/write process entirely transparent to applications.










#                  Erasure Coding (Software-RAID)

MinIO Erasure Coding is a data redundancy and availability feature that allows MinIO deployments with multiple drives to automatically reconstruct objects on-the-fly despite the loss of multiple drives or nodes in the cluster. Erasure Coding provides object-level healing with significantly less overhead than adjacent technologies such as RAID or replication.

A MinIO deployment with multiple drives divides the available drives into:
* Data-HDD-Drives - acts like simple HDD-Drive 
* Parity-HDD-Drives - MinIO Erasure Coding adds additional hashing information about the contents of an object to the Parity-HDD-Drive when writing an object. MinIO uses the parity information to confirm the integrity of an object and, if necessary, to restore a lost, missing, or corrupted object shard on a given drive or set of drives.

Each erasure set is independent of all others in the same pool - If one erasure set becomes completely degraded, MinIO can still perform read/write operations on other erasure sets.

MinIO can tolerate losing up to the total number of drives equal to the number of parity devices available in the erasure set while still providing full access to an object.

Erasure-Set - group of some HDD-Drives in the Server-Pool

Shard - part (chunk) of the object. Shards evenly distributed among each HDD-Drive in the Erasure-Set. MinIO can continue seamlessly serving read and write requests despite the loss of any single HDD-Drive. At the highest redundancy levels, MinIO can serve read requests with minimal performance impact despite the loss of up to half of the total drives in the deployment. There are 2 types of Shards:
* Data-Shard - 
* Parity-Shard - 

MinIO calculates the size and number of Erasure Sets in a Server Pool based on the total number of drives in the set and the number of minio servers in the set. See Erasure Coding Basics for more information.

However, the lost data may still impact workloads which rely on the assumption of 100% data availability. Furthermore, each erasure set is fully independent of the other such that you cannot restore data to a completely degraded erasure set using other erasure sets. You must use Site or Bucket replication to create a BC/DR (Business Conctinuity and Disaster Recovery)-ready remote deployment for restoring lost data.

##                 How MinIO calculates number of Erasure-Sets per Server-Pool

If we have 8 servers with 4 HDD-Drives each, then it will create 4 Erasure-Sets (and which will have 8 HDD-Drives in them)

##                 Read-Quorum and Write-Quorum

Quorum - a minimum number of drives that must be available to perform a task. 
Types of Quorum:
* Reading-Quorum - always equals the configured number of Parity-HDD-Disks. So, you can read objects unless the Erasure-Set has lost any drives more than number of Parity-HDD-Disks.
* Writing-Quorum - if number of Parity-HDD-Disks is less than 1/2 of all drives in the Erasure-Set, then Write-Quorm = number of Parity-HDD-Disks. If number of Parity-HDD-Disks is 1/2 f number of all HDD-Disks, then Writing-Quorum = number of Parity-HDD-Disks + 1.

Typically, MinIO requires a higher number of available drives to maintain the ability to write objects than what is required to read objects.









#                  Healing

Healing is MinIO’s ability to restore data after:
* Bit-Rot
* HDD-Drive loss
* Node loss

##                 Bit-Rot

Bit-Rot is the random, silent corruption to data that can happen on any storage device. Bit rot corruption is not prompted by any activity from a user, nor does the system’s operating system alone have awareness of the corruption to notify a user or administrator about a change to the data.

Some common reasons for bit rot include:
* ageing drives
* current spikes
* bugs in drive firmware
* phantom writes
* misdirected reads/writes
* driver errors
* accidental overwrites

MinIO uses a hashing algorithm to confirm the integrity of an object. This algorithm automatically applies at the time of any GET and HEAD operations for an object. For objects in a versioned bucket, a PUT operation can also trigger healing if MinIO identifies version inconsistencies. If an object becomes corrupted by bit rot, MinIO can automatically heal the object depending on the availability of parity shards for the object.

MinIO can also perform bit rot checks and healing using the MinIO Scanner. However, scanner bit rot checking is off by default. Active bit rot healing during scanner has a high performance impact in comparison to the low probability of bit rot affecting multiple object shards distributed across multiple drives and nodes. The automatic checks during normal operations is generally sufficient for bit rot, and MinIO does not recommend using the scanner for this type of health check.









#                  How to upload objects to MinIO

You can use any S3-compatible SDK to upload objects to a MinIO deployment. Each SDK performs the equivalent of a PUT operation which transmits the object to MinIO for storage.

MinIO also implements support for multipart uploads (https://docs.aws.amazon.com/AmazonS3/latest/userguide/mpuoverview.html), where clients can split an object into multiple parts for better throughput and reliability of transmission. MinIO reassembles these parts until it has a completed object, then stores that object at the specified path.