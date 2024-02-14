#               What it is?

It define how gitlab will clone repository:
- `fetch` – сохраняет в раннере копию репозитория, удаляя любые изменения при помощи git
- `clean` – самый быстрый метод и метод по-умолчанию
- `clone` – заново клонирует репозиторий в каждой задаче, самый медленный метод
- `none` – не клонирует репозиторий








#           Code

```YAML
<job_name>:
  variables:
    GIT_STRATEGY: {fetch | clean | clone | none}
    #? How many commits to copy
    GIT_DEPTH: 20
    #? Ablosule path to project to clone
    GIT_CLONE_PATH: $CI_BUILDS_DIR/$CI_PROJECT_PATH_SLUG
```