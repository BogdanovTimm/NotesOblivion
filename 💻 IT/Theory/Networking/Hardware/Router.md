#                  What it is

- Connects different networks together
- They can receive and anser broadcast message, but they can't transmitt broadcast message from one network to another









#                  Which layers it uses

It uses:
1. Physical Layer
2. Data Link Layer
3. Network Layer
4. (Only BGP-Routers) Transport Layer








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