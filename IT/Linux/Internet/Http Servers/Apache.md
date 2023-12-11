# Installation

1. `sudo apt update`
2. `sudo apt install apache2`

# Create new site

1. `sudo nano /var/www/html/%websitename.com%/public_html/index.html`
2. `cd /etc/apache2/sites-available/`
3. `sudo cp 000-default.conf %newconfigname%.conf`
4. `sudo nano %newconfigname%.conf` and add this lines:
```
ServerAdmin youremail@gmail.com
DocumentRoot /var/www/%websitename%/
ServerName %www.sitename.com%
```
5. `sudo a2ensite gci.conf` - it will give you command to run
6. command from output of previous step (for example, `systemctl reload apache2`)
7. `sudo ufw app list`
8. `sudo ufw allow 'Apache Full'`
9. `sudo ufw enable`
10. `sudo ufw status` - need to be active
11. `sudo nano /etc/hosts` and write to is:
```
127.0.1.1 %www.sitename.com%  
```