# Installation
1. `sudo apt install mysql-server`
2. `sudo service mysql status`
3. `sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf` and change it to be:
```
bind-adress = 192.168.0.5
```
Where `192.168.0.5` is IPv4 address of your server