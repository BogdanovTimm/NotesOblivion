1. Use Linus, or it will not work
2. Install Docker
3. Use this command:
```BASH
sudo docker run                                                        \
--detach                                                               \
--hostname gitlab.example.com                                          \
--env GITLAB_OMNIBUS_CONFIG="external_url 'http://192.168.0.102'"      \
--publish 192.168.0.102:443:443                                        \
--publish 192.168.0.102:80:80                                          \
--publish 192.168.0.102:22:22                                          \
--name gitlab                                                          \
--restart always                                                       \
--volume /srv/gitlab/config:/etc/gitlab                                \
--volume /srv/gitlab/logs:/var/log/gitlab                              \
--volume /srv/gitlab/data:/var/opt/gitlab                              \
--shm-size 256m                                                        \
gitlab/gitlab-ee:latest
```