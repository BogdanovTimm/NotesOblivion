# IKE

When a VPN has a small number of end points, the network administrator can manually enter the SA (aka Security Association - Networking-Level logical connection for VPN) information (encryption/authentication algorithms and keys, and the SPIs) into the SADs (SA-Database) of the  endpoints. 

Such “manual keying” is clearly impractical for a large VPN, which  may consist of hundreds or even thousands of IPsec routers and hosts. 

Large, geographically distributed deployments require an automated mechanism for creating  the SAs. IPsec does this with the Internet Key Exchange (IKE) protocol, specified  in RFC 5996.