1. `sudo apt-get update`
2. `sudo apt-get install ca-certificates curl`
3. `sudo install -m 0755 -d /etc/apt/keyrings`
4. `sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc`
5. `sudo chmod a+r /etc/apt/keyrings/docker.asc`
6. `bash echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null`
7. `sudo apt-get update`
8. `sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin`