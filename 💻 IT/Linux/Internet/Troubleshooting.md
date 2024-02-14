# Check the Internet Connectivity

First of all, please check if the internet connection option is on and also check the cables to find if there is any issue with it.

# Verify the Network Configuration

- Please check that your network is configured correctly and the network interface has your IP address. You can check it by running the `ip addr` or `ifconfig` commands.
- You can also run the `ip route` command to check if the default gateway is set properly.
- Finally, verify the [DNS server configuration](https://www.geeksforgeeks.org/setting-up-local-dns-server-between-client-server-machines/) in the `/etc/resolv.conf` file.

# Check the Firewall

Sometimes, firewall rules block the internet connection for the system’s security. Hence, you can run the `ufw` or `iptables` command to modify the firewall rules.

# Network Interface:

You can restart your network interface through the `ifup` and `ifdown` commands. Once you restart the network interface, please reboot the system to make changes successful.