```bash
MINIO_ROOT_USER="xUSERx"           \
MINIO_ROOT_PASSWORD="xPASSWORDx"   \
/path/to/minio                     \
server                             \
/path/where/to/store/files         \
--address "localhost:9000"         \
--console-address "localhost:9001" \
--certs-dir "/path/to/ssl/certificates"
```