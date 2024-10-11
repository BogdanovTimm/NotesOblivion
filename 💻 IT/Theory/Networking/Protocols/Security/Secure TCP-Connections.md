# TLS


TLS is a new version of the SSL-Protcol.

Actually, TLS is an Application-Level-Protocol that mimic to the Transport-Layer-Protocol to implement:
- TCP-Packets encrpytion
- Server Authenticaiton
- User   Authenticaiton

TLS is often used to provide security to transactions that take place over HTTP.  However, because TLS secures TCP, it can be employed by any application that  runs over TCP.

TLS provides a simple Application Programmer Interface (API) with  sockets, which is similar and analogous to TCP’s API. When an application wants to  employ TLS, the application includes SSL classes/libraries. As shown in Figure 8.24,  although TLS technically resides in the application layer, from the developer’s   perspective it is a transport protocol that provides TCP’s services enhanced with  security services.

TLS uses TLS-Socket to receive messages. And then it do something with data and sent it to the actual TCP-Socket









# How it works

1. The client sends a list of cryptographic algorithms it supports, along with a client nonce.  
2. From the list, the server chooses a symmetric algorithm (for example, AES)  and a public key algorithm (for example, RSA with a specific key length), and  HMAC algorithm (MD5 or SHA-1) along with the HMAC keys. It sends back  to the client its choices, as well as a certificate and a server nonce. 