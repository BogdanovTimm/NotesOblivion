#                  What it is

- Connects different networks together
- They can receive and anser broadcast message, but they can't transmitt broadcast message from one network to another









#                  Which layers it uses

It uses:
1. Physical Layer
2. Data Link Layer
3. Network Layer
4. Transport Layer (Only BGP-Routers) 









#                  How it works

1. Router receives a full packet
2. ???
3. Router checks to which Output-Buffer of its Output-Links it must store an IP-Address to which this Packet must be sent by checking its Forwarding-Table (that stores maps of IP-Addresses and Router's Output-Link).
4. Stores packets that the Router is about to send into an Output-Buffer aka Output-Queue). It is needed so it the Router is forwarding a packet right now - the packet must wait in the Output-Buffer.
5. Router forward a packet








#                   NAT-Router

It is a router that can resolve local IP addresses into a public IP addresses

From local to public:
1. Your server sends packet from its local IP addresses to a public IP address of another PC
2. When packet goes to NAT-Router, it changes local IP Address of our PC to a public IP Address of our PC
3. Other PC sends responce packet from it public IP Address to our PC's public IP Address
4. When packet goes to NAT-Router, it changes public IP Address of our PC to a local IP Address of our PC

##                  Port-based-NAT-Router

You may resolve many internal IP Adresses into different ports of a single piblic IP address









#                   BGP-Router

Works using level 4