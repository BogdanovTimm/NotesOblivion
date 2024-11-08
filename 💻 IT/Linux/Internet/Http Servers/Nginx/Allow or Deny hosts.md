# What it is?

You may allow/deny HTTP-Requests from certain hosts

# How to set this?

Your confing need to look like:
```
http {
    server {
        allow 111.111.111.111;
        allow 222.222.222.222;
        deny  all;
    }
}
```