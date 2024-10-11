# Blocking of `tracerout` to prevent discovering of the structure of some Network

If the organization doesn’t  want its internal network to be mapped (`tracerout`ed) by an outsider, it can block all  ICMP TTL expired messages leaving the organization’s network.









# Disable connecting to Network from outside

Filtering can also be based on whether or not the TCP ACK bit is set. This trick  is quite useful if an organization wants to let its internal clients connect to external  servers but wants to prevent external clients from connecting to internal servers.  Recall from Section 3.5 that the first segment in every TCP connection has the ACK  bit set to 0, whereas all the other segments in the connection have the ACK bit set to 1.   Thus, if an organization wants to prevent external clients from initiating connections  to internal servers, it simply filters all incoming segments with the ACK bit set to 0.  This policy kills all TCP connections originating from the outside, but permits connections originating internally. 