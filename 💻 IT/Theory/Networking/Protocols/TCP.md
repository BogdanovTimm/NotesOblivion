#                  Layer

It resides on the Transport Layer









# Usage

- File transfer (FTP)
- Email (SMTP)
- Database transactions
- Remote terminal access (Telnet, SSH)
- Web (HTTP)
- Telephony (thought it may be implemented using UDP) (SIP, RTP, Skype)
- Streaming Multimedia (DASH)









#                  Persistent vs Non-Persistent Connections

TCP may use:
* Persisntent Connection - when whole message is sent using 1 TCP-Connection
* Non-Persisntent Connections - when each segment is sent using new TCP-Connection









#                  How it works

##                 Handshake

```
1)
  Client-PC-1            Server-PC-2  
+-------------+    +---------------------+
|   Socket*----------*Handshake-Socket   |
|             |    |                     |
|             |    |                     |
+-------------+    +---------------------+


2)
  Client-PC-1            Server-PC-2            Client-PC-2  
+-------------+    +---------------------+    +-------------+
|             |    |   Handshake-Socket  |    |             |
|   Socket*----------*Connection-Socket  |  ,-----*Socket   |
|             |    |  Connection-Socket*---'  |             |
+-------------+    +---------------------+    +-------------+
```

 1) Cliet-PC-1 sents a 3-Way-Handshake to the Server-PC-2 Handshake-Socket
 2) During 3-Way-Handshake, Server-PC-2 creates a Connection-Socket-For-Client-PC-1
 3) Now, both Client-PC-1 and Server-PC-2 may sent bytes to each other:
     1) Applicaiton-Level on PC-1 sends data to the TCP-Socket
     2) Transport-Level on PC-1 takes data from the TCP-Socket and place it in the TCP-Send-Buffer
     3) Transport-Level on PC-2 receives data into the TCP-Receive-Buffer
     4) Transport-Level on PC-2 taes data from the TCP-Receive-Buffer and place it into the TCP-Socket
     5) Applicaiton-Level on PC-2 takes data from te TCP-Socket

##                 TCP-Receive-Buffer

TCP-Receive-Buffer uses window.

Window - Pointers that tracks:
- Sent sequence-numbers that were sent and ACKnowledged
- Sent sequence-numbers that were sent but were not ACKnowledged
- Sent sequence-number that ready to be sent

##                  How sending works

```
     Sending-PC                         Receiving-PC   
+------------------+                +------------------+
| Sending-Buffer   |                | Sending-Buffer   |
|     +----+       |  TCP-Segment   |     +----+       |
|     |cock|       |  +----------+  |     |    |       |
|     +----+       |  | SEQ : 0  |  |     +----+       |
|                  |--| Data:'c' |->|                  |
| Receiving-Buffer |  | ACK : 0  |  | Receiving-Buffer |
|     +----+       |  +----------+  |     +----+       |
|     |    |       |                |     |    |       |
|     +----+       |                |     +----+       |
+------------------+                +------------------+


     Sending-PC                         Receiving-PC   
+------------------+                +------------------+
| Sending-Buffer   |                | Sending-Buffer   |
|     +----+       |  TCP-Segment   |     +----+       |
|     |cock|       |  +----------+  |     |c   |       |
|     +----+       |  | SEQ : 0  |  |     +----+       |
|                  |<-| Data:'c' |--|                  |
| Receiving-Buffer |  | ACK : 1  |  | Receiving-Buffer |
|     +----+       |  +----------+  |     +----+       |
|     |    |       |                |     |c   |       |
|     +----+       |                |     +----+       |
+------------------+                +------------------+


     Sending-PC                         Receiving-PC   
+------------------+                +------------------+
| Sending-Buffer   |                | Sending-Buffer   |
|     +----+       |  TCP-Segment   |     +----+       |
|     |cock|       |  +----------+  |     |c   |       |
|     +----+       |  | SEQ : 1  |  |     +----+       |
|                  |--| Data:'o' |->|                  |
| Receiving-Buffer |  | ACK : 1  |  | Receiving-Buffer |
|     +----+       |  +----------+  |     +----+       |
|     |c   |       |                |     |c   |       |
|     +----+       |                |     +----+       |
+------------------+                +------------------+



     Sending-PC                         Receiving-PC   
+------------------+                +------------------+
| Sending-Buffer   |                | Sending-Buffer   |
|     +----+       |  TCP-Segment   |     +----+       |
|     |cock|       |  +----------+  |     |co  |       |
|     +----+       |  | SEQ : 1  |  |     +----+       |
|                  |<-| Data:'o' |--|                  |
| Receiving-Buffer |  | ACK : 2  |  | Receiving-Buffer |
|     +----+       |  +----------+  |     +----+       |
|     |c   |       |                |     |co  |       |
|     +----+       |                |     +----+       |
+------------------+                +------------------+
```








