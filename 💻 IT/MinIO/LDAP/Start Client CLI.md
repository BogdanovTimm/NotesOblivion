1. `./mc alias set 'xNEW_CONNECTION_NAMEx' 'https://minio.server.address.com:9000' 'admin' 'password'`
2. Add user's credentials
```shell
./mc                                                 \
    idp                                              \
    ldap                                             \
    add                                              \
    xNEW_CONNECTION_NAMEx                            \
    server_addr="ldap.server.address.com"            \
    lookup_bind_dn="CN=John Doe,OU=Grandchild Group,OU=Child Group,OU=Parent Group,DC=domain,DC=mts,DC=com" \
    lookup_bind_password="xLDAP_USER_PASSWORDx"      \
    user_dn_search_base_dn="DC=domain,DC=mts,DC=com" \
    user_dn_search_filter="(sAMAccountName=%s)"
```
Where:
    - `lookup_bind_dn` - you may find it in Active Directory Users and Computers. You need to View/Advanced Features. Then you need to find your user using finder. Then you need to go to 'Member of' tab and choose Users. Then you need to go to 'Attribute Editor' tab and find 'distinguishedName'.
    - `user_dn_search_base_dn` - you may find it in Active Directory Users and Computers. You need to View/Advanced Features. Then you need to find 'Users' folder. Right click on 'Users'. Then you need to go to 'Attribute Editor' tab and find 'distinguishedName'. You need everything except "CN=Users"
3. Add policy to user:
```shell
./minio_client idp         \
    ldap                   \
    policy                 \
    attach                 \
    xCONNECTION_NAMEx      \
    xPOLICY_NAMEx          \
    --user="xUSER_NAMEx"
```