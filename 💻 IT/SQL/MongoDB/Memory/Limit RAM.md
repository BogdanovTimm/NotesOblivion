In some instances, such as when running in a container, the database can have memory constraints that are lower than the total system memory. In such instances, this memory limit, rather than the total system memory, is used as the maximum RAM available.

To see the memory limit, see `hostInfo.system.memLimitMB`

#                  Set RAM limit

`storage.wiredTiger.engineConfig.cacheSizeGB`