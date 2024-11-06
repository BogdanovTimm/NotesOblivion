# What it is?

SWARM can work not only with single Docker-Image, but also with Docker-Compose that include multiple Docker-Images, that works together (for example, back-end application and SQL-Database for it)









# Installation

1) First of all, you need to install Docker-Engine, Docker-CLI and Docker-Compose at least on the SWARM-Manager PC (I don't know whethber it needs to be installed on each SWARM-Worker PCs). 
2) Also, you need a working Docker-Registry: either your own, or Docker-Hub. We will use self-hosted:
    1) `docker service create --name registry --publish published=5000,target=5000 registry:2`
    2) `docker service ls` - check that Docker-Registry works
    3) `curl http://localhost:5000/v2/` - check that you can HTTP-GET to our self-hosted Docker-Registry
3) We will create our default application:
    1) `vim /path/to/applicaiton/app.py`
        ```Python
        from flask import Flask
        from redis import Redis
        app = Flask(__name__)
        redis = Redis(host='redis', port=6379)
        @app.route('/')
        def hello():
            count = redis.incr('hits')
            return 'Hello World! I have been seen {} times.\n'.format(count)
        if __name__ == "__main__":
            app.run(host="0.0.0.0", port=8000, debug=True)
        ```
    2) `vim /path/to/applicaiton/requirements.txt`:
        ```
        flask
        redis
        ```
    3) `vim /path/to/applicaiton/Dockerfile`:
        ```Dockerfile
        # syntax=docker/dockerfile:1
        FROM python:3.4-alpine
        ADD . /code
        WORKDIR /code
        RUN pip install -r requirements.txt
        CMD ["python", "app.py"]
        ```
    4) `vim /path/to/application/compose.yml`:
        ```YAML
          services:
            web:
              image: 127.0.0.1:5000/stackdemo # Registry address
              build: .
              ports:
                - "8000:8000"
            redis:
              image: redis:alpine
        ```
    5) `docker compose up -d`
    6) `docker compose ps` - check that Docker-Compose works
    7) `curl http://localhost:8000` - check that applicaiton works
    8) `docker compose down --volumes` - close the applicaiton
4) `docker compose push` - push your applicaiton to the Docker-Hub or self-hosted Docker-Registry
5) `docker stack deploy --compose-file /path/to/applicaiton/compose.yml xSWARM_STACKx`
6) `docker stack services xSWARM_STACKx` - check that SWARM-Stack works
7) `curl http://localhost:8000` - check that applicaiton works
8) (optional) `docker stack rm xSWARM_STACKx` - 
9) (optional) `docker service rm registry` - if you started self-hosted Docker-Registry
10) (optional) `docker swarm leave --force` - if you want to exit from SWARM-Mode