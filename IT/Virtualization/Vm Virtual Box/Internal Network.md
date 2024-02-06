#                  What it is?

It is a LAN actually







          Client:
192.168.1.11

          Router:
192.168.1.1
192.168.2.2

          Server:
192.168.2.22

#                  Installation

1. Add **Internal Network** virtual network adapter to each virtual machine you want to ne in internal network
    1. If you want to one machine to be in more than 1 Internal Network - you need to create 2 virtual network adapters
2. `ip addr` - get your LAN network adapter name from here 
3. `sudo vim /etc/network/interfaces` - open file to create static IP address for a LAN and add these lines in it:
```
auto %network_lan_adapter_name%
iface %network_lan_adapter_name% inet static
    address 222.222.1.1
    netmask 255.255.255.0
    netwrok 222.222.1.0
    broadcast 222.222.1.255
    # Next 2 lines you need only if this PC will have both normal virtual network card (NAT) and a LAN one
    post-up route add -net 222.222.0.0 netmask 255.255.0.0 gw 222.222.1.1 dev %network_lan_adapter_name%
    pre-down route del -net 222.222.0.0 netmask 255.255.0.0 gw 222.222.1.1 dev %network_lan_adapter_name%
```










#                  Proxy

If one of your PC will be working as a mediator - e.g. it will receive an HTTP-Request and then send this to another PC (server with Nginx for example) - then you need to do this:
1. `sudo vim /etc/sysctl.conf` - open this file and uncomment this line:
```
net.ipv4.ip_forward=1
```
2. Reboot your this machine