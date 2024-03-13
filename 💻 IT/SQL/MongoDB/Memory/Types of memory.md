# Types of RAM used by MongoDB

Types of memory:
- WiredTiger Internal Cache: MongoDB utilizes the WiredTiger internal cache to store most recently used data and indexes. The size of the cache is configurable and is set by default to 50% of the available physical RAM on the system. The WiredTiger cache improves query performance by serving queries from memory (RAM).
- Filesystem Cache: MongoDB also utilizes the filesystem cache, which is managed by the operating system. The filesystem cache stores data in the same format as the on-disk (HDD) format, including any compression applied to data files. The filesystem cache helps reduce disk (HDD) I/O by caching frequently accessed data.
- Working Set: Sum of all the indexes and frequently accessed documents. If the working set fits in RAM, MongoDB can serve queries from memory (RAM instead of HDD), resulting in faster query response times.

To optimize memory usage in MongoDB, you can adjust the size of the WiredTiger internal cache using the `storage.wiredTiger.engineConfig.cacheSizeGB` configuration option (but avoid increasing the WiredTiger internal cache size above its default value). You may see current value of it in `hostInfo.system.memLimitMB`. To view statistics on the cache and eviction rate, see the `wiredTiger.cache` field returned from the `serverStatus` command. If several Mongods are mixed and deployed on a device, or Mongod is deployed together with some other processes, it is necessary to set the cacheSizeGB based on the memory quota allocated to Mongod, and this may be set according to about 60% of the quota.










#                  Dirty RAM

Dirty RAM in MongoDB refers to the portion of RAM that is used to store modified data that has not yet been written to disk. When data is modified in MongoDB, it is first written to the dirty RAM cache before being flushed to disk. This caching mechanism helps improve write performance by allowing MongoDB to quickly acknowledge write operations without waiting for the data to be persisted to disk.

The dirty RAM cache is managed by the WiredTiger storage engine, which is the default storage engine used by MongoDB Atlas. The amount of dirty RAM used by MongoDB depends on the rate of write operations and the frequency at which the data is flushed to disk.









#                  Kernel and File Systems

When running MongoDB in production on Linux, you should use Linux kernel version 2.6.36 or later, with either the XFS or EXT4 filesystem. If possible, use XFS as it generally performs better with MongoDB.

With the WiredTiger storage engine, using XFS is strongly recommended for data bearing nodes to avoid performance issues that may occur when using EXT4 with WiredTiger.