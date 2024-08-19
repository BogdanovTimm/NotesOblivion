#                  What it is? 

To send something to another PC, you need to know its MAC-Address









#                   ARP

ARP protocol finds MAC-Address by:
1. Checking cache (maybe it knows MAC-Address of for a given IP-Address already) 
2. Sending a broadcast message to all devices on its network (not further than router) with an IP address it needs
3. All decices receive this broadcast message
4. If IP in broadcast message is not current device's IP, then this device do nothing. But the device with the IP from a message will send a unicast message back to the device that asked fofr MAC addres