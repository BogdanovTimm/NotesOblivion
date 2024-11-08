# What it is?

It allow you to change your nginx to only listen to localhost

# How to set this?

1) Your confing need to look like:
    ```
    http {
        server {
            listen 127.0.0.01:80;
        }
    }
    ```
2) `netstat -a` - you need to see that nginx listens on 127.0.0.1:80