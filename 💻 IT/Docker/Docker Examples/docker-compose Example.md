```YAML
#? [docker-compose up --detach --build] - command to run this file
services:
    frontend_container_name_from_docker_compose:
        #? container_name is just an alias to use this in docker comands
        container_name: frontend_alias
        build:
            context: /home/tim/counter-frontend-master
            dockerfile: Dockerfile
        # restart: unless-stopped
        #? 127.0.0.1 means that this container may be reached only from this host. First port  is port in which you need to do curl. Second port is port within docker container
        ports:
            - 127.0.0.1:3000:3000
        #expose:
        #    - 3000
        #networks:
        #    - full-stack_network


    backend_container_name_from_docker_compose:
        container_name: backend_alias
        build:
            context: /home/tim/counter-backend-master
            dockerfile: Dockerfile
        # restart: unless-stopped
        ports:
            - 127.0.0.1:8080:8080
        #expose:
        #    - 8080
        #networks:
        #    - full-stack_network        

    nginx_container_name_from_docker_compose:
        container_name: nginx_alias
        image: nginx:latest
        #? Copy configuration for nginx from local PC to docker container
        volumes:
            - /home/tim/nginx_image/configuration.txt:/etc/nginx/conf.d/default.conf
        ports:
            - 80:80
        #expose:
        #    - 80
        #networks:
        #    - full-stack_network

#networks:
#    full-stack_network:
#        driver: bridge
```