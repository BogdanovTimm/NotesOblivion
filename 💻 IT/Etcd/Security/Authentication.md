#                  Installation

Code:
```shell
export ETCDCTL_API=3
ENDPOINTS=localhost:2379

# v-- Creating Role: root --v
/path/to/etcdctl --endpoints=${ENDPOINTS} role add root
/path/to/etcdctl --endpoints=${ENDPOINTS} role get root
# ^-- Creating Role: root --^

# v-- Creating User: root --v
/path/to/etcdctl --endpoints=${ENDPOINTS} user add root
/path/to/etcdctl --endpoints=${ENDPOINTS} user grant-role root root
# ^-- Creating User: root --^

/path/to/etcdctl --endpoints=${ENDPOINTS} user get root # Log as root

# v-- Creating Role: role0 --v
/path/to/etcdctl --endpoints=${ENDPOINTS} role add role0
/path/to/etcdctl --endpoints=${ENDPOINTS} role grant-permission role0 readwrite foo
# ^-- Creating Role: role0 --^

# v-- Creating User: user0 --v
/path/to/etcdctl --endpoints=${ENDPOINTS} user add user0
/path/to/etcdctl --endpoints=${ENDPOINTS} user grant-role user0 role0
# ^-- Creating User: user0 --^

/path/to/etcdctl --endpoints=${ENDPOINTS} auth enable # Enable authentication

/path/to/etcdctl --endpoints=${ENDPOINTS} --user=user0:xPASSWORDx put foo bar # Put value as [user0]
/path/to/etcdctl --endpoints=${ENDPOINTS} get foo                             # Error
/path/to/etcdctl --endpoints=${ENDPOINTS} --user=user0:xPASSWORDx get foo     # Success
```