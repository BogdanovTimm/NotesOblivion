```YAML
stages:
  - build
  - test
  - publish

variables:
  POETRY_IMAGE: registry.devops-teta.ru/materials/ci/images/poetry:1.4.1-3.11.6-bookworm
  KANIKO_IMAGE: registry.devops-teta.ru/materials/ci/images/kaniko:1.9.1
  POETRY_CACHE_DIR: .cache/poetry
  PIP_CACHE_DIR: .cache/pip
  GIT_CLONE_PATH: $CI_BUILDS_DIR/$CI_PROJECT_PATH_SLUG

default:
  before_script:
    - set -eu
 


Update Cache:
  stage: .pre
  needs: []
  image: &poetry_image
    name: $POETRY_IMAGE
    entrypoint: [""]
  cache:
    - &poetry_packages
      key: poetry-packages
      paths:
        - .cache
      unprotect: true
    - &poetry_venv
      key:
        prefix: poetry-venv
        files:
          - poetry.lock
      paths:
        - .venv
      unprotect: true
  script:
    - &poetry_install poetry install --no-root --no-interaction
  rules:
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
      allow_failure: true
 


Build Package:
  stage: build
  needs:
    - job: Update Cache
      artifacts: false
  image:
    name: $POETRY_IMAGE
    entrypoint: [""]
  cache:
    - <<: *poetry_packages
      policy: pull
    - <<: *poetry_venv
      policy: pull
  script:
    - *poetry_install
    - mkdir -p dist
    - poetry export --without-hashes --format constraints.txt --output dist/constraints.txt
    - poetry run python -m pip wheel --isolated --requirement dist/constraints.txt --wheel-dir dist/vendor
    - poetry build --format wheel
  artifacts:
    paths:
      - dist
  rules:
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
      allow_failure: true



Test:
  stage: test
  needs:
    - job: Update Cache
    artifacts: false
  allow_failure: true
  image:
    name: $POETRY_IMAGE
    entrypoint: [""]
  script:
    - poetry install --no-interaction
    - poetry run pytest --junitxml python.junit.xml
  artifacts:
    #? Will create output file even if tests fail
    when: always
    paths:
      - python.junit.xml
    reports:
      junit: python.junit.xml
  rules:
    - &on_merge_request
      if: $CI_PIPELINE_SOURCE == "merge_request_event"
    - &on_default_branch
      if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH



Publish Package:
  stage: publish
  needs:
    - job: Build Package
      artifacts: true
    - job: Test
      artifacts: true
  interruptible: false
  image:
    name: $KANIKO_IMAGE
    entrypoint: [""]
  script:
    - b64_auth=$(printf '%s:%s' "$CI_REGISTRY_USER" "$CI_REGISTRY_PASSWORD" | base64 | tr -d '\n')
    - >-
      printf '{"auths": {"%s": {"auth": "%s"}}}' "$CI_REGISTRY" "$b64_auth"
      >/kaniko/.docker/config.json
    - >-
      /kaniko/executor
      --cache
      --use-new-run
      --skip-unused-stages
      --context "$CI_PROJECT_DIR"
      --dockerfile "$CI_PROJECT_DIR/Dockerfile"
      --destination "$CI_REGISTRY_IMAGE:${CI_COMMIT_REF_SLUG}_${CI_COMMIT_SHORT_SHA}"
      --cache-repo "$CI_REGISTRY_IMAGE/cache"
  rules:
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
      allow_failure: true
```