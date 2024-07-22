1. Run this code on every machine in a etcd cluster:
    ```shell
    ETCDCTL_API=3                                              \
    /path/to/etcd                                              \
        --data-dir=data.etcd                                   \
        --name                        xCURRENT_SERVER_ALIASx   \
        --initial-advertise-peer-urls http://xCURRENT_IPx:2380 \
        --listen-peer-urls            http://xCURRENT_IPx:2380 \
        --advertise-client-urls       http://xCURRENT_IPx:2379 \
        --listen-client-urls          http://xCURRENT_IPx:2379 \
        --initial-cluster-state       new                      \
        --initial-cluster-token       xCLUSTER_NAMEx           \
        --initial-cluster             xCURRENT_SERVER_ALIASx=http://xCURRENT_SERVER_IPx:2380,xANOTHER_SERVER_ALIASx=http://xANOTHER_SERVER_IPx:2380
    ```
2. Now you may try to conenct to your cluster using `etcdtl`:
    ```shell
    ETCDCTL_API=3                                              \
    /path/to/etcdctl                                           \
        --endpoints=xCURRENT_IPx:2379,xANOTHER_SERVER_IPx:2379 \
        member list
    ```