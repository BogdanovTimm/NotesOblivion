#                  How much memory do Mongo needs?

Starting in MongoDB 3.4, the default WiredTiger internal cache size is the larger of either:
- 50% of (RAM - 1 GB)
- 256 MB.

For example, on a system with a total of 4GB of RAM the WiredTiger cache will use 1.5GB of RAM (0.5 * (4 GB - 1 GB) = 1.5 GB). 
Conversely, a system with a total of 1.25 GB of RAM will allocate 256 MB to the WiredTiger cache because that is more than half of the total RAM minus one gigabyte (0.5 * (1.25 GB - 1 GB) = 128 MB < 256 MB).
Via the filesystem cache, MongoDB automatically uses all free memory that is not used by the WiredTiger cache or by other processes.
The operating system will use the available free memory for filesystem cache, which allows the compressed MongoDB data files to stay in memory. 
In addition, the operating system will use any free RAM to buffer file system blocks and file system cache.
To accommodate the additional consumers of RAM, you may have to decrease WiredTiger internal cache size.









#                  Limiting RAM

In some instances, such as when running in a container, the database can have memory constraints that are lower than the total system memory. In such instances, this memory limit, rather than the total system memory, is used as the maximum RAM available.

To see the memory limit, see `hostInfo.system.memLimitMB`









#                  Set RAM limit

To adjust the size of the WiredTiger internal cache, see `storage.wiredTiger.engineConfig.cacheSizeGB` and `--wiredTigerCacheSiazeGB`. 
**Avoid increasing** the WiredTiger internal **cache size above its default value**.
