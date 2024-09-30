#                  Types of Replication

Types of Replication between Clusters (you cannot use both of them): {
* Site-Replication - replicaiton of the entire Cluster. Site Replication extends Bucket-Replication to include: {IAM, security tokens, access keys, and Bucket-level configurations}.
* Bucket-Replication: {
    * Server-Side-Bucket-Replication - automatically synchronize objects between Deployments where 'PUT'-request was received
    * Client-Side-Bucket-Replication - manual replication using `/path/to/mc mirror` command
    }
}









#                  Site Healing

`/path/to/mc admin replicate resync` - Manually start healing
{`MINIO_SCANNER_SPEED` environment variable or `scanner speed` configuration setting} - To adjust the balance of scanner performance and read/write operations









#                  Syncronization of delete

By default it is disabled.
To enable it use:
* `/path/to/c replicate add --replicate delete` - versioned deletes
* `/path/to/c replicate add --replicate delete-marker`
* `/path/to/c replicate add --replicate delete,delete-marker`