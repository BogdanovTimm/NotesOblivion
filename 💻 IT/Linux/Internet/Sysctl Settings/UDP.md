#                  Monitoring UDP

##                 /proc/net/snmp

`cat /proc/net/snmp | grep Udp\:`
- `InDatagrams`: Incremented when recvmsg was used by a userland program to read datagram. Also incremented when a UDP packet is encapsulated and sent back for processing.
- `NoPorts`: Incremented when UDP packets arrive destined for a port where no program is listening.
- `InErrors`: Incremented in several cases: no memory in the receive queue, when a bad checksum is seen, and if sk_add_backlog fails to add the datagram.
- `OutDatagrams`: Incremented when a UDP packet is handed down without error to the IP protocol layer to be sent.
- `RcvbufErrors`: Incremented when sock_queue_rcv_skb reports that no memory is available; this happens if `sk->sk_rmem_alloc` is greater than or equal to `sk->sk_rcvbuf`.
- `SndbufErrors`: Incremented if the IP protocol layer reported an error when trying to send the packet and no error queue has been setup. Also incremented if no send queue space or kernel memory are available.
- `InCsumErrors`: Incremented when a UDP checksum failure is detected. Note that in all cases I could find, InCsumErrors is incrememnted at the same time as InErrors. Thus, InErrors - InCsumErros should yield the count of memory related errors on the receive side.