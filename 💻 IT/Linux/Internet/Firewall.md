# Linux Firewalls

- IP Tables
- Selinux
- TCPwrappers

# Display current settings

`iptables -L`

# Save settings

`iptables-save > /etc/iptables/rules.v4` - By default, iptables rules get automatically removed after the system reboot, but you can use the following command to make the rules persistent.