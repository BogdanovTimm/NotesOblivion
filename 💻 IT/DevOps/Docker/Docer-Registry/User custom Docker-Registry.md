# How to do this

1) `vim /etc/docker/daemon.json`
2) Add here:
    ```
    {
        "registry-mirrors": [
            "https://xCUSTOM.DOCKER.REGISTRY.COMx"
        ]
    }
    ```
3) `sudo systemctl restart docker`
4) `sudo docker pull xDOCKER_IMAGEx`