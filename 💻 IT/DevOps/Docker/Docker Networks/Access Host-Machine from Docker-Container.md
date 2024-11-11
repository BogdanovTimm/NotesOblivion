# What it is?

Sometimes you have both on your host machine:
* Docker-Container
* Some non-Docker applicaiton

And you need to access non-Dcoker applciation from the Docker-Containter.









# How to do it

## Connect to Docker-Virtual-Network-Card

For each for its Docker-Virtual-Network of the type `bridge`, Docker creates a Docker-Virtual-Network-Card with some IP-Address. So, you can:
1) `docker network create --driver bridge xDOCKER_NETWORKx --subnet=222.222.222.0/24 --gateway=222.222.222.1` - create a Docker_Virtual-Network with Docker-Virtual-Network-Card with IP-Address 222.222.222.1
2) Configura your host-application:
    1) `vim /etc/nginx/sites-available/default` and add to this:
    ```conf
    listen     localhost:80;
    listen 222.222.222.1:80; # Docker-Virtual-Network-Card
    allow      localhost;
    allow  222.222.222.2;    # Docker-Container IP-Address
    deny             all;
    ```
3) `docker run --network=xDOOCKER_NETWORKx --ip=222.222.222.2 xDOCKER_IMAGEx` - now, if within Docker-Container you do `ping 222.222.222.1:80`, it will work
```