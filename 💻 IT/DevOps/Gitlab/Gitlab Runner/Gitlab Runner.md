#               What it is?

**Gitlab Runner** is an application that allows you to create CI/CD pipelines.







#            Installation

1. **Install** an application:
	- **Windows** - [Install GitLab Runner on Windows | GitLab](https://docs.gitlab.com/runner/install/windows.html)
	- **Linux** - [Install GitLab Runner using the official GitLab repositories | GitLab](https://docs.gitlab.com/runner/install/linux-repository.html)
	- **Docker** - [Run GitLab Runner in a container | GitLab](https://docs.gitlab.com/runner/install/docker.html)
2. Go to your **Gitlab** and sign in
3. Choose an existing Project or create a new one
4. Go to **Settings / CI/CD / Runners** and find **Registartion Token**
5. Register current instance of a **Gitlab runner** - [Registering runners | GitLab](https://docs.gitlab.com/runner/register/index.html)
6. Go to **Settings / Access Tokens**, **create a new token** and **save it** on your PC in some **X_file_with_token.txt_X**
7. Create `.gitlab-ci.yml` file in your project