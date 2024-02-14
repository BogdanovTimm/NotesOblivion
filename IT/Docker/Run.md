# Working with Docker

  

## Creating a Docker-Image of your applicaiton

1. Add a pre-defined `Dockerfile` file to your project root folder.
2. Run `docker build -t %docker_acount_name%/%application_name%:%major_version%.%minor_version%.%patch_version% .` (yes, with dot in the end) in your project's root folder
3. Go to DockerDesktop and Push recently created container to DockerHub
5. Add a pre-defined `docker-compose.yaml`
6. Run `docker-compose up` in your project's root folder

## Running Docker-Image

1. `run --detach --name %container_name% --publish 0.0.0.0:%8080 (host port)%:%80 (container port)%/tcp %image_name:version%` where:
	- `--deatch` - runs in the background

# Display information

`docker inspect %container_name% | less`