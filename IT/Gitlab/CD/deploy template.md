```YAML
stages:
  - deploy

variables:
  GIT_CLONE_PATH: $CI_BUILDS_DIR/$CI_PROJECT_PATH_SLUG
  COMPOSE_PROJECT_NAME: $CI_PROJECT_PATH_SLUG

default:
  before_script:
    - set -eu
 


Deploy - Prom:
  tags:
    - deploy
    - prom
  environment:
    name: prom
    deployment_tier: production
  script:
    - |-
      for script in $(find 'env' "env/$CI_ENVIRONMENT_NAME" -maxdepth 1 -type f -name '*.env'); do
        printf >&2 'reading environment variables from %s\n' "$script"
        eval "$(sed -e 's/^/export /' <"$script")"
      done
    - docker-compose up --remove-orphans --detach
  rules:
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
```