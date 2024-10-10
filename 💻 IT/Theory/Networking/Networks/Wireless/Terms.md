# Terms

## '------- Wi-fi

Station - {Base Station | Wireless Station}:
- Base Stations - has MAC-Address:
    - Cell Towers in Cellular Networks
    - {AP = Access Points} in WLANs
- Wireless Station - phone, laptop, etc. Has MAC-Address

{Basic Service Set = BSS} - either:
- Infrastrucutre-Wireless-Lan - Access Point + Wireless Stations conencted to it
- Ad-Hoc-Network              - Wireless Stations connected to each other

Handoff/Handover - when mobile device change Base Station

Network Infrastructure - other Network parts

{SSID = Service Set Identifier} - name of the Access Point


How phone finds to which AP to connect:
- Passive Scanning - phone listen for Beacon Frames (Beacon Frames - frames with {AP's SSID, AP's MAC-Address} that AP sends periodically)
- Active Scanning - phone broadcast a frame and waits for a frame-response from an AP. Then, phoe sends Association-Request and waits for the Association-Responce. Then, phone sendsa DHCP message to obtain a new IP-Address on the AP's Subnet.

Wi-Fi-Packet:
- MAC-Addresses:
    - Address-2 - MAC-Address of the sending {phone | AP}
    - Address-1 - MAC-Address of the destination {phone |AP}
    - Address-3 - MAC-Address of the nearest Router
- Whether WEP-Encryptioin is used
- others...

When a device is moved from one BSS to the other within same Subne (both BSSes are connected via a Switch) - then it keeps its IP-Address and pretends that nothing ever happened. AP in the new BSS must send a Broadcast Ethernet frame to the Switch for the Switch to reload its Forwarding-Table.