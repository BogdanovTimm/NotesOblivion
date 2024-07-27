```
server {
    #? Port on which Nginx will listen
    listen 80;
    
    #? [_] means localhost
    server_name _;
    
    #? If HTTP-Request goes into [server_name]/ then proxy this HTTP-Request to given address
    location / {
        #? If you work with Docker, you need to insert here actual name of the container within your docker-compose.yaml file
        proxy_pass http://frontend_container_name_from_docker_compose:3000;
    }
    
    #? If HTTP-Request goes into [server_name]/api then proxy this HTTP-Request to given address
    location /api {
        proxy_pass http://backend_container_name_from_docker_compose:8080;
    }
}
```