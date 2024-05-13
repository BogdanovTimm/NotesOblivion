1. `net.core.netdev_max_backlog`  - size of a 1st queue of a TCP-Requests - `Receive Queue` aka Backlog - request for starting of a handshake. You can see counter of packets that was dropped because of this value by watching the 2nd value in `/proc/net/softnet_stat`. Changing this parameter will afftect something only if RPS is enabled.
2. `net.ipv4.tcp_max_syn_backlog` - size of a 2nd queue of a TCP-Requests - `SYN-Backlog-Queue` - for a connections in which `SYN+ACK` mesasge was send to a client from a server. This connections characterised as `SYN_RECV`. `netstat -an | grep SYN_RECV | wc -l` - must be less than `net.ipv4.tcp_max_syn_backlog`. Если в состоянии "SYN_RECV" находятся много соединений, то можно также подстроить продолжительность нахождения SYN-пакета в этой очереди by `net.ipv4.tcp_fin_timeout`.
3. `net.core.somaxconn`           - size of a 3d queue of a TCP-Requests - `Accept Queue`       - queue for a client
4. `net.ipv4.tcp_syncookies` - Если SYN cookie отключены, то клиент просто повторяет отправку SYN-пакета. Если включены (net.ipv4.tcp_syncookies), то соединение не создается и не помещается в SYN backlog, но клиенту отправляется SYN+ACK так, как если бы это было сделано на самом деле. SYN cookie могут быть полезны при нормальной нагрузке, но при всплесках трафика некоторая информация о соединении может быть потеряна и клиент столкнется с проблемами, когда соединение будет установлено. 
5. `net.ipv4.tcp_synack_retries` - how many times to try to get `SYN+ACK` from a client that do not sends it. Если очередь SYN backlog мала, то не требуется большого количества соединений, чтобы возникла ситуация, когда полуоткрытые соединения никогда не завершатся и тогда никакие соединения не смогут быть установлены. Установите количество повторных попыток SYN+ACK равным 0 или 1, чтобы избежать такого поведения на высоконагруженных серверах.
6. `net.ipv4.tcp_syn_retries` - how many times to recieve duplicated `SYN+ACK` from a client
7. `cat /proc/sys/fs/file-nr`, `ulimit -u` and `systemctl show xAPPLICATIONx | grep LimitNOFILE` also play their roles
8. `cat /proc/sys/kernel/threads-max` also plays its role
9. `net.ipv4.tcp_fin_timeout` - how long to wait for a connections in a `TIME_WAIT` state. Optimal for a high loaded servers is 5-7 seconds (other source says 30)
10. `net.ipv4.tcp_max_tw_buckets` - max number of sockets in a `TIME_WAIT` state.
11. `net.ipv4.tcp_tw_recycle = 1` - fast utilization of a sockets in a `TIME_WAIT` state
12. `net.ipv4.tcp_keepalive_time` - how often to check whether connection is alive
13. `net.ipv4.tcp_tw_reuse` - Включаем механизм разрешающий использовать уже существующие сокеты, которые находятся в состоянии TIME_WAIT, если это не повредит безопасности.
14. `net.ipv4.tcp_timestamps = 1` - чтобы `net.ipv4.tcp_tw_reuse` to work
15. `net.ipv4.tcp_keepalive_probes = 7` - how much tries to test whether the connection is still alive after `net.ipv4.tcp_keepalive_time`
16. `net.ipv4.tcp_keepalive_intvl = 30` - interval of between tries to check whether the conneciton is still alive
17. Buffers for network connections:
```
net.core.wmem_max
net.core.rmem_max - (network level) socket's backlog length
net.core.rmem_default - (network level)
net.core.wmem_default
net.core.netdev_budget - Budget per CPU. You can see counter of packets that was dropped because of this values by watching the 3d value in `/proc/net/softet_stat`
net.ipv4.tcp_rmem
net.ipv4.tcp_wmem 
```

https://galaxydata.ru/community/optimizaciya-raboty-setevogo-steka-os-lin-61


From VMware Tanzu Greenplum 6 Documentation VMware
(https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database-6-25.pdf):
```conf
kernel.msgmax = 65536
kernel.msgmnb = 65536
kernel.msgmni = 2048
kernel.sem = 500 2048000 200 40960
kernel.shmmni = 1024
kernel.sysrq = 1
net.core.netdev_max_backlog = 2000
net.core.rmem_max = 4194304
net.core.wmem_max = 4194304
net.core.rmem_default = 4194304
net.core.wmem_default = 4194304
net.ipv4.tcp_rmem = 4096 4224000 16777216
net.ipv4.tcp_wmem = 4096 4224000 16777216
net.core.optmem_max = 4194304
net.core.somaxconn = 10000
net.ipv4.ip_forward = 0
net.ipv4.tcp_congestion_control = cubic
net.ipv4.tcp_tw_recycle = 0
net.core.default_qdisc = fq_codel
net.ipv4.tcp_mtu_probing = 0
net.ipv4.conf.all.arp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.ip_local_port_range = 10000 65535
net.ipv4.tcp_max_syn_backlog = 4096
net.ipv4.tcp_syncookies = 1
vm.overcommit_memory = 2
vm.overcommit_ratio = 95
vm.swappiness = 10
vm.dirty_expire_centisecs = 500
vm.dirty_writeback_centisecs = 100
vm.zone_reclaim_mode = 0
```