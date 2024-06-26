#                  Show something

- `ip address show` - shows your network cards and each IPv4|6 address for them:
    - `scope glogal` means that this hardware network card is open to internet. `scope link` is not open to internet.
    - `dynamic` - was taken from DHCP
- `ip route show` - shows gateways (roters to which all packages need to be send if they are needed to be send in internet)
    - `default` - default one
- `ip link set dev xCARD_NAMEx down`