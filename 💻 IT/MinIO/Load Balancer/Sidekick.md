#                  What it is?

Load balancer from developers of MinIO









#                  Installation

1. Download it
2. Run:
```shell
/xPATH/TO/SIDEKICKx \
    --health-path "/minio/health/cluster"  \
    --address     "x55552x"                \
    --client-cert "/xPATH/TOx/public.crt"  \
    --client-key  "/xPATH/TOx/private.key" \
    --cacert      "/xPATH/TOx/private.key" \
    https://xMINIO.SERVER.RUx:x55551x
```
3. Try:
```shell
/xPATH/TO/MINIO/CLIENTx  \
alias                    \
set                      \
xNEW_CONNECTION_NAMEx    \
http://localhost:x55552x \
access_key1              \
'123456!!'
```
4. And then:
```shell
/xPATH/TO/MINIO/CLIENTx                        \
get                                            \
xNEW_CONNECTION_NAMEx/xBUCKET_NAMEx/xFILE_NAMEx
```