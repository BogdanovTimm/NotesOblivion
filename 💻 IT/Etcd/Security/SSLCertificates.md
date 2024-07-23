```shell
etcd                                                                               \
    --client-cert-auth                                                             \
    --peer-client-cert-auth                                                        \
    --initial-cluster-state       new                                              \
    --initial-cluster-token       xCLUSTER_NAMEx                                   \
    --initial-cluster xCURRENT_SERVER_ALIASx=https://xCURRENT_IPx:2380,xANOTHER_SERVER_ALIASx=https://xANOTHER_SERVER_IPx:2380 \
    --name                        xCURRENT_SERVER_ALIASx                           \
    --initial-advertise-peer-urls https://xCURRENT_IPx:2380                        \
    --listen-peer-urls            https://xCURRENT_IPx:2380                        \
    --listen-client-urls          https://xCURRENT_IPx:2379,https://127.0.0.1:2379 \
    --advertise-client-urls       https://xCURRENT_IPx:2379                        \
    --trusted-ca-file=/path/to/ca-client.crt                                       \
    --cert-file=/path/to/infra0-client.crt                                         \
    --key-file=/path/to/infra0-client.key                                          \
    --peer-trusted-ca-file=ca-peer.crt                                             \
    --peer-cert-file=/path/to/infra0-peer.crt                                      \
    --peer-key-file=/path/to/infra0-peer.key
```

```shell
etcd                                                                        \
  --name                        infra1                                        \
  --initial-advertise-peer-urls https://10.0.1.11:2380                        \
  --listen-peer-urls            https://10.0.1.11:2380                        \
  --listen-client-urls          https://10.0.1.11:2379,https://127.0.0.1:2379 \
  --advertise-client-urls       https://10.0.1.11:2379                        \
  --initial-cluster-token       etcd-cluster-1                                \
  --initial-cluster infra0=https://10.0.1.10:2380,infra1=https://10.0.1.11:2380,infra2=https://10.0.1.12:2380 \
  --initial-cluster-state     new                                             \
  --client-cert-auth                                                          \
  --trusted-ca-file=/path/to/ca-client.crt                                    \
  --cert-file=/path/to/infra1-client.crt                                      \
  --key-file=/path/to/infra1-client.key                                       \
  --peer-client-cert-auth                                                     \
  --peer-trusted-ca-file=ca-peer.crt                                          \
  --peer-cert-file=/path/to/infra1-peer.crt                                   \
  --peer-key-file=/path/to/infra1-peer.key
  ```