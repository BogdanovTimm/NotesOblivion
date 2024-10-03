#                  Layer

It resides on the Transport Layer









# Usage

- File transfer (FTP)
- Email (SMTP)
- Database transactions
- Remote terminal access (Telnet)
- Web (HTTP)
- Telephony (thought it may be implemented using UDP) (SIP, RTP, Skype)









#                  Persistent vs Non-Persistent Connections

TCP may use:
* Persisntent Connection - when whole message is sent using 1 TCP-Connection
* Non-Persisntent Connections - when each segment is sent using new TCP-Connection









#                  How it works

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
|   Socket*-----.  |   Handshake-Socket  |    |             |
|             |  '---*Connection-Socket  |  ,-----*Socket   |
|             |    |  Connection-Socket*---'  |             |
+-------------+    +---------------------+    +-------------+
```

 1) Cliet-PC-1 sents a 3-Way-Handshake to the Server-PC-2 Handshake-Socket
 2) During 3-Way-Handshake, Server-PC-2 creates a Connection-Socket-For-Client-PC-1
 3) Now, both Client-PC-1 and Server-PC-2 may sent bytes to each other