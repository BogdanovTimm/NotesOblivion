1. Use Linux or it will not work
2. Install Docker
3. `sudo mkdir -p /srv/gitlab`
4. `sudo vim /etc/ssh/sshd_config` and add: `Port 55522` - now you can connect to your server via SSH on port 55522
5. `sudo systemctl restart ssh`
6. Use this command:
```BASH
sudo docker run                                                          \
  --detach                                                               \
  --hostname 176.123.168.2                                               \
  --env GITLAB_OMNIBUS_CONFIG="external_url 'http://176.123.168.2'"      \
  --publish 443:443                                                      \
  --publish 80:80                                                        \
  --publish 22:22                                                        \
  --name gitlab                                                          \
  --restart always                                                       \
  --volume /srv/gitlab/config:/etc/gitlab                                \
  --volume /srv/gitlab/logs:/var/log/gitlab                              \
  --volume /srv/gitlab/data:/var/opt/gitlab                              \
  --shm-size 256m                                                        \
  gitlab/gitlab-ee:latest
```
And here is this command as a one-liner:
```BASH
sudo docker run --detach --hostname 176.123.168.2 --env GITLAB_OMNIBUS_CONFIG="external_url 'http://176.123.168.2'" --publish 443:443 --publish 80:80 --publish 22:22 --name gitlab --restart always --volume /srv/gitlab/config:/etc/gitlab --volume /srv/gitlab/logs:/var/log/gitlab --volume /srv/gitlab/data:/var/opt/gitlab --shm-size 256m gitlab/gitlab-ee:latest
```
5. `sudo docker logs -f gitlab` - check progress
6. `sudo docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password` - find password for root user
7. `sudo ufw allow 5050` - open Container Registry Port
8. `sudo vim /etc/gitlab/gitlab.rb` and add this line: `registry_external_url 'http://176.123.168.2:5050'` - enable container Registry