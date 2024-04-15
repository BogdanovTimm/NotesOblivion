1. kANIKO.YAML:
```yaml
.job__kaniko_publish_image:
  extends:
    - .job__shallow_clone
  image:
    name: $KANIKO_IMAGE
    entrypoint: [""]
  script:
    - if [ -z "${IMAGE_TAG:-}" ]; then echo "IMAGE_TAG is not defined" ; exit 1 ; fi
    - b64_auth=$(printf '%s:%s' "$HARBOR_USER" "$HARBOR_PASSWORD" | base64 | tr -d '\n')
    - >-
      printf '{"auths": {"%s": {"auth": "%s"}}}' "$HARBOR_HOST" "$b64_auth"
      >/kaniko/.docker/config.json
    - >-
      /kaniko/executor
      --cache
      --use-new-run
      --skip-unused-stages
      --context "$CI_PROJECT_DIR"
      --dockerfile "$CI_PROJECT_DIR/Dockerfile"
      --destination "$HARBOR_HOST/$HARBOR_PROJECT/$CI_PROJECT_NAME:$IMAGE_TAG"
      --cache-repo "$HARBOR_HOST/$HARBOR_PROJECT/$CI_PROJECT_NAME/cache"
```
2. harbor.yml:
```YAML
variables:
    HARBOR_HOST: harbor.devops-teta.ru
    HARBOR_PROJECT: demo
    HARBOR_USER: robot_demo+gitlab
    HARBOR_PASSWORD: $__HARBOR_PASSWORD
```