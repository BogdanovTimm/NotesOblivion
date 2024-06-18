1. Download `mc`
2. (Optional) Add `public.key` to `/path/to/.mc/certs`
3. `/path/to/mc alias 'remote_minio_server1' 'server.address.com:55551' 'xUSERNAMEx' 'xPASSWORDx'` - create new connection
4. `/path/to/mc cp ./file_from_this_pc.txt 'remote_minio_server1/bucket_name'` - check copy