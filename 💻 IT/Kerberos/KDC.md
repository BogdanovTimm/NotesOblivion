#                  What it is

KDC is a server that implemets Kerberos protocol

KDC consists of:
- **Database** - usernames, passwords, permissions. In Windows it is Active Directory
- **Authentication Server** - creates Session Key encrypted by user's secret key. gives Ticket Granting Tickets
- **Ticket Granting Server** - gives Service Tickets (authentication)
