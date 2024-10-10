#                  What it is

It is te Internet used by phones. It is very different from the classsical one.

#                  IP

Phone gets its IP through NAT.
Base Station create device-specific IP-Tunnels from the phone to the Gateways.

#                  IMSI

It is the globally unique 64-bit identifier stored in the SIM-Card.

# Terms

- Base Station - that big iron triangles with antennes.
- {Home Subscriber Service = HSS} - Control Pane. Database storing information about phones for which HSS' Network is their home Network. It is used with MME for device Authenctication
- {Serving Gateway | S-GW} - 
- {PDN Gateway | P-GW} - gives phones its IPs through NAT. Last Router before Internet. For the Internet it looks as the simple Router.
- {Mobile Management Entity | MME} - Control Pane. Along with the HSS, it plays an important role in authenticating a device wanting to connect into its network. It also sets up the tunnels on  the data path from/to the devicse and the PDN Internet gateway router, and maintains  information about an active mobile device’s cell location within the carrier’s cellular network.