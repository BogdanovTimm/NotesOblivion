#                  What it is?

It is the door by which 2 PCs may communicate with each other:
```
    PC1             PC1     
+----------+    +----------+
| Socket-1*------*Socket-2 |
|          |    |          |
+----------+    +----------+
```

Socket consists of:
* UDP-Socket:
    * Other Socket's IP-Address
    * Other Socket's Port-Number
* TCP-Socket:
    * Other-Socket's IP-Address
    * Other-Socket's Port-Number
    * Its own        IP-Address
    * Its own        Port-Number

#                  Layers

It uses:
* Application Layer
* Transport Layer - developer might choose whether to use TCP or UDP and other minor stuff