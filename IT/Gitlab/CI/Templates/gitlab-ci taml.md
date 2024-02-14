```YAML
stages:
  - build
  - publish

default:
  before_script:
    - set -eu

variables:
  NODEJS_IMAGE: registry.devops-teta.ru/materials/ci/images/nodejs:18.18.2-bookworm
  KANIKO_IMAGE: registry.devops-teta.ru/materials/ci/images/kaniko:1.9.1
  NEXT_TELEMETRY_DISABLED: "1"
  NPM_CONFIG_CACHE: $CI_PROJECT_DIR/.cache/npm
  ENABLE_LINT: "true"



Update Cache:
  stage: .pre
  needs: []
  image: &nodejs_image
    name: $NODEJS_IMAGE
    entrypoint: [""]
  cache:
    - &npm_packages
      key: npm-packages
      paths:
        - .cache
      unprotect: true
    - &npm_node_modules
      key:
        prefix: npm-node-modules
        files:
          - package-lock.json
      paths:
        - node_modules
      unprotect: true
  script:
    - &npm_clean_install
      if [ ! -e node_modules ] ; then npm clean-install ; fi
  #? When to run this job
  rules:
    - if: $CI_PIPELINE_SOURCE == "merge_request_event"
      #? If this job fails - others will not be cancelled
      allow_failure: true
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
      allow_failure: true
    - if: $CI_COMMIT_TAG =~ /v?[0-9]+(\.[0-9]+){2}/
      allow_failure: true



# @NoArtifactsToSource
Lint:
  stage: .pre
  needs:
    - job: Update Cache
      artifacts: false
  allow_failure: true
  image: *nodejs_image
  variables:
    ESLINT_CODE_QUALITY_REPORT: eslint.codequality.json
  cache:
    - <<: *npm_packages
      #? Means that cache will not be updated
      policy: pull
    - <<: *npm_node_modules
      policy: pull
  script:
    - *npm_clean_install
    - npm run lint -- --format gitlab
  artifacts:
    paths:
      - $ESLINT_CODE_QUALITY_REPORT
    reports:
      codequality: $ESLINT_CODE_QUALITY_REPORT
  rules:
    - if: $ENABLE_LINT != "true"
      #? Even if other [ifs] will be true - this job will not be runned
      when: never
    - &on_merge_request
      if: $CI_PIPELINE_SOURCE == "merge_request_event"
    - &on_default_branch
      if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH



# @NoArtifactsToSource
Build Package:
  stage: build
  needs:
    - job: Update Cache
      artifacts: false
  image: *nodejs_image
  cache:
    - <<: *npm_packages
      policy: pull
    - <<: *npm_node_modules
      policy: pull
    - key: npm-next-cache
      paths:
        - .next/cache
  script:
    - *npm_clean_install
    - npm run build
    - mv .next/standalone dist
    - mv public dist/public
    - mv .next/static dist/.next/static
  artifacts:
    expire_in: 1h
    paths:
      - dist
  rules:
    - *on_merge_request
    - *on_default_branch
    - &on_release_tag
      if: $CI_COMMIT_TAG =~ /v?[0-9]+(\.[0-9]+){2}/



Publish Package:
  stage: publish
  needs:
    - job: Build Package
      #? Gets artifacts from this job
      artifacts: true
  #? This job will not be cancelled if another instance of this job will be called
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
      --destination "$CI_REGISTRY_IMAGE:$IMAGE_TAG"
      --cache-repo "$CI_REGISTRY_IMAGE/cache"
  rules:
    - <<: *on_default_branch
      #? If this [if] is equal to true - creates a variable
      variables:
        IMAGE_TAG: ${CI_COMMIT_BRANCH}_${CI_COMMIT_SHORT_SHA}
    - <<: *on_release_tag
      variables:
        IMAGE_TAG: $CI_COMMIT_TAG
```