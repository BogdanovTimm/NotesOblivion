#                  Kerberos

1. Add this lines to `/path/to/unpacked/kafka/config/server.properties`:
```
authorizer.class.name=kafka.security.authorizer.AclAuthorizer
allow.everyone.if.no.acl.found=true
```