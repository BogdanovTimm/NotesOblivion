#                  What it is

- Connects different PC on same Networks together
- Do not have IP address, because it uses OSI layers lower than 3d
- Connects different PCs inton1 brosdcast and unicast network








#                  Which layers it uses

It uses:
1. Physical
2. Data Link









#                  VLAN-aware Switches

They allow to group host in VLAN-Subnetworks - logical software-defined Subnetworks (without the need to be physicallydivided by Routers):
- Broadcast packets sent by one of the workstations will reach all the others in the VLAN.
- Broadcasts sent by one of the workstations in the VLAN will not reach any workstations that are not in the VLAN.
- Broadcasts sent by workstations that are not in the VLAN will never reach workstations that are in the VLAN.
- The workstations can all communicate with each other without needing to go through a gateway. For example, IP connections would be established by ARPing for the destination.
- There is no need to send packets to the IP gateway to be forwarded on.
- The workstations can communicate with each other using non-routable protocols
- Faster than Routers - Routers typically forward data in software, and so are not as fast as switches
- Splitting up a LAN using routers meant that a LAN typically corresponded to a particular physical location. This became limiting when many users had laptops, and wanted to be able to move between buildings, but still have the same network environment wherever they plugged in

##                 How it works

It just adds a header to a Ethernet packet:
- TPID - Tag Protocol ID (2 bytes long). Indicates that the next 2 bytes will be TCI
- TCI  - Tag Control Information (2 bytes long). Consists of:
    - User Priority - level of user priority from 0 (lowest) to 7 (highest) (3 bit long).
    - CFI - if 1 - then frame should not be bridged to an untagged port (1 bit long). For compatibility between Ethernet and Token Ring networks.
    - VID - VLAN ID (12 bits long). Containt number of the VLAN

###                Native VLAN

Each port has its Native VLAN - VLAN-number to which port will send packages that do not have VLAN ID.

###                Trunk Mode

Each port may be used in Trunk Mode - it allows to 1 port to be attached to 2 or more VLANs.
Ports that work in Trunk Mode also have Native VLANs