```TOML
concurrent = 1

[[runners]]
  name = "Deploy runner"
  url = "https://git.devops-teta.ru"
  executor = "shell"
  shell = "bash"
  #? Maximal amount of concurrent jobs
  limit = 1
  builds_dir = "/data/gitlab-runner/builds"
  cache_dir = "/data/gitlab-runner/cache"
  #? разрешить ли использование опции [GIT_CLONE_PATH], переопределяющей путь клонирования проекта;
  [runners.custom_build_dir]
    enabled = true
```