#                  Packet Names

Packet names:
- Packet   - Network Layer
- Datagram - Network Layer
- Frame    - Takes higher-level packets/datagrams and frame them with additional header information needed at the lower level. Data-Link Layer, Physical Layer
- Cell     - Lower level packet of fixed size.
- Protocol Data Unit (PDU) and Service Data Uni (SDU):
    - Protocol Data Unit (PDU) - packets that are send between protocols at some layer. Consists of this-layer header information + SDU.
    - Service Data Unit  (SDU) - packet from the 1 layer above
- Segments - Used in TCP.