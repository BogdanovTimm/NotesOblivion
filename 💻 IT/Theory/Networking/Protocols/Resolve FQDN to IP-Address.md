#                  What it is

It is the protcol that finds IP-Address of a PC given its FQDN (Fully Qualified Domain Name).









#                  DNS

##                 Domains

Domains are organised like:
`grand-child.child.parent.grand-parent.` - No, last dot is not a mistake - it refers to a special null domain that all FQDNs actually have as its most top part




##                 How it works

DNS uses 2 Resolution Techniques:
* Iterative Resolution:
    1. `User` asks `DNS-Resolver-Client` to find IP-Address for a given FQDN `lorem.ipsum.com.`
    2. `DNS-Resolver-Client` asks `Root-DNS-Name-Server` where is `DNS-Name-Server` that knows something about a domain `com.`
    3. `Root-DNS-Name-Server` replies with information about how to find `DNS-Name-Server` that knows about the domain `com.`
    4. `DNS-Resolver-Client` asks `DNS-Name-Server` that knows about `.com.` where is `DNS-Name-Server` that knows something about a domain `ipsum.`
    5. `DNS-Name-Server` that knows about `.com.` replies with information about how to find `DNS-Name-Server` that knows about the domain `ipsum.`
    6. `DNS-Resolver-Client` asks `DNS-Name-Server` that knows about `.ipsum.` where is `DNS-Name-Server` that knows something about a PC named `lorem`
    7. `DNS-Name-Server` that knows about `.ipsum.` replies with IP-Address of the PC named `lorem`
* Recursive Resolution:
    1. `User` asks `DNS-Resolver-Client` to find IP-Address for a given FQDN `lorem.ipsum.com.`
    2. `DNS-Resolver-Client` asks `Root-DNS-Name-Server` to give it the IP-Address of the PC named `lorem` 
    3. `Root-DNS-Name-Server` asks `DNS-Name-Server` that knows about `.com.` to give it the IP-Address of the PC named `lorem`
    4. `DNS-Name-Server` that knows about `.com` asks `DNS-Name-Server` that knows about `.ipsum.` to give it the IP-Address of the PC named `lorem`
    5. `DNS-Name-Server` that knows about `ipsum` gives `DNS-Name-Server` that knows about `.com` the IP-Address of the PC named `lorem`
    6. `DNS-Name-Server` that knows about `.com` gives `Root-DNS-Name-Server` the IP-Address of the PC named `lorem`
    7. `Root-DNS-Name-Server` gives `DNS-Resolver-Client` the IP-Address of the PC named `lorem`



##                 Storing Formats

DNS stores FQDNs and its IPs in 2 formats:
* Resource Record Field Format - Binary
* Master File - Human-readable text





##                 CNAME

CNAME is an alias for a FQDN. For example, we may say: resolve `lorem.ipsum.com.` as `www.ipsum.com.`





##                 Reverse Name Resolution

It is when we find a FQDN from a given IP-Address