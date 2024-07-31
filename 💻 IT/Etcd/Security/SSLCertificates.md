#                  Installation

1. Create Root Certificate - it will be used for creating other Certificates
2. Create Server Certificates
3. Create Peer Certificate - it will be used for each etcd-server to connect to all other etcd-servers in the cluster
4. Run each etcd-cerver with these options:
    - Server 1:
    ```shell
    ETCDCTL_API=3                                                                                                       \
    /path/to/etcd                                                                                                       \
        --client-cert-auth                                                                                              \
        --peer-client-cert-auth                                                                                         \
        --initial-cluster-state       new                                                                               \
        --initial-cluster-token       xCLUSTER_NAMEx                                                                    \
        --initial-cluster             xOTHER_SERVER_ALIASx=https://xSERVER2.RUx:2380,xTHIS_SERVER_ALIASx=https://xSERVER1.RUx:2380 \
        --name                        xTHIS_SERVER_ALIASx                                                               \
        --initial-advertise-peer-urls https://xSERVER1.RUx:2380                                                         \
        --listen-peer-urls            https://xSERVER1.RUx:2380                                                         \
        --listen-client-urls          https://xSERVER1.RUx:2379,https://127.0.0.1:2379                                  \
        --advertise-client-urls       https://xSERVER1.RUx:2379                                                         \
        --trusted-ca-file=/xPATH/TO/SERVER1xroot.crt                                                                    \
        --cert-file=/xPATH/TO/SERVER1x.crt                                                                              \
        --key-file=/xPATH/TO/SERVER1x.key                                                                               \
        --peer-trusted-ca-file=/xPATH/TO/PEERxroot.crt                                                                  \
        --peer-cert-file=/xPATH/TO/PEERx.crt                                                                            \
        --peer-key-file=/xPATH/TO/PEERx.key
    ```
    - Server 2:
    ```shell
    ETCDCTL_API=3                                                                                                       \
    /path/to/etcd                                                                                                       \
        --client-cert-auth                                                                                              \
        --peer-client-cert-auth                                                                                         \
        --initial-cluster-state       new                                                                               \
        --initial-cluster-token       xCLUSTER_NAMEx                                                                    \
        --initial-cluster             xOTHER_SERVER_ALIASx=https://xSERVER2.RUx:2380,xTHIS_SERVER_ALIASx=https://xSERVER1.RUx:2380 \
        --name                        xTHIS_SERVER_ALIASx                                                               \
        --initial-advertise-peer-urls https://xSERVER2.RUx:2380                                                         \
        --listen-peer-urls            https://xSERVER2.RUx:2380                                                         \
        --listen-client-urls          https://xSERVER2.RUx:2379,https://127.0.0.1:2379                                  \
        --advertise-client-urls       https://xSERVER2.RUx:2379                                                         \
        --trusted-ca-file=/xPATH/TO/SERVER2xroot.crt                                                                    \
        --cert-file=/xPATH/TO/SERVER2x.crt                                                                              \
        --key-file=/xPATH/TO/SERVER2x.key                                                                               \
        --peer-trusted-ca-file=/xPATH/TO/PEERxroot.crt                                                                  \
        --peer-cert-file=/xPATH/TO/PEERx.crt                                                                            \
        --peer-key-file=/xPATH/TO/PEERx.key
    ```
5. Check that cluster works:
    ```shell
    ETCDCTL_API=3                             \
    ETCDCTL_CACERT=/xPATH/TO/SERVER1xroot.crt \
    ETCDCTL_CERT=/xPATH/TO/SERVER1xclient.crt \
    ETCDCTL_KEY=/xPATH/TO/SERVER1xclient.key  \
    ./etcdctl                                 \
        --endpoints=xSERVER1.RUx:2379   \
        member list
    ```









#                  Problems

- Maybe, in the peer certificate, you need to have IP in the SAN field