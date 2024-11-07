# What it is?

Sometimes you have both on your host machine:
* Docker-Container
* Some non-Docker applicaiton

And you need to access non-Dcoker applciation from the Docker-Containter.









# How to do it

## Use Docker-Network-Port-Forwarding

`docker run --publish 55555:44444 xDOCKER_IMAGEx` - now, within the Docker-Container, if you do `ping localhost:44444`, actually you will `ping host-machine:55555`

`docker run --publish 127.0.0.1:55555:44444 xDOCKER_IMAGEx` - same as above, but only localhost connections are allowed.









## Add variable

`docker run -d --add-host host.docker.internal:host-gateway xDOCKER_IMAGEx` - now, if within Docker-Container you do `ping host.docker.internal:44444`, it actually will do `ping host-machine:44444`









## Use Docker-Compose with `extra_hosts`

Create a docker-compose file:

```YAML
version: "3"
services:
  web:
    build: .
    ports:
      - "55555:44444"
    extra_hosts:
      - "host.docker.internal:host-gateway"
```