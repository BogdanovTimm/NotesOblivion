#             Installation

1. `docker volume create gitlab-runner-config` - create new docker volume to keep configuration
2. `docker run -d --name gitlab-runner --restart always -v /var/run/docker.sock:/var/run/docker.sock -v gitlab-runner-config:/etc/gitlab-runner gitlab/gitlab-runner:latest` - run GitLab Runner container
3. `docker run --rm -it -v gitlab-runner-config:/etc/gitlab-runner gitlab/gitlab-runner:latest register` - start registration process:
    1. Enter your GitLab server domain
    2. Enter registration token that you can borrow from your GitLab website in **Settings\CI/CD\Runners**
    3. Enter your Runner's name
    4. Enter tags for this Runner (see [[Tags]])
    5. Enter `shell` when you will asked about executor
4. *(Optional)* Next, go to your GitLab website, **Settings\CI/CD\Runners**, click on pen to edit your Runner and choose **Run untagged jobs**
5. *(Optional*) `sudo visudo`  and add `root ALL=NOPASSWD: ALL`