#                   Segment

##                 TCP-Segmet

TCP-Segment consists of:
- Sending-PC-Port
- Receiving-PC-Port
- Length of a Application-Layer-DATA + all TCP-Headers
- Checksum
- Sequece-Number - 32 bit value representing which byte in the whole Applicaiton-Level data does the first-byte in this segment is (for example, first byte in this segment is the 1000th byte in the file)
- ACKnowledge-Number - 32 bit value representing which byte in the whole Applicaiton-Level data should be next (even if now Receiving-PC has 1st and 2nd byte but lacks 3d and 4th, but somehow has received 5th and 6th - then, Receving-PC will send an TCP-Segment with ACK = 3)
- Receive-Window - 16 bit value representing number of bytes that Receiving-PC is willing to accept
- Header-Length - 4 bit value representing length of the TCP-Header in 32-bit words. It needed because Options-Header is of variable length
- Options - optional values such as:
    - MSS (Maximum Segment Size)
    - Window scaling factor
    - Timestamp
- ACK-flag - 1 bit that indicates whether ACKnowledge number was succesfully received
- RST-flag - 1 bit that indicates whether used for conenciton establishment
- SYN-flag - 1 bit that indicates whether used for conenciton establishment
- FIN-flag - 1 bit that indicates whether used for conenciton establishment
- CWR - 1 bit that indicates whether congestion notification
- ECE - 1 bit that indicates whether  congestion notification
- PSH - (rarely used) 1 bit that indicates whether Receiving-PC should pass the data to the Applicaiton-Layer immediately
- URG - (rarely used) 1 bit that indicates whether there is an urgent data
- Applicatin-Level-Data
- End-of-Urgent-Data-Pointer - a pointer to the last bit of the urgent data

##                 Segment Size

MSS (Maximum-Segment-Size) - The maximum amount of Application-Level-Data that can be grabbed and placed in a Transport-Layer-Segment.

```
             Maximum-Link-Layer-Frame-Size(MTU)
                              |
 .-------------------------------------------------------.
/                                                         \
+----------------------------------------------------------+
| Actual Application-Layer-Data | TCP-Headers | IP-Headers |
+----------------------------------------------------------+
\                              /
 '----------------------------'
               |
   Maximum-Segment-Size(MSS)
\                                            /
 '------------------------------------------'
                       |
           Transport-Layer-Segment
```

The MSS  is typically set by first determining the length of the largest Link-Layer-Frame that  can be sent by the local sending host (the so-called Maximum-Transmission-Unit,  MTU), and then setting the MSS to ensure that a TCP segment (when encapsulated  in an IP datagram) plus the TCP/IP header length (typically 40 bytes) will fit into a  single link-layer frame. Both Ethernet and PPP link-layer protocols have an MTU of  1,500 bytes. Thus, a typical value of MSS is 1460 bytes. Approaches have also been  proposed for discovering the path MTU—the largest link-layer frame that can be sent  on all links from source to destination [RFC 1191]—and setting the MSS based on  the path MTU value. Note that the MSS is the maximum amount of application-layer  data in the segment, not the maximum size of the TCP segment including headers.  (This terminology is confusing, but we have to live with it, as it is well entrenched.) 