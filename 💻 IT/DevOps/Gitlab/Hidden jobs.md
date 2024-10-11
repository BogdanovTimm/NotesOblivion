#                    What it is?

You may create hidden jobs that will not be runned








#                     Code

```YAML
variables:
  KANIKO_IMAGE: registry.devops-teta.ru/materials/ci/images/kaniko:1.9.1
  IMAGE_TAG: ""


.hidden_job_name:
  image:
    name: $KANIKO_IMAGE
    entrypoint: [""]
  script:
    - if [ -z "${IMAGE_TAG:-}" ]; then echo "IMAGE_TAG is not defined" ; exit 1 ; fi
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
```