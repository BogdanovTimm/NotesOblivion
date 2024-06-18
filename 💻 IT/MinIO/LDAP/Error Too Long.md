Sometimes, names in LDAP are too long for MinIO. To handle this, you need to use `etcd`.

Modified run command for using it with `etcd`:
```shell
MINIO_ROOT_USER="xUSERx"                           \
MINIO_ROOT_PASSWORD="xPASSWORDx"                   \
MINIO_ETCD_ENDPOINTS="http://etcd.server.com:2379" \
/path/to/minio                                     \
server                                             \
/path/where/to/store/files                         \
--address ":9000"                                  \
--console-address ":9001"                          \
--certs-dir "/path/to/ssl/certificates"
```